import 'dart:io';
import 'package:injectable/injectable.dart';
import 'package:junior_football/core/base_bloc/base_cubit.dart';
import 'package:junior_football/core/base_bloc/base_state.dart';
import 'package:junior_football/core/error_handling/result.dart';
import 'package:junior_football/feature/profile/domain/entities/user_profile_entity.dart';
import 'package:junior_football/feature/profile/domain/repo/profile_repo.dart';
import 'package:junior_football/feature/profile/presentation/view_model/profile_state.dart';

@injectable
class ProfileViewModel
    extends BaseCubit<ProfileState, ProfileIntent, ProfileEvent> {
  ProfileViewModel(this._profileRepo)
    : super(
        ProfileState(
          profile: BaseState.init(),
          uploadPicture: BaseState.init(),
          uploadVideo: BaseState.init(),
          followAction: BaseState.init(),
          uploadVideoProgress: 0,
          uploadedVideoUrls: const [],
        ),
      );

  final ProfileRepo _profileRepo;

  @override
  void doIntent(ProfileIntent intent) {
    if (intent is GetProfileIntent) {
      _getProfile();
      return;
    }
    if (intent is UploadProfilePictureIntent) {
      _uploadProfilePicture(intent.file);
      return;
    }
    if (intent is UploadProfileVideoIntent) {
      _uploadProfileVideo(intent.file);
      return;
    }
    if (intent is FollowUserIntent) {
      _followUser(intent.userId);
      return;
    }
    if (intent is UnfollowUserIntent) {
      _unfollowUser(intent.userId);
    }
  }

  Future<void> _getProfile() async {
    emit(state.copyWith(profile: BaseState.loading()));
    final result = await _profileRepo.getUserProfile();
    switch (result) {
      case Success<UserProfileEntity>():
        emit(state.copyWith(profile: BaseState.loaded(result.data)));
      case Failure<UserProfileEntity>():
        emit(state.copyWith(profile: BaseState.error(result.errorMessage)));
    }
  }

  Future<void> _uploadProfilePicture(File file) async {
    emit(state.copyWith(uploadPicture: BaseState.loading()));
    final result = await _profileRepo.uploadProfilePicture(file);
    switch (result) {
      case Success<UserProfileEntity>():
        emit(
          state.copyWith(
            uploadPicture: BaseState.loaded(true),
            profile: BaseState.loaded(result.data),
          ),
        );
      case Failure<UserProfileEntity>():
        emit(
          state.copyWith(uploadPicture: BaseState.error(result.errorMessage)),
        );
    }
  }

  Future<void> _uploadProfileVideo(File file) async {
    emit(
      state.copyWith(uploadVideo: BaseState.loading(), uploadVideoProgress: 0),
    );
    final result = await _profileRepo.uploadProfileVideo(
      file,
      _calculateVideoProgress,
    );
    switch (result) {
      case Success<String>():
        emit(
          state.copyWith(
            uploadVideo: BaseState.loaded(result.data),
            uploadVideoProgress: 100,
            uploadedVideoUrls: [result.data, ...state.uploadedVideoUrls],
          ),
        );
      case Failure<String>():
        emit(state.copyWith(uploadVideo: BaseState.error(result.errorMessage)));
    }
  }

  void _calculateVideoProgress(int sent, int total) {
    if (total <= 0) return;
    emit(state.copyWith(uploadVideoProgress: sent / total * 100));
  }

  Future<void> _followUser(String userId) async {
    emit(state.copyWith(followAction: BaseState.loading()));
    final result = await _profileRepo.followUser(userId);
    switch (result) {
      case Success<void>():
        final profile = state.profile.data;
        emit(
          state.copyWith(
            followAction: BaseState.loaded(true),
            profile: profile == null
                ? state.profile
                : BaseState.loaded(
                    profile.copyWith(
                      isFollowing: true,
                      followersCount: (profile.followersCount ?? 0) + 1,
                    ),
                  ),
          ),
        );
      case Failure<void>():
        emit(
          state.copyWith(followAction: BaseState.error(result.errorMessage)),
        );
    }
  }

  Future<void> _unfollowUser(String userId) async {
    emit(state.copyWith(followAction: BaseState.loading()));
    final result = await _profileRepo.unfollowUser(userId);
    switch (result) {
      case Success<void>():
        final profile = state.profile.data;
        final followersCount = profile?.followersCount ?? 0;
        emit(
          state.copyWith(
            followAction: BaseState.loaded(false),
            profile: profile == null
                ? state.profile
                : BaseState.loaded(
                    profile.copyWith(
                      isFollowing: false,
                      followersCount: followersCount > 0
                          ? followersCount - 1
                          : 0,
                    ),
                  ),
          ),
        );
      case Failure<void>():
        emit(
          state.copyWith(followAction: BaseState.error(result.errorMessage)),
        );
    }
  }
}
