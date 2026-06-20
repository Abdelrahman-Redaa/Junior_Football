import 'package:junior_football/feature/profile/data/models/response_models/user_profile_dto.dart';
import 'package:junior_football/feature/profile/domain/entities/user_profile_entity.dart';

extension UserProfileMapper on UserProfileDto {
  UserProfileEntity toEntity() => UserProfileEntity(
    userId: userId,
    email: email,
    phoneNumber: phoneNumber,
    userName: userName,
    fullName: fullName,
    dateOfBirth: dateOfBirth,
    country: country,
    playingPosition: playingPosition,
    profileImageUrl: profileImageUrl,
    height: height,
    weight: weight,
    preferredFoot: preferredFoot,
    team: team,
    xp: xp,
    bio: bio,
    coverImageUrl: coverImageUrl,
    followersCount: followersCount,
    followingCount: followingCount,
    globalRank: globalRank,
    achievements: achievements,
    posts: posts,
    isFollowing: isFollowing,
  );
}
