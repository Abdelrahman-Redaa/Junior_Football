import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:junior_football/core/error_handling/result.dart';
import 'package:junior_football/feature/community/data/datasource/community_datasource.dart';
import 'package:junior_football/feature/community/data/models/created_response.dart';
import 'package:junior_football/feature/community/domain/entity/liked_post_entity.dart';
import 'package:junior_football/feature/community/domain/repo/community_repo.dart';
import 'package:junior_football/feature/community/mapper/community_mapper.dart';
import 'package:junior_football/feature/home/data/models/response/community_feed.dart';
import 'package:junior_football/feature/home/domain/entity/community_feed_entity.dart';
import 'package:junior_football/feature/home/mapper/home_mapper.dart';
import 'package:junior_football/feature/profile/data/models/response_models/user_profile_dto.dart';
import 'package:junior_football/feature/profile/domain/entities/user_profile_entity.dart';
import 'package:junior_football/feature/profile/mapper/profile_mapper.dart';

@LazySingleton(as: CommunityRepo)
class CommunityRepoImpl implements CommunityRepo {
  final CommunityDataSource _communityDataSource;

  CommunityRepoImpl(this._communityDataSource);

  @override
  Future<Result<List<CommunityFeedEntity>>> getCommunityFeed() async {
    final result = await _communityDataSource.getCommunityFeed();
    switch (result) {
      case Success<List<CommunityFeedResponse>>():
        return Success(result.data.map((e) => e.toEntity()).toList());
      case Failure<List<CommunityFeedResponse>>():
        return Failure(result.errorMessage);
    }
  }

  @override
  Future<Result<LikedPostEntity>> likePost(String postId) async {
    final result = await _communityDataSource.likePost(postId);
    switch (result) {
      case Success<CreatedResponse>():
        return Success(result.data.toEntity());
      case Failure<CreatedResponse>():
        return Failure(result.errorMessage);
    }
  }

  @override
  Future<Result<LikedPostEntity>> commentPost(
    String postId,
    String comment,
  ) async {
    final result = await _communityDataSource.commentPost(postId, comment);
    switch (result) {
      case Success<CreatedResponse>():
        return Success(result.data.toEntity());
      case Failure<CreatedResponse>():
        return Failure(result.errorMessage);
    }
  }

  @override
  Future<Result<LikedPostEntity>> createPost(File file, String content) async {
    final result = await _communityDataSource.createPost(file, content);
    switch (result) {
      case Success<CreatedResponse>():
        return Success(result.data.toEntity());
      case Failure<CreatedResponse>():
        return Failure(result.errorMessage);
    }
  }

  @override
  Future<Result<UserProfileEntity>> getUserProfileById(String userId) async {
    final result = await _communityDataSource.getUserProfileById(userId);
    switch (result) {
      case Success<UserProfileDto>():
        return Success(result.data.toEntity());
      case Failure<UserProfileDto>():
        return Failure(result.errorMessage);
    }
  }

  @override
  Future<Result<LikedPostEntity>> followUser(String userId) async {
    final result = await _communityDataSource.followUser(userId);
    switch (result) {
      case Success<CreatedResponse>():
        return Success(result.data.toEntity());
      case Failure<CreatedResponse>():
        return Failure(result.errorMessage);
    }
  }

  @override
  Future<Result<LikedPostEntity>> unfollowUser(String userId) async {
    final result = await _communityDataSource.unfollowUser(userId);
    switch (result) {
      case Success<CreatedResponse>():
        return Success(result.data.toEntity());
      case Failure<CreatedResponse>():
        return Failure(result.errorMessage);
    }
  }
}
