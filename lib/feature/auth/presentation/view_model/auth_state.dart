import 'package:equatable/equatable.dart';
import 'package:junior_football/core/base_bloc/base_state.dart';
import 'package:junior_football/feature/auth/data/models/request_models/sign_up_request_dto.dart';
import 'package:junior_football/feature/auth/data/models/request_models/verify-otp_request.dart';
import 'package:junior_football/feature/auth/domain/entities/forget_password_entity.dart';

import '../../data/models/response_models/verify_otp_response.dart';
import '../../domain/entities/login_entity.dart';
import '../../domain/entities/register_entity.dart';

class AuthState extends Equatable {
  final BaseState<LoginEntity>? loginState;
  final BaseState<RegisterEntity>? signupState;
  final BaseState<LoginEntity>? googleState;
  final BaseState<EmailVerificationResponseEntity>? emailVerificationState;
  final BaseState<VerifyOtpResponse>? codeVerificationState;
  final BaseState<ResetPasswordResponseEntity>? resetPasswordState;
  final UserOTPEntity? user;

  const AuthState({
    this.loginState,
    this.signupState,
    this.googleState,
    this.emailVerificationState,
    this.codeVerificationState,
    this.resetPasswordState,
    this.user,
  });

  AuthState copyWith({
    BaseState<LoginEntity>? loginState,
    BaseState<RegisterEntity>? signupState,
    BaseState<LoginEntity>? googleState,
    BaseState<EmailVerificationResponseEntity>? emailVerificationState,
    BaseState<VerifyOtpResponse>? codeVerificationState,
    BaseState<ResetPasswordResponseEntity>? resetPasswordState,
    UserOTPEntity? user,
  }) => AuthState(
    loginState: loginState ?? this.loginState,
    signupState: signupState ?? this.signupState,
    googleState: googleState ?? this.googleState,
    emailVerificationState: emailVerificationState ?? this.emailVerificationState,
    codeVerificationState: codeVerificationState ?? this.codeVerificationState,
    resetPasswordState: resetPasswordState ?? this.resetPasswordState,
    user: user ?? this.user,
  );

  @override
  List<Object?> get props => [
    loginState,
    signupState,
    googleState,
    emailVerificationState,
    codeVerificationState,
    resetPasswordState,
    user,
  ];
}

sealed class AuthEvent {}

class NavigateToHome extends AuthEvent {}

class NavigateToLogin extends AuthEvent {}

class NavigateToPermission extends AuthEvent {}

class NavigateToSignup extends AuthEvent {}

class NavigateToForgetPassword extends AuthEvent {}

class ShowToast extends AuthEvent {
  final String message;

  ShowToast(this.message);
}

sealed class AuthIntent {}

class NavigateToSignupIntent extends AuthIntent {}

class NavigateToLoginIntent extends AuthIntent {}

class NavigateToForgetPasswordIntent extends AuthIntent {}

class LoginIntent extends AuthIntent {
  final String email;
  final String password;

  LoginIntent(this.email, this.password);
}

class SignupIntent extends AuthIntent {
  final SignupRequestDto signupModel;

  SignupIntent(this.signupModel);
}

class GoogleIntent extends AuthIntent {}

class EmailVerificationIntent extends AuthIntent {
  final UserOTPEntity user;

  EmailVerificationIntent({required this.user});
}

class CodeVerificationIntent extends AuthIntent {
  final VerifyOtpRequest user;

  CodeVerificationIntent({required this.user});
}

class ConfirmPasswordIntent extends AuthIntent {
  final UserOTPEntity user;

  ConfirmPasswordIntent({required this.user});
}

class ReSendCodeIntent extends AuthIntent {
  final UserOTPEntity user;

  ReSendCodeIntent({required this.user});
}

//confirmEmail
class ConfirmEmailEvent extends AuthEvent {}

//sendCode
class SendCodeEvent extends AuthEvent {}

//resendCode
class ReSendCodeEvent extends AuthEvent {}

//confirmPassword
class ConfirmPasswordEvent extends AuthEvent {}

//
class ShowToastInForgetPassword extends AuthEvent {
  final String message;

  ShowToastInForgetPassword(this.message);
}
