// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResponse _$LoginResponseFromJson(Map<String, dynamic> json) =>
    LoginResponse(
      isSuccess: json['isSuccess'] as bool?,
      message: json['message'] as String?,
      token: json['token'] as String?,
      refreshToken: json['refreshToken'] as String?,
      refreshTokenExpiration: json['refreshTokenExpiration'] as String?,
      email: json['email'] as String?,
      fullName: json['fullName'] as String?,
    );

Map<String, dynamic> _$LoginResponseToJson(LoginResponse instance) =>
    <String, dynamic>{
      'isSuccess': instance.isSuccess,
      'message': instance.message,
      'token': instance.token,
      'refreshToken': instance.refreshToken,
      'refreshTokenExpiration': instance.refreshTokenExpiration,
      'email': instance.email,
      'fullName': instance.fullName,
    };
