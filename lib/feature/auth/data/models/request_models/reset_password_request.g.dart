// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reset_password_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RestPasswordRequest _$RestPasswordRequestFromJson(Map<String, dynamic> json) =>
    RestPasswordRequest(
      email: json['email'] as String?,
      newPassword: json['newPassword'] as String?,
    );

Map<String, dynamic> _$RestPasswordRequestToJson(
  RestPasswordRequest instance,
) => <String, dynamic>{
  'email': instance.email,
  'newPassword': instance.newPassword,
};
