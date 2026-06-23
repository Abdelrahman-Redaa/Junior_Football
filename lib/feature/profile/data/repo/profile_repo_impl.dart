import 'dart:io';
import 'package:injectable/injectable.dart';
import 'package:junior_football/core/error_handling/result.dart';
import 'package:junior_football/feature/profile/data/data_source/profile_data_source.dart';
import 'package:junior_football/feature/profile/mapper/profile_mapper.dart';
import '../models/response_models/user_profile_dto.dart';
import 'package:junior_football/feature/profile/domain/entities/user_profile_entity.dart';
import 'package:junior_football/feature/profile/domain/repo/profile_repo.dart';

@LazySingleton(as: ProfileRepo)
class ProfileRepoImpl implements ProfileRepo {
  final ProfileDataSource _profileDataSource;
  ProfileRepoImpl(this._profileDataSource);

  @override
  Future<Result<UserProfileEntity>> getUserProfile() async {
    final result = await _profileDataSource.getUserProfile();
    switch (result) {
      case Success<UserProfileDto>():
        return Success(result.data.toEntity());
      case Failure<UserProfileDto>():
        return Failure(result.errorMessage);
    }
  }

  @override
  Future<Result<UserProfileEntity>> getUserProfileById(String userId) async {
    final result = await _profileDataSource.getUserProfileById(userId);
    switch (result) {
      case Success<UserProfileDto>():
        return Success(result.data.toEntity());
      case Failure<UserProfileDto>():
        return Failure(result.errorMessage);
    }
  }

  @override
  Future<Result<UserProfileEntity>> uploadProfilePicture(File file) async {
    final result = await _profileDataSource.uploadProfilePicture(file);
    switch (result) {
      case Success<UserProfileDto>():
        return Success(result.data.toEntity());
      case Failure<UserProfileDto>():
        return Failure(result.errorMessage);
    }
  }

  @override
  Future<Result<UserProfileEntity>> updateProfile({
    String? bio,
    double? height,
    double? weight,
    String? preferredFoot,
    String? team,
    File? profileImage,
  }) async {
    final result = await _profileDataSource.updateProfile(
      bio: bio,
      height: height,
      weight: weight,
      preferredFoot: preferredFoot,
      team: team,
      profileImage: profileImage,
    );

    switch (result) {
      case Success<dynamic>():
        return getUserProfile();
      case Failure<dynamic>():
        return Failure(result.errorMessage);
    }
  }

  @override
  Future<Result<String>> uploadProfileVideo(
    File file,
    void Function(int sent, int total)? onProgress,
  ) => _profileDataSource.uploadProfileVideo(file, onProgress);

  @override
  Future<Result<void>> followUser(String userId) =>
      _profileDataSource.followUser(userId);

  @override
  Future<Result<void>> unfollowUser(String userId) async {
    return await _profileDataSource.unfollowUser(userId);
  }

  @override
  Future<Result<void>> changePassword(
    String currentPassword,
    String newPassword,
  ) async {
    return await _profileDataSource.changePassword(
      currentPassword,
      newPassword,
    );
  }
}
