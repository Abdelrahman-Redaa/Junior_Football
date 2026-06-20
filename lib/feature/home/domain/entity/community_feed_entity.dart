import 'package:equatable/equatable.dart';
import 'package:junior_football/core/theme/string_extension.dart';

class CommunityFeedEntity {
  final String? id;
  final String? content;
  final String? mediaUrl;
  final String? _createdAt;
  final String? userId;
  final String? userFullName;
  final String? userProfilePicture;
  final int? likesCount;
  final int? commentsCount;
  final bool? isLikedByCurrentUser;
  final List<CommentsEntity>? comments;

  CommunityFeedEntity({
    this.id,
    this.content,
    this.userId,
    this.userFullName,
    this.likesCount,
    this.commentsCount,
    this.isLikedByCurrentUser,
    this.comments,
    String? createdAt,
    this.mediaUrl,
    this.userProfilePicture,
  }) :_createdAt = createdAt;



  String? get createdAt => _createdAt?.timeAgo();
}

class CommentsEntity extends Equatable {
  final String id;
  final String userId;
  final String userName;
  final String userProfileImage;
  final String content;

  const CommentsEntity({
    required this.id,
    required this.userId,
    required this.userName,
    required this.userProfileImage,
    required this.content,
  });

  @override
  List<Object?> get props => [id, userId, userName, userProfileImage, content];
}
