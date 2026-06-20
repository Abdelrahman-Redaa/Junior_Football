import 'package:json_annotation/json_annotation.dart';

part 'upload_video_response.g.dart';

@JsonSerializable()
class UploadVideoResponse {
  @JsonKey(name: "videoUrl")
  final String? videoUrl;

  UploadVideoResponse ({
    this.videoUrl,
  });

  factory UploadVideoResponse.fromJson(Map<String, dynamic> json) {
    return _$UploadVideoResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$UploadVideoResponseToJson(this);
  }
}


