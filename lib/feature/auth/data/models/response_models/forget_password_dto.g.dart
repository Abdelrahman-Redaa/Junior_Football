// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forget_password_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmailVerificationResponseDto _$EmailVerificationResponseDtoFromJson(
  Map<String, dynamic> json,
) => EmailVerificationResponseDto(
  message: json['message'] as String?,
  into: json['info'] as String?,
);

Map<String, dynamic> _$EmailVerificationResponseDtoToJson(
  EmailVerificationResponseDto instance,
) => <String, dynamic>{'message': instance.message, 'info': instance.into};

VerificationCodeResponseDto _$VerificationCodeResponseDtoFromJson(
  Map<String, dynamic> json,
) => VerificationCodeResponseDto(status: json['status'] as String?);

Map<String, dynamic> _$VerificationCodeResponseDtoToJson(
  VerificationCodeResponseDto instance,
) => <String, dynamic>{'status': instance.status};

ResetPasswordResponseDto _$ResetPasswordResponseDtoFromJson(
  Map<String, dynamic> json,
) => ResetPasswordResponseDto(
  message: json['message'] as String?,
  token: json['token'] as String?,
);

Map<String, dynamic> _$ResetPasswordResponseDtoToJson(
  ResetPasswordResponseDto instance,
) => <String, dynamic>{'message': instance.message, 'token': instance.token};

UserOTPDto _$UserOTPDtoFromJson(Map<String, dynamic> json) => UserOTPDto(
  email: json['email'] as String?,
  code: json['resetCode'] as String?,
  password: json['newPassword'] as String?,
);

Map<String, dynamic> _$UserOTPDtoToJson(UserOTPDto instance) =>
    <String, dynamic>{
      'email': ?instance.email,
      'resetCode': ?instance.code,
      'newPassword': ?instance.password,
    };
