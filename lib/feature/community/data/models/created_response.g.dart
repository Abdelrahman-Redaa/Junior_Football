// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'created_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreatedResponse _$CreatedResponseFromJson(Map<String, dynamic> json) =>
    CreatedResponse(
      isSuccess: json['isSuccess'] as bool?,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$CreatedResponseToJson(CreatedResponse instance) =>
    <String, dynamic>{
      'isSuccess': instance.isSuccess,
      'message': instance.message,
    };
