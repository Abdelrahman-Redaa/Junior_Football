class UserProfileEntity {
  final String? userId;
  final String? email;
  final String? phoneNumber;
  final String? userName;
  final String? fullName;
  final DateTime? dateOfBirth;
  final String? country;
  final String? playingPosition;
  final String? profileImageUrl;
  final double? height;
  final double? weight;
  final String? preferredFoot;
  final String? team;
  final int? xp;
  final String? bio;
  final String? coverImageUrl;
  final int? followersCount;
  final int? followingCount;
  final int? globalRank;
  final List<dynamic>? achievements;
  final List<dynamic>? posts;
  final bool? isFollowing;
  final List<String>? videosUrl;

  const UserProfileEntity({
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
    this.videosUrl,
  });

  UserProfileEntity copyWith({
    String? userId,
    String? email,
    String? phoneNumber,
    String? userName,
    String? fullName,
    DateTime? dateOfBirth,
    String? country,
    String? playingPosition,
    String? profileImageUrl,
    double? height,
    double? weight,
    String? preferredFoot,
    String? team,
    int? xp,
    String? bio,
    String? coverImageUrl,
    int? followersCount,
    int? followingCount,
    int? globalRank,
    List<dynamic>? achievements,
    List<dynamic>? posts,
    bool? isFollowing,
    List<String>? videosUrl,
  }) {
    return UserProfileEntity(
      userId: userId ?? this.userId,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      userName: userName ?? this.userName,
      fullName: fullName ?? this.fullName,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      country: country ?? this.country,
      playingPosition: playingPosition ?? this.playingPosition,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      preferredFoot: preferredFoot ?? this.preferredFoot,
      team: team ?? this.team,
      xp: xp ?? this.xp,
      bio: bio ?? this.bio,
      coverImageUrl: coverImageUrl ?? this.coverImageUrl,
      followersCount: followersCount ?? this.followersCount,
      followingCount: followingCount ?? this.followingCount,
      globalRank: globalRank ?? this.globalRank,
      achievements: achievements ?? this.achievements,
      posts: posts ?? this.posts,
      isFollowing: isFollowing ?? this.isFollowing,
      videosUrl: videosUrl ?? this.videosUrl,
    );
  }
}
