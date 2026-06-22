import 'dart:io';
import 'package:junior_football/core/error_handling/result.dart';
import '../entities/user_profile_entity.dart';

abstract interface class ProfileRepo {
  Future<Result<UserProfileEntity>> getUserProfile();
  Future<Result<UserProfileEntity>> getUserProfileById(String userId);
  Future<Result<UserProfileEntity>> uploadProfilePicture(File file);
  Future<Result<String>> uploadProfileVideo(
    File file,
    void Function(int sent, int total)? onProgress,
  );
  Future<Result<void>> followUser(String userId);
  Future<Result<void>> unfollowUser(String userId);
}
