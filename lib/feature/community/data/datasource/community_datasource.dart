import 'dart:io';

import 'package:junior_football/core/error_handling/result.dart';
import 'package:junior_football/feature/community/data/models/created_response.dart';
import 'package:junior_football/feature/home/data/models/response/community_feed.dart';
import 'package:junior_football/feature/profile/data/models/response_models/user_profile_dto.dart';

abstract class CommunityDataSource {
  Future<Result<List<CommunityFeedResponse>>> getCommunityFeed();
  Future<Result<CreatedResponse>> likePost(String postId);
  Future<Result<CreatedResponse>> commentPost(String postId, String comment);
  Future<Result<void>> deletePost(String postId);
  Future<Result<CreatedResponse>> createPost(File file, String content);
  Future<Result<UserProfileDto>> getUserProfileById(String userId);
  Future<Result<CreatedResponse>> followUser(String userId);
  Future<Result<CreatedResponse>> unfollowUser(String userId);
}
