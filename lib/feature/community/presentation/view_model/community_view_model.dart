import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:junior_football/core/base_bloc/base_cubit.dart';
import 'package:junior_football/core/base_bloc/base_state.dart';
import 'package:junior_football/core/error_handling/result.dart';
import 'package:junior_football/feature/community/domain/entity/liked_post_entity.dart';
import 'package:junior_football/feature/community/domain/repo/community_repo.dart';
import 'package:junior_football/feature/community/presentation/view_model/community_state.dart';
import 'package:junior_football/feature/home/domain/entity/community_feed_entity.dart';
import 'package:junior_football/feature/profile/domain/entities/user_profile_entity.dart';

@injectable
class CommunityViewModel
    extends BaseCubit<CommunityState, CommunityIntent, CommunityEvent> {
  final CommunityRepo _communityRepo;

  CommunityViewModel(this._communityRepo)
    : super(
        CommunityState(
          communityFeedState: BaseState.init(),
          likePostState: BaseState.init(),
          commentPostState: BaseState.init(),
          createPostState: BaseState.init(),
          searchedProfileState: BaseState.init(),
          followUserState: BaseState.init(),
          unfollowUserState: BaseState.init(),
        ),
      );

  @override
  void doIntent(CommunityIntent intent) {
    switch (intent) {
      case GetCommunityPostsIntent():
        _getCommunityFeed();
      case LikePostIntent():
        _likePost(intent.postId);
      case CommentPostIntent():
        _commentPost(intent.postId, intent.comment);
      case CreatePostIntent():
        _createPost(intent.file, intent.content);
      case SearchUserProfileIntent():
        _searchUserProfile(intent.userId);
      case FollowCommunityUserIntent():
        _followUser(intent.userId);
      case UnfollowCommunityUserIntent():
        _unfollowUser(intent.userId);
    }
  }

  Future<void> _getCommunityFeed() async {
    emit(state.copyWith(communityFeedState: BaseState.loading()));

    final result = await _communityRepo.getCommunityFeed();

    switch (result) {
      case Success<List<CommunityFeedEntity>>():
        emit(state.copyWith(communityFeedState: BaseState.loaded(result.data)));
      case Failure<List<CommunityFeedEntity>>():
        emit(
          state.copyWith(
            communityFeedState: BaseState.error(result.errorMessage),
          ),
        );
        emitEvent(CommunityErrorEvent(result.errorMessage));
    }
  }

  Future<void> _likePost(String postId) async {
    emit(state.copyWith(likePostState: BaseState.loading()));

    final result = await _communityRepo.likePost(postId);

    switch (result) {
      case Success<LikedPostEntity>():
        emit(state.copyWith(likePostState: BaseState.loaded(result.data)));
        emitEvent(CommunitySuccessEvent(result.data.message));
        _getCommunityFeed();
      case Failure<LikedPostEntity>():
        emit(
          state.copyWith(likePostState: BaseState.error(result.errorMessage)),
        );
        emitEvent(CommunityErrorEvent(result.errorMessage));
    }
  }

  Future<void> _commentPost(String postId, String comment) async {
    emit(state.copyWith(commentPostState: BaseState.loading()));

    final result = await _communityRepo.commentPost(postId, comment);

    switch (result) {
      case Success<LikedPostEntity>():
        emit(state.copyWith(commentPostState: BaseState.loaded(result.data)));
        emitEvent(CommunitySuccessEvent(result.data.message));
        _getCommunityFeed();
      case Failure<LikedPostEntity>():
        emit(
          state.copyWith(
            commentPostState: BaseState.error(result.errorMessage),
          ),
        );
        emitEvent(CommunityErrorEvent(result.errorMessage));
    }
  }

  Future<void> _createPost(File file, String content) async {
    emit(state.copyWith(createPostState: BaseState.loading()));

    final result = await _communityRepo.createPost(file, content);

    switch (result) {
      case Success<LikedPostEntity>():
        emit(state.copyWith(createPostState: BaseState.loaded(result.data)));
        _getCommunityFeed();
        emitEvent(CommunitySuccessEvent(result.data.message));

      case Failure<LikedPostEntity>():
        emit(
          state.copyWith(createPostState: BaseState.error(result.errorMessage)),
        );
        emitEvent(CommunityErrorEvent(result.errorMessage));
    }
  }

  Future<void> _searchUserProfile(String userId) async {
    final trimmedUserId = userId.trim();
    if (trimmedUserId.isEmpty) {
      emit(
        state.copyWith(
          searchedProfileState: BaseState.error('Please enter a user ID'),
        ),
      );
      emitEvent(CommunityErrorEvent('Please enter a user ID'));
      return;
    }

    emit(
      state.copyWith(
        searchedProfileState: BaseState.loading(),
        followUserState: BaseState.init(),
      ),
    );
    final result = await _communityRepo.getUserProfileById(trimmedUserId);
    switch (result) {
      case Success<UserProfileEntity>():
        emit(
          state.copyWith(searchedProfileState: BaseState.loaded(result.data)),
        );
      case Failure<UserProfileEntity>():
        emit(
          state.copyWith(
            searchedProfileState: BaseState.error(result.errorMessage),
          ),
        );
        emitEvent(CommunityErrorEvent(result.errorMessage));
    }
  }

  Future<void> _followUser(String userId) async {
    final trimmedUserId = userId.trim();
    if (trimmedUserId.isEmpty) {
      emit(
        state.copyWith(
          followUserState: BaseState.error('Please enter a user ID'),
        ),
      );
      emitEvent(CommunityErrorEvent('Please enter a user ID'));
      return;
    }

    emit(state.copyWith(followUserState: BaseState.loading()));
    final result = await _communityRepo.followUser(trimmedUserId);
    switch (result) {
      case Success<LikedPostEntity>():
        emit(state.copyWith(followUserState: BaseState.loaded(result.data)));
        emitEvent(CommunitySuccessEvent(result.data.message));
        _getCommunityFeed();
        final profile = state.searchedProfileState.data;
        if (profile != null) {
          emit(
            state.copyWith(
              searchedProfileState: BaseState.loaded(
                profile.copyWith(
                  isFollowing: true,
                  followersCount: (profile.followersCount ?? 0) + 1,
                ),
              ),
            ),
          );
        }
      case Failure<LikedPostEntity>():
        emit(
          state.copyWith(followUserState: BaseState.error(result.errorMessage)),
        );
        emitEvent(CommunityErrorEvent(result.errorMessage));
    }
  }

  Future<void> _unfollowUser(String userId) async {
    final trimmedUserId = userId.trim();
    if (trimmedUserId.isEmpty) {
      emit(
        state.copyWith(
          unfollowUserState: BaseState.error('Player ID is missing'),
        ),
      );
      emitEvent(CommunityErrorEvent('Player ID is missing'));
      return;
    }

    emit(state.copyWith(unfollowUserState: BaseState.loading()));
    final result = await _communityRepo.unfollowUser(trimmedUserId);
    switch (result) {
      case Success<LikedPostEntity>():
        emit(state.copyWith(unfollowUserState: BaseState.loaded(result.data)));
        emitEvent(CommunitySuccessEvent(result.data.message));
        _getCommunityFeed();
      case Failure<LikedPostEntity>():
        emit(
          state.copyWith(
            unfollowUserState: BaseState.error(result.errorMessage),
          ),
        );
        emitEvent(CommunityErrorEvent(result.errorMessage));
    }
  }
}
