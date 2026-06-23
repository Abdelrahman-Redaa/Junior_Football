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
          updateProfileState: BaseState.init(),
          changePasswordState: BaseState.init(),
        ),
      );

  final ProfileRepo _profileRepo;

  @override
  void doIntent(ProfileIntent intent) {
    if (intent is GetProfileIntent) {
      _getProfile();
      return;
    }
    if (intent is GetProfileByIdIntent) {
      _getProfileById(intent.userId);
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
      return;
    }
    if (intent is UpdateProfileIntent) {
      _updateProfile(intent.updatedProfile, intent.profileImageFile);
      return;
    }
    if (intent is ChangePasswordIntent) {
      _changePassword(intent.currentPassword, intent.newPassword);
      return;
    }
  }

  Future<void> _updateProfile(
    UserProfileEntity edited,
    File? profileImageFile,
  ) async {
    emit(state.copyWith(updateProfileState: BaseState.loading()));

    final result = await _profileRepo.updateProfile(
      bio: edited.bio,
      height: edited.height,
      weight: edited.weight,
      preferredFoot: edited.preferredFoot,
      team: edited.team,
      profileImage: profileImageFile,
    );

    switch (result) {
      case Success<UserProfileEntity>():
        emit(
          state.copyWith(
            updateProfileState: BaseState.loaded(true),
            profile: BaseState.loaded(result.data),
          ),
        );
      case Failure<UserProfileEntity>():
        emit(
          state.copyWith(
            updateProfileState: BaseState.error(result.errorMessage),
          ),
        );
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

  Future<void> _getProfileById(String userId) async {
    emit(state.copyWith(profile: BaseState.loading()));
    final result = await _profileRepo.getUserProfileById(userId);
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
        final currentProfile = state.profile.data;
        if (currentProfile != null) {
          final updatedVideos = <String>[
            result.data,
            ...(currentProfile.videosUrl ?? []),
          ];
          emit(
            state.copyWith(
              uploadVideo: BaseState.loaded(true),
              uploadVideoProgress: 100,
              profile: BaseState.loaded(
                currentProfile.copyWith(videosUrl: updatedVideos),
              ),
            ),
          );
        } else {
          emit(
            state.copyWith(
              uploadVideo: BaseState.loaded(true),
              uploadVideoProgress: 100,
            ),
          );
        }
      case Failure<String>():
        emit(
          state.copyWith(
            uploadVideo: BaseState.error(result.errorMessage),
            uploadVideoProgress: 0,
          ),
        );
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

  Future<void> _changePassword(
    String currentPassword,
    String newPassword,
  ) async {
    emit(state.copyWith(changePasswordState: BaseState.loading()));

    final result = await _profileRepo.changePassword(
      currentPassword,
      newPassword,
    );

    switch (result) {
      case Success<void>():
        emit(state.copyWith(changePasswordState: BaseState.loaded(true)));
      case Failure<void>():
        emit(
          state.copyWith(
            changePasswordState: BaseState.error(result.errorMessage),
          ),
        );
    }
  }
}
