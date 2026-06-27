class LessonsListEntity {
  final String category;
  final String title;
  final String description;
  final String featuredVideoUrl;
  final int totalLessons;
  final int completedLessons;
  final double progressPercentage;
  final int totalXpAvailable;
  final List<LessonEntity> lessons;

  const LessonsListEntity({
    required this.category,
    required this.title,
    required this.description,
    required this.featuredVideoUrl,
    required this.totalLessons,
    required this.completedLessons,
    required this.progressPercentage,
    required this.totalXpAvailable,
    required this.lessons,
  });
}

class LessonEntity {
  final String id;
  final String title;
  final String description;
  final int durationMinutes;
  final int xpReward;
  final String difficulty;
  final String category;
  final String coachNote;
  final String videoUrl;
  final String thumbnailUrl;
  final bool isCompleted;
  final bool isLocked;
  final int order;
  final List<String> skills;
  final List<LessonDrillEntity> drills;

  const LessonEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.durationMinutes,
    required this.xpReward,
    required this.difficulty,
    required this.category,
    required this.coachNote,
    required this.videoUrl,
    required this.thumbnailUrl,
    required this.isCompleted,
    required this.isLocked,
    required this.order,
    required this.skills,
    required this.drills,
  });
}

class LessonDrillEntity {
  final String title;
  final String description;
  final int repetitions;
  final int durationSeconds;
  final String instructions;

  const LessonDrillEntity({
    required this.title,
    required this.description,
    required this.repetitions,
    required this.durationSeconds,
    required this.instructions,
  });
}
