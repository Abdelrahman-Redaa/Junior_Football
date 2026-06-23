import 'dart:io';
import 'package:injectable/injectable.dart';
import 'package:junior_football/core/api/api_client.dart';
import 'package:junior_football/core/error_handling/execute_api.dart';
import 'package:junior_football/core/error_handling/result.dart';
import 'package:junior_football/feature/community/data/models/created_response.dart';
import 'package:junior_football/feature/home/data/models/response/upload_video_response.dart';
import '../models/response_models/user_profile_dto.dart';
import 'profile_data_source.dart';

@LazySingleton(as: ProfileDataSource)
class ProfileDataSourceImpl implements ProfileDataSource {
  final ApiClient _apiClient;

  ProfileDataSourceImpl(this._apiClient);

  @override
  Future<Result<UserProfileDto>> getUserProfile() =>
      executeApi(() => _apiClient.getUserProfile());

  @override
  Future<Result<UserProfileDto>> getUserProfileById(String userId) =>
      executeApi(() => _apiClient.getUserProfileById(userId));

  @override
  Future<Result<UserProfileDto>> uploadProfilePicture(File file) =>
      executeApi(() => _apiClient.uploadProfilePicture(file: file));

  @override
  Future<Result<dynamic>> updateProfile({
    String? bio,
    double? height,
    double? weight,
    String? preferredFoot,
    String? team,
    File? profileImage,
  }) async {
    return executeApi(
      () => _apiClient.updateProfile(
        bio: bio,
        height: height,
        weight: weight,
        preferredFoot: preferredFoot,
        team: team,
        profileImage: profileImage,
      ),
    );
  }

  @override
  Future<Result<String>> uploadProfileVideo(
    File file,
    void Function(int sent, int total)? onProgress,
  ) async {
    final result = await executeApi(
      () => _apiClient.uploadProfileVideo(file: file, onProgress: onProgress),
    );

    switch (result) {
      case Success<UploadVideoResponse>():
        final videoUrl = result.data.videoUrl;
        if (videoUrl == null || videoUrl.isEmpty) {
          return Failure('Video upload succeeded without a video URL');
        }
        return Success(videoUrl);
      case Failure<UploadVideoResponse>():
        return Failure(result.errorMessage);
    }
  }

  @override
  Future<Result<void>> followUser(String userId) => executeApi(() async {
    await _apiClient.followUser(userId);
  });

  @override
  Future<Result<void>> unfollowUser(String userId) => executeApi(() async {
    await _apiClient.unfollowUser(userId);
  });

  @override
  Future<Result<void>> changePassword(String currentPassword, String newPassword) => executeApi(() async {
    await _apiClient.changePassword(
      body: {
        'currentPassword': currentPassword,
        'newPassword': newPassword,
      },
    );
  });
}
