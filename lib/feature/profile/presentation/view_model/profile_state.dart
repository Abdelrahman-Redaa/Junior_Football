import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:junior_football/core/base_bloc/base_state.dart';
import 'package:junior_football/feature/profile/domain/entities/user_profile_entity.dart';

class ProfileState extends Equatable {
  final BaseState<UserProfileEntity> profile;
  final BaseState<bool> uploadPicture;
  final BaseState<bool> uploadVideo;
  final BaseState<bool> followAction;
  final double uploadVideoProgress;
  final BaseState<bool> updateProfileState;
  final BaseState<bool> changePasswordState;

  const ProfileState({
    required this.profile,
    required this.uploadPicture,
    required this.uploadVideo,
    required this.followAction,
    required this.uploadVideoProgress,
    required this.updateProfileState,
    required this.changePasswordState,
  });

  ProfileState copyWith({
    BaseState<UserProfileEntity>? profile,
    BaseState<bool>? uploadPicture,
    BaseState<bool>? uploadVideo,
    BaseState<bool>? followAction,
    double? uploadVideoProgress,
    BaseState<bool>? updateProfileState,
    BaseState<bool>? changePasswordState,
  }) {
    return ProfileState(
      profile: profile ?? this.profile,
      uploadPicture: uploadPicture ?? this.uploadPicture,
      uploadVideo: uploadVideo ?? this.uploadVideo,
      followAction: followAction ?? this.followAction,
      uploadVideoProgress: uploadVideoProgress ?? this.uploadVideoProgress,
      updateProfileState: updateProfileState ?? this.updateProfileState,
      changePasswordState: changePasswordState ?? this.changePasswordState,
    );
  }

  @override
  List<Object?> get props => [
    profile,
    uploadPicture,
    uploadVideo,
    followAction,
    uploadVideoProgress,
    updateProfileState,
    changePasswordState,
  ];
}

sealed class ProfileEvent {}

sealed class ProfileIntent {}

class GetProfileIntent extends ProfileIntent {}

class GetProfileByIdIntent extends ProfileIntent {
  final String userId;
  GetProfileByIdIntent({required this.userId});
}

class UploadProfilePictureIntent extends ProfileIntent {
  final File file;
  UploadProfilePictureIntent({required this.file});
}

class UploadProfileVideoIntent extends ProfileIntent {
  final File file;
  UploadProfileVideoIntent({required this.file});
}

class FollowUserIntent extends ProfileIntent {
  final String userId;
  FollowUserIntent({required this.userId});
}

class UnfollowUserIntent extends ProfileIntent {
  final String userId;
  UnfollowUserIntent({required this.userId});
}

class UpdateProfileIntent extends ProfileIntent {
  final UserProfileEntity updatedProfile;
  final File? profileImageFile;
  UpdateProfileIntent({required this.updatedProfile, this.profileImageFile});
}

class ChangePasswordIntent extends ProfileIntent {
  final String currentPassword;
  final String newPassword;
  ChangePasswordIntent({
    required this.currentPassword,
    required this.newPassword,
  });
}
