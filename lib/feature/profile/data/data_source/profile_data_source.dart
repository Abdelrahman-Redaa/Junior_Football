import 'dart:io';
import 'package:junior_football/core/error_handling/result.dart';
import '../models/response_models/user_profile_dto.dart';

abstract interface class ProfileDataSource {
  Future<Result<UserProfileDto>> getUserProfile();
  Future<Result<UserProfileDto>> uploadProfilePicture(File file);
  Future<Result<String>> uploadProfileVideo(
    File file,
    void Function(int sent, int total)? onProgress,
  );
  Future<Result<void>> followUser(String userId);
  Future<Result<void>> unfollowUser(String userId);
}
