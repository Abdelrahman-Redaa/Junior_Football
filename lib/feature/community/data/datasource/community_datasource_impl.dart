import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:junior_football/core/api/api_client.dart';
import 'package:junior_football/core/error_handling/execute_api.dart';
import 'package:junior_football/core/error_handling/result.dart';
import 'package:junior_football/feature/community/data/datasource/community_datasource.dart';
import 'package:junior_football/feature/community/data/models/created_response.dart';
import 'package:junior_football/feature/home/data/models/response/community_feed.dart';
import 'package:junior_football/feature/profile/data/models/response_models/user_profile_dto.dart';

@LazySingleton(as: CommunityDataSource)
class CommunityDataSourceImpl implements CommunityDataSource {
  final ApiClient _apiClient;

  CommunityDataSourceImpl(this._apiClient);

  @override
  Future<Result<List<CommunityFeedResponse>>> getCommunityFeed() =>
      executeApi(() => _apiClient.getCommunityFeed());

  @override
  Future<Result<CreatedResponse>> likePost(String postId) =>
      executeApi(() => _apiClient.likePost(postId));

  @override
  Future<Result<CreatedResponse>> commentPost(String postId, String comment) =>
      executeApi(() => _apiClient.commentPost(postId, {"content": comment}));

  @override
  Future<Result<CreatedResponse>> createPost(File file, String content) =>
      executeApi(() => _apiClient.createPost(file: file, content: content));

  @override
  Future<Result<UserProfileDto>> getUserProfileById(String userId) =>
      executeApi(() => _apiClient.getUserProfileById(userId));

  @override
  Future<Result<CreatedResponse>> followUser(String userId) =>
      executeApi(() => _apiClient.followUser(userId));

  @override
  Future<Result<CreatedResponse>> unfollowUser(String userId) =>
      executeApi(() => _apiClient.unfollowUser(userId));
}
