// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'community_feed.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommunityFeedResponse _$CommunityFeedResponseFromJson(
  Map<String, dynamic> json,
) => CommunityFeedResponse(
  id: json['id'] as String?,
  userId: json['userId'] as String?,
  userName: json['userName'] as String?,
  userProfileImage: json['userProfileImage'] as String?,
  content: json['content'] as String?,
  imageUrl: json['imageUrl'] as String?,
  videoUrl: json['videoUrl'],
  likesCount: (json['likesCount'] as num?)?.toInt(),
  commentsCount: (json['commentsCount'] as num?)?.toInt(),
  isLikedByMe: json['isLikedByMe'] as bool?,
  comments: (json['comments'] as List<dynamic>?)
      ?.map((e) => Comments.fromJson(e as Map<String, dynamic>))
      .toList(),
  createdAt: json['createdAt'] as String?,
);

Map<String, dynamic> _$CommunityFeedResponseToJson(
  CommunityFeedResponse instance,
) => <String, dynamic>{
  'id': instance.id,
  'userId': instance.userId,
  'userName': instance.userName,
  'userProfileImage': instance.userProfileImage,
  'content': instance.content,
  'imageUrl': instance.imageUrl,
  'videoUrl': instance.videoUrl,
  'likesCount': instance.likesCount,
  'commentsCount': instance.commentsCount,
  'isLikedByMe': instance.isLikedByMe,
  'comments': instance.comments,
  'createdAt': instance.createdAt,
};

Comments _$CommentsFromJson(Map<String, dynamic> json) => Comments(
  id: json['id'] as String?,
  userId: json['userId'] as String?,
  userName: json['userName'] as String?,
  userProfileImage: json['userProfileImage'] as String?,
  content: json['content'] as String?,
  createdAt: json['createdAt'] as String?,
);

Map<String, dynamic> _$CommentsToJson(Comments instance) => <String, dynamic>{
  'id': instance.id,
  'userId': instance.userId,
  'userName': instance.userName,
  'userProfileImage': instance.userProfileImage,
  'content': instance.content,
  'createdAt': instance.createdAt,
};
