import 'package:injectable/injectable.dart';
import 'package:junior_football/core/api/api_client.dart';
import 'package:junior_football/core/api/env.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';
import 'package:dio/dio.dart';

import 'dio_intercepter.dart';

@module
abstract class ApiModule {
  @lazySingleton
  ApiClient provideApiClient(Dio dio) {
    return ApiClient(dio, baseUrl: Env.baseUrl);
  }

  @preResolve
  @lazySingleton
  Future<Dio> provideDio(BaseOptions option, TalkerDioLogger logger) async {
    var dio = Dio(option);
    dio.interceptors.add(AuthInterceptor(dio: dio));
    dio.interceptors.add(logger);


    // final userToken = await AppLocalStorage.getSecuredString(
    //   key: LocalKeys.authToken,
    // );
    //
    // if (userToken.isNotEmpty) {
    //   dio.options.headers = {
    //     'Content-Type': 'application/json',
    //     'Authorization': 'Bearer $userToken',
    //   };
    // }

    return dio;
  }

  @lazySingleton
  BaseOptions providerOption() {
    return BaseOptions(
      baseUrl: Env.baseUrl,
      receiveTimeout: const Duration(minutes: 5),
      connectTimeout: const Duration(minutes: 1),
      sendTimeout: const Duration(minutes: 5),
    );
  }

  @lazySingleton
  TalkerDioLogger provideLogger() {
    return TalkerDioLogger(
      settings: const TalkerDioLoggerSettings(
        printRequestHeaders: true,
        printErrorHeaders: true,
        printResponseHeaders: true,
        printResponseMessage: true,
        printErrorMessage: true,
        printRequestData: true,
        printResponseData: true,
      ),
    );
  }
}
