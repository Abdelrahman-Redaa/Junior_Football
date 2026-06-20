// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'twin_player_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TwinPlayerResponse _$TwinPlayerResponseFromJson(Map<String, dynamic> json) =>
    TwinPlayerResponse(
      id: json['id'] as String?,
      twinPlayerName: json['twinPlayerName'] as String?,
      twinProfileImageUrl: json['twinProfileImageUrl'] as String?,
      matchDescription: json['matchDescription'] as String?,
      matchPercentage: (json['matchPercentage'] as num?)?.toInt(),
      mediaGallery: (json['mediaGallery'] as List<dynamic>?)
          ?.map((e) => MediaGallery.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TwinPlayerResponseToJson(TwinPlayerResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'twinPlayerName': instance.twinPlayerName,
      'twinProfileImageUrl': instance.twinProfileImageUrl,
      'matchDescription': instance.matchDescription,
      'matchPercentage': instance.matchPercentage,
      'mediaGallery': instance.mediaGallery,
    };

MediaGallery _$MediaGalleryFromJson(Map<String, dynamic> json) => MediaGallery(
  title: json['title'] as String?,
  url: json['url'] as String?,
  mediaType: json['mediaType'] as String?,
);

Map<String, dynamic> _$MediaGalleryToJson(MediaGallery instance) =>
    <String, dynamic>{
      'title': instance.title,
      'url': instance.url,
      'mediaType': instance.mediaType,
    };
