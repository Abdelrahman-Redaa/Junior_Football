import 'package:junior_football/core/error_handling/result.dart';
import 'package:junior_football/feature/auth/data/models/request_models/sign_up_request_dto.dart';
import 'package:junior_football/feature/auth/data/models/response_models/forget_password_dto.dart';
import 'package:junior_football/feature/auth/data/models/response_models/verify_otp_response.dart';

import '../models/request_models/verify-otp_request.dart';
import '../models/response_models/login_response.dart';
import '../models/response_models/register_response.dart';

abstract interface class AuthDataSource {
  Future<Result<LoginResponse>> loginWithEmailAndPassword(
    String email,
    String password,
  );

  Future<Result<LoginResponse>> loginWithGoogle({required String idToken});

  Future<Result<RegisterResponse>> signUp(SignupRequestDto signupModel);

  Future<Result<EmailVerificationResponseDto>> emailVerification(
    UserOTPDto user,
  );

  Future<Result<VerifyOtpResponse>> codeVerification(VerifyOtpRequest user);

  Future<Result<ResetPasswordResponseDto>> resetPassword(UserOTPDto user);
}
