import 'package:json_annotation/json_annotation.dart';

part 'twin_player_response.g.dart';

@JsonSerializable()
class TwinPlayerResponse {
  @JsonKey(name: "id")
  final String? id;
  @JsonKey(name: "twinPlayerName")
  final String? twinPlayerName;
  @JsonKey(name: "twinProfileImageUrl")
  final String? twinProfileImageUrl;
  @JsonKey(name: "matchDescription")
  final String? matchDescription;
  @JsonKey(name: "matchPercentage")
  final int? matchPercentage;
  @JsonKey(name: "mediaGallery")
  final List<MediaGallery>? mediaGallery;

  TwinPlayerResponse ({
    this.id,
    this.twinPlayerName,
    this.twinProfileImageUrl,
    this.matchDescription,
    this.matchPercentage,
    this.mediaGallery,
  });

  factory TwinPlayerResponse.fromJson(Map<String, dynamic> json) {
    return _$TwinPlayerResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$TwinPlayerResponseToJson(this);
  }
}

@JsonSerializable()
class MediaGallery {
  @JsonKey(name: "title")
  final String? title;
  @JsonKey(name: "url")
  final String? url;
  @JsonKey(name: "mediaType")
  final String? mediaType;

  MediaGallery ({
    this.title,
    this.url,
    this.mediaType,
  });

  factory MediaGallery.fromJson(Map<String, dynamic> json) {
    return _$MediaGalleryFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$MediaGalleryToJson(this);
  }
}


