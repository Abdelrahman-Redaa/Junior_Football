import 'package:injectable/injectable.dart';
import 'package:junior_football/core/api/api_client.dart';
import 'package:junior_football/core/error_handling/execute_api.dart';
import 'package:junior_football/core/error_handling/result.dart';
import 'package:junior_football/feature/auth/data/models/request_models/login_request_dto.dart';
import 'package:junior_football/feature/auth/data/models/request_models/login_with_google_dto.dart';
import 'package:junior_football/feature/auth/data/models/request_models/sign_up_request_dto.dart';
import 'package:junior_football/feature/auth/data/models/request_models/verify-otp_request.dart';
import 'package:junior_football/feature/auth/data/models/response_models/forget_password_dto.dart';
import '../models/response_models/login_response.dart';
import '../models/response_models/register_response.dart';
import '../models/response_models/verify_otp_response.dart';
import 'auth_data_source.dart';

@LazySingleton(as: AuthDataSource)
class AuthDataSourceImpl implements AuthDataSource {
  final ApiClient _apiClient;

  AuthDataSourceImpl(this._apiClient,);

  @override
  Future<Result<LoginResponse>> loginWithGoogle({required String idToken}) =>
      executeApi(() => _apiClient.loginWithGoogle(GoogleLoginRequest(idToken: idToken)));

  @override
  Future<Result<RegisterResponse>> signUp(SignupRequestDto signupModel) =>
      executeApi(() => _apiClient.signup(signupModel));

  @override
  Future<Result<LoginResponse>> loginWithEmailAndPassword(
    String email,
    String password,
  ) => executeApi(
    () => _apiClient.login(LoginRequestDto(email: email, password: password)),
  );

  @override
  Future<Result<ResetPasswordResponseDto>> resetPassword(UserOTPDto user) =>
      executeApi(() => _apiClient.resetPassword(userOTPDto: user));

  @override
  Future<Result<EmailVerificationResponseDto>> emailVerification(
    UserOTPDto user,
  ) => executeApi(() => _apiClient.emailVerification(userOTPDto: user));

  @override
  Future<Result<VerifyOtpResponse>> codeVerification(
      VerifyOtpRequest user,
  ) => executeApi(() => _apiClient.verifyResetPasswordCode(userOTPDto: user));
}
