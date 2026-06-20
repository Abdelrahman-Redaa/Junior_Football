import 'package:junior_football/core/error_handling/result.dart';
import 'package:junior_football/feature/auth/data/models/request_models/sign_up_request_dto.dart';
import 'package:junior_football/feature/auth/data/models/request_models/verify-otp_request.dart';
import 'package:junior_football/feature/auth/domain/entities/forget_password_entity.dart';

import '../../data/models/response_models/verify_otp_response.dart';
import '../entities/login_entity.dart';
import '../entities/register_entity.dart';

abstract interface class AuthRepo {
  Future<Result<LoginEntity>> loginWithEmailAndPassword(
    String email,
    String password,
  );

  Future<Result<LoginEntity>> loginWithGoogle({required String idToken});

  Future<Result<RegisterEntity>> signUp(SignupRequestDto singUpModel);

  Future<Result<EmailVerificationResponseEntity>> sendResetPasswordCode(
    UserOTPEntity user,
  );

  Future<Result<VerifyOtpResponse>> verifyResetPasswordCode(
      VerifyOtpRequest user,
  );

  Future<Result<ResetPasswordResponseEntity>> resetPassword(UserOTPEntity user);
}
