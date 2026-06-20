// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_up_request_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignupRequestDto _$SignupRequestDtoFromJson(Map<String, dynamic> json) =>
    SignupRequestDto(
      fullName: json['fullName'] as String?,
      dateOfBirth: json['dateOfBirth'] as String?,
      country: json['country'] as String?,
      playingPosition: (json['playingPosition'] as num?)?.toInt(),
      email: json['email'] as String?,
      password: json['password'] as String?,
    );

Map<String, dynamic> _$SignupRequestDtoToJson(SignupRequestDto instance) =>
    <String, dynamic>{
      'fullName': instance.fullName,
      'dateOfBirth': instance.dateOfBirth,
      'country': instance.country,
      'playingPosition': instance.playingPosition,
      'email': instance.email,
      'password': instance.password,
    };
