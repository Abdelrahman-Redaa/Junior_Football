import 'package:junior_football/feature/auth/data/models/response_models/login_response.dart';

import '../domain/entities/login_entity.dart';

extension LoginMapper on LoginResponse{
  LoginEntity toEntity() => LoginEntity(
    isSuccess: isSuccess,
    message: message,
    token: token,
    refreshToken: refreshToken,
    refreshTokenExpiration: refreshTokenExpiration,
    email: email,
    fullName: fullName,
  );
}