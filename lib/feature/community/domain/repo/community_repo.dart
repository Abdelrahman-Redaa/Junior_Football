import 'dart:io';

import 'package:junior_football/core/error_handling/result.dart';
import 'package:junior_football/feature/community/domain/entity/liked_post_entity.dart';
import 'package:junior_football/feature/home/domain/entity/community_feed_entity.dart';
import 'package:junior_football/feature/profile/domain/entities/user_profile_entity.dart';

abstract class CommunityRepo {
  Future<Result<List<CommunityFeedEntity>>> getCommunityFeed();
  Future<Result<LikedPostEntity>> likePost(String postId);
  Future<Result<LikedPostEntity>> commentPost(String postId, String comment);
  Future<Result<void>> deletePost(String postId);
  Future<Result<LikedPostEntity>> createPost(File file, String content);
  Future<Result<UserProfileEntity>> getUserProfileById(String userId);
  Future<Result<LikedPostEntity>> followUser(String userId);
  Future<Result<LikedPostEntity>> unfollowUser(String userId);
}
