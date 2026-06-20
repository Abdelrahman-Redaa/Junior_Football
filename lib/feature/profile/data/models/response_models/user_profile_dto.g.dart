// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserProfileDto _$UserProfileDtoFromJson(Map<String, dynamic> json) =>
    UserProfileDto(
      userId: json['userId'] as String?,
      email: json['email'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      userName: json['userName'] as String?,
      fullName: json['fullName'] as String?,
      dateOfBirth: json['dateOfBirth'] == null
          ? null
          : DateTime.parse(json['dateOfBirth'] as String),
      country: json['country'] as String?,
      playingPosition: json['playingPosition'] as String?,
      profileImageUrl: json['profileImageUrl'] as String?,
      height: (json['height'] as num?)?.toDouble(),
      weight: (json['weight'] as num?)?.toDouble(),
      preferredFoot: json['preferredFoot'] as String?,
      team: json['team'] as String?,
      xp: (json['xp'] as num?)?.toInt(),
      bio: json['bio'] as String?,
      coverImageUrl: json['coverImageUrl'] as String?,
      followersCount: (json['followersCount'] as num?)?.toInt(),
      followingCount: (json['followingCount'] as num?)?.toInt(),
      globalRank: (json['globalRank'] as num?)?.toInt(),
      achievements: json['achievements'] as List<dynamic>?,
      posts: json['posts'] as List<dynamic>?,
      isFollowing: json['isFollowing'] as bool?,
    );

Map<String, dynamic> _$UserProfileDtoToJson(UserProfileDto instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'userName': instance.userName,
      'fullName': instance.fullName,
      'dateOfBirth': instance.dateOfBirth?.toIso8601String(),
      'country': instance.country,
      'playingPosition': instance.playingPosition,
      'profileImageUrl': instance.profileImageUrl,
      'height': instance.height,
      'weight': instance.weight,
      'preferredFoot': instance.preferredFoot,
      'team': instance.team,
      'xp': instance.xp,
      'bio': instance.bio,
      'coverImageUrl': instance.coverImageUrl,
      'followersCount': instance.followersCount,
      'followingCount': instance.followingCount,
      'globalRank': instance.globalRank,
      'achievements': instance.achievements,
      'posts': instance.posts,
      'isFollowing': instance.isFollowing,
    };
