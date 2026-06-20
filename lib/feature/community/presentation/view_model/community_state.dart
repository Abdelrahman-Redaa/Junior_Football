import 'dart:io';

import 'package:junior_football/core/base_bloc/base_state.dart';
import 'package:junior_football/feature/community/domain/entity/liked_post_entity.dart';
import 'package:junior_football/feature/home/domain/entity/community_feed_entity.dart';
import 'package:junior_football/feature/profile/domain/entities/user_profile_entity.dart';

class CommunityState {
  final BaseState<List<CommunityFeedEntity>> communityFeedState;
  final BaseState<LikedPostEntity> likePostState;
  final BaseState<LikedPostEntity> commentPostState;
  final BaseState<LikedPostEntity> createPostState;
  final BaseState<UserProfileEntity> searchedProfileState;
  final BaseState<LikedPostEntity> followUserState;
  final BaseState<LikedPostEntity> unfollowUserState;

  CommunityState({
    required this.communityFeedState,
    required this.likePostState,
    required this.commentPostState,
    required this.createPostState,
    required this.searchedProfileState,
    required this.followUserState,
    required this.unfollowUserState,
  });

  CommunityState copyWith({
    BaseState<List<CommunityFeedEntity>>? communityFeedState,
    BaseState<LikedPostEntity>? likePostState,
    BaseState<LikedPostEntity>? commentPostState,
    BaseState<LikedPostEntity>? createPostState,
    BaseState<UserProfileEntity>? searchedProfileState,
    BaseState<LikedPostEntity>? followUserState,
    BaseState<LikedPostEntity>? unfollowUserState,
  }) {
    return CommunityState(
      communityFeedState: communityFeedState ?? this.communityFeedState,
      likePostState: likePostState ?? this.likePostState,
      commentPostState: commentPostState ?? this.commentPostState,
      createPostState: createPostState ?? this.createPostState,
      searchedProfileState: searchedProfileState ?? this.searchedProfileState,
      followUserState: followUserState ?? this.followUserState,
      unfollowUserState: unfollowUserState ?? this.unfollowUserState,
    );
  }
}

sealed class CommunityIntent {}

class GetCommunityPostsIntent extends CommunityIntent {}

class LikePostIntent extends CommunityIntent {
  final String postId;
  LikePostIntent(this.postId);
}

class CommentPostIntent extends CommunityIntent {
  final String postId;
  final String comment;
  CommentPostIntent(this.postId, this.comment);
}

class CreatePostIntent extends CommunityIntent {
  final File file;
  final String content;
  CreatePostIntent({required this.file, required this.content});
}

class SearchUserProfileIntent extends CommunityIntent {
  final String userId;
  SearchUserProfileIntent(this.userId);
}

class FollowCommunityUserIntent extends CommunityIntent {
  final String userId;
  FollowCommunityUserIntent(this.userId);
}

class UnfollowCommunityUserIntent extends CommunityIntent {
  final String userId;
  UnfollowCommunityUserIntent(this.userId);
}

sealed class CommunityEvent {}

class CommunityErrorEvent extends CommunityEvent {
  final String message;
  CommunityErrorEvent(this.message);
}

class CommunitySuccessEvent extends CommunityEvent {
  final String message;
  CommunitySuccessEvent(this.message);
}
