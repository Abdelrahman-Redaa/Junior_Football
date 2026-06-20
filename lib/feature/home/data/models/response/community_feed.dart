import 'package:json_annotation/json_annotation.dart';

part 'community_feed.g.dart';

@JsonSerializable()
class CommunityFeedResponse {
  @JsonKey(name: "id")
  final String? id;
  @JsonKey(name: "userId")
  final String? userId;
  @JsonKey(name: "userName")
  final String? userName;
  @JsonKey(name: "userProfileImage")
  final String? userProfileImage;
  @JsonKey(name: "content")
  final String? content;
  @JsonKey(name: "imageUrl")
  final String? imageUrl;
  @JsonKey(name: "videoUrl")
  final dynamic? videoUrl;
  @JsonKey(name: "likesCount")
  final int? likesCount;
  @JsonKey(name: "commentsCount")
  final int? commentsCount;
  @JsonKey(name: "isLikedByMe")
  final bool? isLikedByMe;
  @JsonKey(name: "comments")
  final List<Comments>? comments;
  @JsonKey(name: "createdAt")
  final String? createdAt;

  CommunityFeedResponse ({
    this.id,
    this.userId,
    this.userName,
    this.userProfileImage,
    this.content,
    this.imageUrl,
    this.videoUrl,
    this.likesCount,
    this.commentsCount,
    this.isLikedByMe,
    this.comments,
    this.createdAt,
  });

  factory CommunityFeedResponse.fromJson(Map<String, dynamic> json) {
    return _$CommunityFeedResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$CommunityFeedResponseToJson(this);
  }
}

@JsonSerializable()
class Comments {
  @JsonKey(name: "id")
  final String? id;
  @JsonKey(name: "userId")
  final String? userId;
  @JsonKey(name: "userName")
  final String? userName;
  @JsonKey(name: "userProfileImage")
  final String? userProfileImage;
  @JsonKey(name: "content")
  final String? content;
  @JsonKey(name: "createdAt")
  final String? createdAt;

  Comments ({
    this.id,
    this.userId,
    this.userName,
    this.userProfileImage,
    this.content,
    this.createdAt,
  });

  factory Comments.fromJson(Map<String, dynamic> json) {
    return _$CommentsFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$CommentsToJson(this);
  }


}


