class LessonsListResponse {
  final String? category;
  final String? title;
  final String? description;
  final String? featuredVideoUrl;
  final int? totalLessons;
  final int? completedLessons;
  final num? progressPercentage;
  final int? totalXpAvailable;
  final List<LessonResponse>? lessons;

  const LessonsListResponse({
    this.category,
    this.title,
    this.description,
    this.featuredVideoUrl,
    this.totalLessons,
    this.completedLessons,
    this.progressPercentage,
    this.totalXpAvailable,
    this.lessons,
  });

  factory LessonsListResponse.fromJson(Map<String, dynamic> json) {
    return LessonsListResponse(
      category: json['category'] as String?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      featuredVideoUrl: json['featuredVideoUrl'] as String?,
      totalLessons: (json['totalLessons'] as num?)?.toInt(),
      completedLessons: (json['completedLessons'] as num?)?.toInt(),
      progressPercentage: json['progressPercentage'] as num?,
      totalXpAvailable: (json['totalXpAvailable'] as num?)?.toInt(),
      lessons: (json['lessons'] as List<dynamic>?)
          ?.map((e) => LessonResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class LessonResponse {
  final String? id;
  final String? title;
  final String? description;
  final int? durationMinutes;
  final int? xpReward;
  final String? difficulty;
  final String? category;
  final String? coachNote;
  final String? videoUrl;
  final String? thumbnailUrl;
  final bool? isCompleted;
  final bool? isLocked;
  final int? order;
  final List<String>? skills;
  final List<LessonDrillResponse>? drills;

  const LessonResponse({
    this.id,
    this.title,
    this.description,
    this.durationMinutes,
    this.xpReward,
    this.difficulty,
    this.category,
    this.coachNote,
    this.videoUrl,
    this.thumbnailUrl,
    this.isCompleted,
    this.isLocked,
    this.order,
    this.skills,
    this.drills,
  });

  factory LessonResponse.fromJson(Map<String, dynamic> json) {
    return LessonResponse(
      id: json['id'] as String?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      durationMinutes: (json['durationMinutes'] as num?)?.toInt(),
      xpReward: (json['xpReward'] as num?)?.toInt(),
      difficulty: json['difficulty'] as String?,
      category: json['category'] as String?,
      coachNote: json['coachNote'] as String?,
      videoUrl: json['videoUrl'] as String?,
      thumbnailUrl: json['thumbnailUrl'] as String?,
      isCompleted: json['isCompleted'] as bool?,
      isLocked: json['isLocked'] as bool?,
      order: (json['order'] as num?)?.toInt(),
      skills: (json['skills'] as List<dynamic>?)
          ?.map((e) => e.toString())
          .toList(),
      drills: (json['drills'] as List<dynamic>?)
          ?.map((e) => LessonDrillResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class LessonDrillResponse {
  final String? title;
  final String? description;
  final int? repetitions;
  final int? durationSeconds;
  final String? instructions;

  const LessonDrillResponse({
    this.title,
    this.description,
    this.repetitions,
    this.durationSeconds,
    this.instructions,
  });

  factory LessonDrillResponse.fromJson(Map<String, dynamic> json) {
    return LessonDrillResponse(
      title: json['title'] as String?,
      description: json['description'] as String?,
      repetitions: (json['repetitions'] as num?)?.toInt(),
      durationSeconds: (json['durationSeconds'] as num?)?.toInt(),
      instructions: json['instructions'] as String?,
    );
  }
}
