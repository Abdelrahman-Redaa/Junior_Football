import 'package:junior_football/feature/home/data/models/response/analysis_ai_response.dart';
import 'package:junior_football/feature/home/data/models/response/community_feed.dart';
import 'package:junior_football/feature/home/data/models/response/upload_video_response.dart';
import 'package:junior_football/feature/home/data/models/response/weekly_process_response.dart';
import 'package:junior_football/feature/home/data/models/response/full_weekly_plan_response.dart';
import 'package:junior_football/feature/home/data/models/response/training_dashboard.dart';
import 'package:junior_football/feature/home/data/models/response/training_lesson_response.dart';
import 'package:junior_football/feature/home/data/models/response/training_weekly_plan_response.dart';
import 'package:junior_football/feature/home/domain/entity/analysis_ai_response_entity.dart';
import 'package:junior_football/feature/home/domain/entity/community_feed_entity.dart';
import 'package:junior_football/feature/home/domain/entity/upload_video_entity.dart';
import 'package:junior_football/feature/home/domain/entity/weekly_plan_entity.dart';
import 'package:junior_football/feature/home/domain/entity/training_dashboard_entity.dart';
import 'package:junior_football/feature/home/domain/entity/full_weekly_plan_entity.dart';
import 'package:junior_football/feature/home/domain/entity/training_lesson_entity.dart';
import 'package:junior_football/feature/home/domain/entity/training_weekly_plan_entity.dart';

extension UploadVideoMapper on UploadVideoResponse {
  UploadVideoEntity toEntity() => UploadVideoEntity(videoUrl: videoUrl ?? "");
}

extension AnalysisAiResponseMapper on AnalysisAiResponse {
  AnalysisEntity toEntity() {
    return AnalysisEntity(
      message: message ?? '',
      data:
          data?.toEntity() ??
          DataEntity(
            skills: SkillsEntity(
              speed: 0,
              shooting: 0,
              passing: 0,
              positioning: 0,
              reaction: 0,
            ),
            advice: '',
          ),
    );
  }
}

extension DataMapper on Data {
  DataEntity toEntity() {
    return DataEntity(
      skills:
          skills?.toEntity() ??
          SkillsEntity(
            speed: 0,
            shooting: 0,
            passing: 0,
            positioning: 0,
            reaction: 0,
          ),
      advice: advice ?? '',
    );
  }
}

extension SkillsMapper on Skills {
  SkillsEntity toEntity() {
    return SkillsEntity(
      speed: speed ?? 0,
      shooting: shooting ?? 0,
      passing: passing ?? 0,
      positioning: positioning ?? 0,
      reaction: reaction ?? 0,
    );
  }
}

extension CommunityFeedMapper on CommunityFeedResponse {
  CommunityFeedEntity toEntity() {
    return CommunityFeedEntity(
      id: id,
      content: content,
      mediaUrl: imageUrl,
      createdAt: createdAt,
      userId: userId,
      userFullName: userName,
      userProfilePicture: userProfileImage,
      likesCount: likesCount,
      commentsCount: commentsCount,
      isLikedByCurrentUser: isLikedByMe,
      comments: comments?.map((e) => e.toEntity()).toList(),
    );
  }
}

extension CommentsMapper on Comments {
  CommentsEntity toEntity() {
    return CommentsEntity(
      id: id ?? '',
      userId: userId ?? '',
      userName: userName ?? '',
      userProfileImage: userProfileImage ?? '',
      content: content ?? '',
    );
  }
}

extension WeeklyProcessResponseMapper on WeeklyProcessResponse {
  WeeklyPlanEntity toEntity() {
    return WeeklyPlanEntity(
      totalXp: totalXp ?? 0,
      totalSessionsCount: totalSessionsCount ?? 0,
      weeklyProgress: weeklyProgress?.map((e) => e.toEntity()).toList() ?? [],
    );
  }
}

extension WeeklyProgressMapper on WeeklyProgress {
  WeeklyDayProgressEntity toEntity() {
    return WeeklyDayProgressEntity(
      dayName: dayName ?? '',
      xpEarned: xpEarned ?? 0,
    );
  }
}

extension TrainingDashboardMapper on TrainingDashboard {
  TrainingDashboardEntity toEntity() {
    return TrainingDashboardEntity(
      userName: userName ?? '',
      userLevel: userLevel ?? '',
      userAvatarUrl: userAvatarUrl ?? '',
      totalXp: totalXp ?? 0,
      nextLevelXp: nextLevelXp ?? 0,
      xpProgress: xpProgress ?? 0,
      weeklySessionsCompleted: weeklySessionsCompleted ?? 0,
      weeklySessionsTotal: weeklySessionsTotal ?? 0,
      weeklyProgress: weeklyProgress ?? 0,
      totalCompletedSessions: totalCompletedSessions ?? 0,
      totalTrainingMinutes: totalTrainingMinutes ?? 0,
      currentStreak: currentStreak ?? 0,
      todaySession: todaySession?.toEntity(),
      summaryCards: summaryCards?.map((e) => e.toEntity()).toList() ?? [],
      weeklyActivity: weeklyActivity?.map((e) => e.toEntity()).toList() ?? [],
      recentBadges: recentBadges ?? [],
      quickRecommendations:
          quickRecommendations?.map((e) => e.toEntity()).toList() ?? [],
    );
  }
}

extension TodaySessionMapper on TodaySession {
  TodaySessionEntity toEntity() {
    return TodaySessionEntity(
      sessionId: sessionId ?? '',
      title: title ?? '',
      description: description ?? '',
      durationMinutes: durationMinutes ?? 0,
      xpReward: xpReward ?? 0,
      difficulty: difficulty ?? '',
      status: status ?? '',
      thumbnailUrl: thumbnailUrl ?? '',
      coachNote: coachNote ?? '',
      estimatedCalories: estimatedCalories ?? 0,
      drillsCount: drillsCount ?? 0,
      sessionType: sessionType ?? '',
      tags: tags ?? [],
      drills: drills ?? [],
    );
  }
}

extension SummaryCardsMapper on SummaryCards {
  SummaryCardEntity toEntity() {
    return SummaryCardEntity(
      title: title ?? '',
      value: value ?? '',
      subtitle: subtitle ?? '',
      iconName: iconName ?? '',
      color: color ?? '',
    );
  }
}

extension WeeklyActivityMapper on WeeklyActivity {
  WeeklyActivityEntity toEntity() {
    return WeeklyActivityEntity(
      dayName: dayName ?? '',
      xpEarned: xpEarned ?? 0,
    );
  }
}

extension QuickRecommendationsMapper on QuickRecommendations {
  QuickRecommendationEntity toEntity() {
    return QuickRecommendationEntity(
      id: id ?? '',
      title: title ?? '',
      description: description ?? '',
      type: type ?? '',
      priority: priority ?? '',
      linkedSessionId: linkedSessionId,
      linkedSessionTitle: linkedSessionTitle ?? '',
      linkedLessonId: linkedLessonId ?? '',
      iconName: iconName ?? '',
      color: color ?? '',
      xpBonus: xpBonus ?? 0,
      actionLabel: actionLabel ?? '',
    );
  }
}

extension FullWeeklyPlanResponseMapper on FullWeeklyPlanResponse {
  FullWeeklyPlanEntity toEntity() {
    return FullWeeklyPlanEntity(
      dayName: dayName ?? '',
      isToday: isToday ?? false,
      sessions: sessions?.map((e) => e.toEntity()).toList() ?? [],
    );
  }
}

extension SessionsMapper on Sessions {
  HomeSessionEntity toEntity() {
    return HomeSessionEntity(
      id: id ?? '',
      title: title ?? '',
      description: description ?? '',
      expectedDurationMinutes: expectedDurationMinutes ?? 0,
      rewardXp: rewardXp ?? 0,
      thumbnailUrl: thumbnailUrl ?? '',
      isCompleted: isCompleted ?? false,
      drills: drills?.map((e) => e.toEntity()).toList() ?? [],
    );
  }
}

extension DrillsMapper on Drills {
  DrillEntity toEntity() {
    return DrillEntity(
      id: id ?? '',
      title: title ?? '',
      description: description ?? '',
      repetitions: repetitions ?? 0,
      videoUrl: videoUrl ?? '',
      orderIndex: orderIndex ?? 0,
    );
  }
}

extension TrainingWeeklyPlanResponseMapper on TrainingWeeklyPlanResponse {
  TrainingWeeklyPlanEntity toEntity() {
    return TrainingWeeklyPlanEntity(
      weekStartDate: weekStartDate ?? '',
      weekEndDate: weekEndDate ?? '',
      completedDays: completedDays ?? 0,
      totalDays: totalDays ?? 0,
      completionProgress: (completionProgress ?? 0).toDouble(),
      totalXpAvailable: totalXpAvailable ?? 0,
      totalXpEarned: totalXpEarned ?? 0,
      days: days?.map((e) => e.toEntity()).toList() ?? [],
    );
  }
}

extension TrainingWeeklyDayResponseMapper on TrainingWeeklyDayResponse {
  TrainingWeeklyDayEntity toEntity() {
    return TrainingWeeklyDayEntity(
      planId: planId ?? '',
      day: day ?? '',
      dayShort: dayShort ?? '',
      date: date ?? '',
      isToday: isToday ?? false,
      isCompleted: isCompleted ?? false,
      hasSession: hasSession ?? false,
      isRestDay: isRestDay ?? false,
      xpEarned: xpEarned ?? 0,
      session: session?.toEntity(),
    );
  }
}

extension LessonsListResponseMapper on LessonsListResponse {
  LessonsListEntity toEntity() {
    return LessonsListEntity(
      category: category ?? '',
      title: title ?? '',
      description: description ?? '',
      featuredVideoUrl: featuredVideoUrl ?? '',
      totalLessons: totalLessons ?? 0,
      completedLessons: completedLessons ?? 0,
      progressPercentage: (progressPercentage ?? 0).toDouble(),
      totalXpAvailable: totalXpAvailable ?? 0,
      lessons: lessons?.map((e) => e.toEntity()).toList() ?? [],
    );
  }
}

extension LessonResponseMapper on LessonResponse {
  LessonEntity toEntity() {
    return LessonEntity(
      id: id ?? '',
      title: title ?? '',
      description: description ?? '',
      durationMinutes: durationMinutes ?? 0,
      xpReward: xpReward ?? 0,
      difficulty: difficulty ?? '',
      category: category ?? '',
      coachNote: coachNote ?? '',
      videoUrl: videoUrl ?? '',
      thumbnailUrl: thumbnailUrl ?? '',
      isCompleted: isCompleted ?? false,
      isLocked: isLocked ?? false,
      order: order ?? 0,
      skills: skills ?? [],
      drills: drills?.map((e) => e.toEntity()).toList() ?? [],
    );
  }
}

extension LessonDrillResponseMapper on LessonDrillResponse {
  LessonDrillEntity toEntity() {
    return LessonDrillEntity(
      title: title ?? '',
      description: description ?? '',
      repetitions: repetitions ?? 0,
      durationSeconds: durationSeconds ?? 0,
      instructions: instructions ?? '',
    );
  }
}
