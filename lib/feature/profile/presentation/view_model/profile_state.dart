import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:junior_football/core/base_bloc/base_state.dart';
import 'package:junior_football/feature/profile/domain/entities/user_profile_entity.dart';

class ProfileState extends Equatable {
  final BaseState<UserProfileEntity> profile;
  final BaseState<bool> uploadPicture;
  final BaseState<String> uploadVideo;
  final BaseState<bool> followAction;
  final double uploadVideoProgress;
  final List<String> uploadedVideoUrls;

  const ProfileState({
    required this.profile,
    required this.uploadPicture,
    required this.uploadVideo,
    required this.followAction,
    required this.uploadVideoProgress,
    required this.uploadedVideoUrls,
  });

  ProfileState copyWith({
    BaseState<UserProfileEntity>? profile,
    BaseState<bool>? uploadPicture,
    BaseState<String>? uploadVideo,
    BaseState<bool>? followAction,
    double? uploadVideoProgress,
    List<String>? uploadedVideoUrls,
  }) {
    return ProfileState(
      profile: profile ?? this.profile,
      uploadPicture: uploadPicture ?? this.uploadPicture,
      uploadVideo: uploadVideo ?? this.uploadVideo,
      followAction: followAction ?? this.followAction,
      uploadVideoProgress: uploadVideoProgress ?? this.uploadVideoProgress,
      uploadedVideoUrls: uploadedVideoUrls ?? this.uploadedVideoUrls,
    );
  }

  @override
  List<Object?> get props => [
    profile,
    uploadPicture,
    uploadVideo,
    followAction,
    uploadVideoProgress,
    uploadedVideoUrls,
  ];
}

sealed class ProfileEvent {}

sealed class ProfileIntent {}

class GetProfileIntent extends ProfileIntent {}

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
