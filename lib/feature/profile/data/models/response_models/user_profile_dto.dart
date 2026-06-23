import 'package:json_annotation/json_annotation.dart';

part 'user_profile_dto.g.dart';

@JsonSerializable()
class ProfileVideoDto {
  final String? id;
  final String? userId;
  final String? videoUrl;

  ProfileVideoDto({this.id, this.userId, this.videoUrl});

  factory ProfileVideoDto.fromJson(Map<String, dynamic> json) =>
      _$ProfileVideoDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileVideoDtoToJson(this);
}

@JsonSerializable()
class UserProfileDto {
  @JsonKey(name: "userId")
  final String? userId;
  @JsonKey(name: "email")
  final String? email;
  @JsonKey(name: "phoneNumber")
  final String? phoneNumber;
  @JsonKey(name: "userName")
  final String? userName;
  @JsonKey(name: "fullName")
  final String? fullName;
  @JsonKey(name: "dateOfBirth")
  final DateTime? dateOfBirth;
  @JsonKey(name: "country")
  final String? country;
  @JsonKey(name: "playingPosition")
  final String? playingPosition;
  @JsonKey(name: "profileImageUrl")
  final String? profileImageUrl;
  @JsonKey(name: "height")
  final double? height;
  @JsonKey(name: "weight")
  final double? weight;
  @JsonKey(name: "preferredFoot")
  final String? preferredFoot;
  @JsonKey(name: "team")
  final String? team;
  @JsonKey(name: "xp")
  final int? xp;
  @JsonKey(name: "bio")
  final String? bio;
  @JsonKey(name: "coverImageUrl")
  final String? coverImageUrl;
  @JsonKey(name: "followersCount")
  final int? followersCount;
  @JsonKey(name: "followingCount")
  final int? followingCount;
  @JsonKey(name: "globalRank")
  final int? globalRank;
  @JsonKey(name: "achievements")
  final List<dynamic>? achievements;
  @JsonKey(name: "posts")
  final List<dynamic>? posts;
  @JsonKey(name: "isFollowing")
  final bool? isFollowing;
  @JsonKey(name: "videos")
  final List<ProfileVideoDto>? videos;

  UserProfileDto({
    this.userId,
    this.email,
    this.phoneNumber,
    this.userName,
    this.fullName,
    this.dateOfBirth,
    this.country,
    this.playingPosition,
    this.profileImageUrl,
    this.height,
    this.weight,
    this.preferredFoot,
    this.team,
    this.xp,
    this.bio,
    this.coverImageUrl,
    this.followersCount,
    this.followingCount,
    this.globalRank,
    this.achievements,
    this.posts,
    this.isFollowing,
    this.videos,
  });

  factory UserProfileDto.fromJson(Map<String, dynamic> json) =>
      _$UserProfileDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UserProfileDtoToJson(this);
}
