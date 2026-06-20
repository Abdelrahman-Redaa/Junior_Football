import 'package:injectable/injectable.dart';
import 'package:junior_football/core/base_bloc/base_cubit.dart';
import 'package:junior_football/core/base_bloc/base_state.dart';
import 'package:junior_football/core/error_handling/result.dart';
import 'package:junior_football/core/services/google_auth_service.dart';
import 'package:junior_football/feature/auth/data/models/request_models/sign_up_request_dto.dart';
import 'package:junior_football/feature/auth/data/models/request_models/verify-otp_request.dart';
import 'package:junior_football/feature/auth/domain/entities/forget_password_entity.dart';
import 'package:junior_football/feature/auth/domain/repo/auth_repo.dart';
import 'package:junior_football/feature/auth/presentation/view_model/auth_state.dart';

import '../../data/models/response_models/verify_otp_response.dart';
import '../../domain/entities/login_entity.dart';
import '../../domain/entities/register_entity.dart';

@injectable
class AuthViewModel extends BaseCubit<AuthState, AuthIntent, AuthEvent> {
  AuthViewModel(this._authRepo)
    : super(
        AuthState(
          codeVerificationState: BaseState.init(),
          emailVerificationState: BaseState.init(),
          resetPasswordState: BaseState.init(),
          user: const UserOTPEntity(),

        ),
      );

  final AuthRepo _authRepo;

  @override
  void doIntent(AuthIntent intent) {
    switch (intent) {
      case LoginIntent():
        _loginWithEmailAndPassword(intent.email, intent.password);
      case SignupIntent():
        _signup(intent.signupModel);
      case GoogleIntent():
        _loginWithGoogle();
      case NavigateToSignupIntent():
        emitEvent(NavigateToSignup());
      case NavigateToLoginIntent():
        emitEvent(NavigateToLogin());
      case NavigateToForgetPasswordIntent():
        emitEvent(NavigateToForgetPassword());
      case CodeVerificationIntent():
        _codeVerification(intent.user);
      case ConfirmPasswordIntent():
        _confirmPassword(intent.user);
      case EmailVerificationIntent():
        _emailVerification(intent.user);
      case ReSendCodeIntent():
        _resendCode(intent.user);
    }
  }

  void _emailVerification(UserOTPEntity user) async {
    emit(state.copyWith(emailVerificationState: BaseState.loading()));
    final response = await _authRepo.sendResetPasswordCode(user);
    switch (response) {
      case Success<EmailVerificationResponseEntity>():
        emit(
          state.copyWith(
            emailVerificationState: BaseState.loaded(response.data),
            user: user,
          ),
        );
        emitEvent(ConfirmEmailEvent());
      case Failure<EmailVerificationResponseEntity>():
        emit(
          state.copyWith(
            emailVerificationState: BaseState.error(response.errorMessage),
          ),
        );
        emitEvent(ShowToastInForgetPassword(response.errorMessage));
    }
  }

  void _resendCode(UserOTPEntity user) async {
    emit(state.copyWith(emailVerificationState: BaseState.loading()));
    final response = await _authRepo.sendResetPasswordCode(user);
    switch (response) {
      case Success<EmailVerificationResponseEntity>():
        emit(
          state.copyWith(
            emailVerificationState: BaseState.loaded(response.data),
            user: user,
          ),
        );

        emitEvent(ReSendCodeEvent());

      case Failure<EmailVerificationResponseEntity>():
        emit(
          state.copyWith(
            emailVerificationState: BaseState.error(response.errorMessage),
          ),
        );
        emitEvent(ShowToastInForgetPassword(response.errorMessage));
    }
  }

  void _codeVerification(VerifyOtpRequest user) async {
    emit(state.copyWith(codeVerificationState: BaseState.loading()));
    final response = await _authRepo.verifyResetPasswordCode(user);
    switch (response) {
      case Success<VerifyOtpResponse>():
        emit(
          state.copyWith(
            codeVerificationState: BaseState.loaded(response.data),
          ),
        );

        emitEvent(SendCodeEvent());

      case Failure<VerifyOtpResponse>():
        emit(
          state.copyWith(
            codeVerificationState: BaseState.error(response.errorMessage),
          ),
        );
        emitEvent(ShowToastInForgetPassword(response.errorMessage));
    }
  }

  void _confirmPassword(UserOTPEntity user) async {
    emit(state.copyWith(resetPasswordState: BaseState.loading()));
    final response = await _authRepo.resetPassword(user);
    switch (response) {
      case Success<ResetPasswordResponseEntity>():
        emit(
          state.copyWith(
            resetPasswordState: BaseState.loaded(response.data),
            user: user,
          ),
        );

        emitEvent(ConfirmPasswordEvent());

      case Failure<ResetPasswordResponseEntity>():
        emit(
          state.copyWith(
            resetPasswordState: BaseState.error(response.errorMessage),
          ),
        );
        emitEvent(ShowToastInForgetPassword(response.errorMessage));
    }
  }

  void _loginWithEmailAndPassword(String email, String password) async {
    emit(state.copyWith(loginState: BaseState.loading()));
    final response = await _authRepo.loginWithEmailAndPassword(email, password);
    switch (response) {
      case Success<LoginEntity>():
        emit(state.copyWith(loginState: BaseState.loaded(response.data)));
        emitEvent(NavigateToHome());
      case Failure<LoginEntity>():
        emit(
          state.copyWith(loginState: BaseState.error(response.errorMessage)),
        );
        emitEvent(ShowToast(response.errorMessage));
    }
  }

  void _signup(SignupRequestDto signModel) async {
    emit(state.copyWith(signupState: BaseState.loading()));
    final response = await _authRepo.signUp(signModel);
    switch (response) {
      case Success<RegisterEntity>():
        emit(state.copyWith(signupState: BaseState.loaded(response.data)));
        emitEvent(NavigateToLogin());
      case Failure<RegisterEntity>():
        emit(
          state.copyWith(signupState: BaseState.error(response.errorMessage)),
        );
        emitEvent(ShowToast(response.errorMessage));
    }
  }


  Future<void> _loginWithGoogle() async {


    emit(state.copyWith(googleState: BaseState.loading()));
    final idToken = await GoogleAuthService.signInWithGoogle();
    if(idToken==null) {
      emit(state.copyWith(googleState: BaseState.error("Google Sign-In failed")));
      emitEvent(ShowToast("Google Sign-In failed"));
      return;
    }  
    final response = await _authRepo.loginWithGoogle(idToken: idToken);
    switch (response) {
      case Success<LoginEntity>():
        emit(state.copyWith(googleState: BaseState.loaded(response.data)));
        emitEvent(NavigateToHome());
      case Failure<LoginEntity>():
        emit(
          state.copyWith(googleState: BaseState.error(response.errorMessage)),
        );
        emitEvent(ShowToast(response.errorMessage));
    }
  }
}
