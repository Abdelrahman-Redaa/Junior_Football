import 'package:equatable/equatable.dart';

class LoginEntity extends Equatable {
  final bool? isSuccess;
  final String? message;
  final String? token;
  final String? refreshToken;
  final String? refreshTokenExpiration;
  final String? email;
  final String? fullName;

  const LoginEntity({
    this.isSuccess,
    this.message,
    this.token,
    this.refreshToken,
    this.refreshTokenExpiration,
    this.email,
    this.fullName,
  });

  @override
  List<Object?> get props => [isSuccess, message, token, refreshToken, refreshTokenExpiration, email, fullName];
}