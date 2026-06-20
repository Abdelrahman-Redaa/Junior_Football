import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:junior_football/core/constants/end_points.dart';
import 'package:junior_football/core/constants/keys.dart';
import 'package:junior_football/core/routes/routes_name.dart';
import 'package:junior_football/core/utilities/app_local_storage.dart';
import 'package:junior_football/core/utilities/navigation_service.dart';
import 'package:junior_football/feature/auth/data/models/response_models/login_response.dart';

class AuthInterceptor extends Interceptor {
  final Dio dio;

  AuthInterceptor({required this.dio});

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await AppLocalStorage.getSecuredString(key: AppKeys.token);
    if (token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      // Avoid infinite loop if the refresh token request itself fails with 401
      if (err.requestOptions.path != EndPoint.refreshToken) {
        final isRefreshed = await callRefreshToken();
        if (isRefreshed) {
          final requestOptions = err.requestOptions;
          final newToken = await AppLocalStorage.getSecuredString(key: AppKeys.token);
          
          // Update headers for retry
          requestOptions.headers['Authorization'] = 'Bearer $newToken';
          
          try {
            final result = await dio.fetch(requestOptions);
            return handler.resolve(result);
          } catch (e) {
            log("Exception in retry after token refresh: ${e.toString()}");
            return handler.reject(err);
          }
        } else {
          // Refresh failed (e.g. refresh token expired), go to login
          await _handleLogout();
          return handler.reject(err);
        }
      } else {
        // The refresh request itself returned 401, must login again
        await _handleLogout();
        return handler.reject(err);
      }
    }
    super.onError(err, handler);
  }

  Future<bool> callRefreshToken() async {
    final refreshToken = await AppLocalStorage.getSecuredString(
      key: AppKeys.refreshToken,
    );
    final token = await AppLocalStorage.getSecuredString(key: AppKeys.token);
    
    if (refreshToken.isEmpty || token.isEmpty) return false;

    try {
      // Use a new Dio instance for the refresh call to avoid recursion/interceptor loop
      final refreshDio = Dio(BaseOptions(baseUrl: dio.options.baseUrl));
      final result = await refreshDio.post(
        EndPoint.refreshToken,
        data: {
          AppKeys.token: token,
          AppKeys.refreshToken: refreshToken,
        },
      );
      
      final loginResponse = LoginResponse.fromJson(result.data);
      if (loginResponse.token != null && loginResponse.refreshToken != null) {
        // Await saving to ensure new tokens are available for the retry
        await _saveToken(
          token: loginResponse.token!,
          refreshToken: loginResponse.refreshToken!,
        );
        return true;
      }
      return false;
    } catch (e) {
      log("callRefreshToken failed: ${e.toString()}");
      return false;
    }
  }

  Future<void> _handleLogout() async {
    log("Handling session expiration: clearing data and navigating to login.");
    await AppLocalStorage.clearAllSecuredData();
    await AppLocalStorage.clearAllData();
    NavigationService.pushNamedAndRemoveUntil(AppRoutes.loginView);
  }

  Future<void> _saveToken({required String token, required String refreshToken}) async {
    await AppLocalStorage.setSecuredString(key: AppKeys.token, value: token);
    await AppLocalStorage.setSecuredString(
      key: AppKeys.refreshToken,
      value: refreshToken,
    );
  }
}
