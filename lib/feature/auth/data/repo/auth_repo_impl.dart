import 'package:injectable/injectable.dart';
import 'package:junior_football/core/constants/keys.dart';
import 'package:junior_football/core/error_handling/result.dart';
import 'package:junior_football/core/utilities/app_local_storage.dart';
import 'package:junior_football/feature/auth/data/data_source/auth_data_source.dart';
import 'package:junior_football/feature/auth/data/models/request_models/sign_up_request_dto.dart';
import 'package:junior_football/feature/auth/data/models/request_models/verify-otp_request.dart';
import 'package:junior_football/feature/auth/data/models/response_models/forget_password_dto.dart';
import 'package:junior_football/feature/auth/data/models/response_models/login_response.dart';
import 'package:junior_football/feature/auth/data/models/response_models/register_response.dart';
import 'package:junior_football/feature/auth/domain/entities/forget_password_entity.dart';
import 'package:junior_football/feature/auth/domain/repo/auth_repo.dart';
import 'package:junior_football/feature/auth/mapper/forget_password_mapper.dart';
import '../../domain/entities/login_entity.dart';
import '../../domain/entities/register_entity.dart';
import '../../mapper/login_mapper.dart';
import '../../mapper/register_mapper.dart';
import '../models/response_models/verify_otp_response.dart';

@LazySingleton(as: AuthRepo)
class AuthRepoImpl implements AuthRepo {
  final AuthDataSource _authDataSource;

  AuthRepoImpl(this._authDataSource);



  @override
  Future<Result<LoginEntity>> loginWithGoogle({required String idToken}) async {
    final result = await _authDataSource.loginWithGoogle(idToken: idToken);
    switch (result) {
      case Success<LoginResponse>():
        final data=result.data;
        _saveToken(token: data.token!, refreshToken: data.refreshToken!);
        return Success(data.toEntity());
      case Failure<LoginResponse>():
        return Failure(result.errorMessage);
    }
  }



  @override
  Future<Result<ResetPasswordResponseEntity>> resetPassword(
    UserOTPEntity user,
  ) async {
    final result = await _authDataSource.resetPassword(user.toDto());
    switch (result) {
      case Success<ResetPasswordResponseDto>():
        return Success(result.data.toEntity());
      case Failure<ResetPasswordResponseDto>():
        return Failure(result.errorMessage);
    }
  }

  @override
  Future<Result<EmailVerificationResponseEntity>> sendResetPasswordCode(
    UserOTPEntity user,
  ) async {
    final result = await _authDataSource.emailVerification(user.toDto());
    switch (result) {
      case Success<EmailVerificationResponseDto>():
        return Success(result.data.toEntity());
      case Failure<EmailVerificationResponseDto>():
        return Failure(result.errorMessage);
    }
  }

  @override
  Future<Result<VerifyOtpResponse>> verifyResetPasswordCode(
      VerifyOtpRequest user,
  ) async {
    final result = await _authDataSource.codeVerification(user);
    switch (result) {
      case Success<VerifyOtpResponse>():
        return Success(result.data);
      case Failure<VerifyOtpResponse>():
        return Failure(result.errorMessage);
    }
  }

  @override
  Future<Result<RegisterEntity>> signUp(SignupRequestDto singUpModel) async{
    final response =await _authDataSource.signUp(singUpModel);
    switch(response){
      case Success<RegisterResponse>():
        return Success(response.data.toEntity());
      case Failure<RegisterResponse>():
        return Failure(response.errorMessage);
    }
  }

  @override
  Future<Result<LoginEntity>> loginWithEmailAndPassword(String email, String password)async {
    final result =await _authDataSource.loginWithEmailAndPassword(email, password);
    switch (result) {
      case Success<LoginResponse>():
        final data=result.data;
       _saveToken(token: data.token!, refreshToken: data.refreshToken!);
        return Success(data.toEntity());
      case Failure<LoginResponse>():
        return Failure(result.errorMessage);
    }
  }



  void _saveToken({required String token,required String refreshToken}) {
    AppLocalStorage.setSecuredString(key: AppKeys.token, value: token);
    AppLocalStorage.setSecuredString(key: AppKeys.refreshToken, value: refreshToken);
  }
}
