import 'package:equatable/equatable.dart';
import 'package:junior_football/core/base_bloc/base_state.dart';
import 'package:junior_football/feature/home/domain/entity/upload_video_entity.dart';
import 'package:junior_football/feature/home/domain/entity/weekly_plan_entity.dart';
import 'package:junior_football/feature/home/domain/entity/full_weekly_plan_entity.dart';
import 'package:junior_football/feature/home/domain/entity/training_lesson_entity.dart';
import 'package:junior_football/feature/home/domain/entity/training_dashboard_entity.dart';
import 'package:junior_football/feature/home/domain/entity/training_weekly_plan_entity.dart';

class HomeState extends Equatable {
  final BaseState<UploadVideoEntity>? uploadVideo;
  final BaseState<WeeklyPlanEntity> weeklyPlan;
  final BaseState<TrainingDashboardEntity> trainingDashboard;
  final BaseState<List<FullWeeklyPlanEntity>> fullWeeklyPlan;
  final BaseState<TrainingWeeklyPlanEntity> trainingWeeklyPlan;
  final BaseState<TodaySessionEntity> trainingDailySession;
  final BaseState<List<QuickRecommendationEntity>> trainingRecommendations;
  final BaseState<LessonsListEntity> speedLessons;
  final BaseState<LessonsListEntity> shootingLessons;
  final BaseState<LessonsListEntity> passingLessons;
  final double? progress;
  const HomeState({
    this.uploadVideo,
    required this.weeklyPlan,
    required this.trainingDashboard,
    required this.fullWeeklyPlan,
    required this.trainingWeeklyPlan,
    required this.trainingDailySession,
    required this.trainingRecommendations,
    required this.speedLessons,
    required this.shootingLessons,
    required this.passingLessons,
    this.progress,
  });
  HomeState copyWith({
    BaseState<UploadVideoEntity>? uploadVideo,
    BaseState<WeeklyPlanEntity>? weeklyPlan,
    BaseState<TrainingDashboardEntity>? trainingDashboard,
    BaseState<List<FullWeeklyPlanEntity>>? fullWeeklyPlan,
    BaseState<TrainingWeeklyPlanEntity>? trainingWeeklyPlan,
    BaseState<TodaySessionEntity>? trainingDailySession,
    BaseState<List<QuickRecommendationEntity>>? trainingRecommendations,
    BaseState<LessonsListEntity>? speedLessons,
    BaseState<LessonsListEntity>? shootingLessons,
    BaseState<LessonsListEntity>? passingLessons,
    double? progress,
  }) {
    return HomeState(
      uploadVideo: uploadVideo ?? this.uploadVideo,
      weeklyPlan: weeklyPlan ?? this.weeklyPlan,
      trainingDashboard: trainingDashboard ?? this.trainingDashboard,
      fullWeeklyPlan: fullWeeklyPlan ?? this.fullWeeklyPlan,
      trainingWeeklyPlan: trainingWeeklyPlan ?? this.trainingWeeklyPlan,
      trainingDailySession: trainingDailySession ?? this.trainingDailySession,
      trainingRecommendations:
          trainingRecommendations ?? this.trainingRecommendations,
      speedLessons: speedLessons ?? this.speedLessons,
      shootingLessons: shootingLessons ?? this.shootingLessons,
      passingLessons: passingLessons ?? this.passingLessons,
      progress: progress ?? this.progress,
    );
  }

  @override
  List<Object?> get props => [
    uploadVideo,
    progress,
    weeklyPlan,
    trainingDashboard,
    fullWeeklyPlan,
    trainingWeeklyPlan,
    trainingDailySession,
    trainingRecommendations,
    speedLessons,
    shootingLessons,
    passingLessons,
  ];
}

sealed class HomeEvent {}

class UploadVideoEvent extends HomeEvent {
  final String videoUrl;

  UploadVideoEvent(this.videoUrl);
}

class SendToast extends HomeEvent {
  final String message;

  SendToast(this.message);
}

sealed class HomeIntent {}

class UploadVideoIntent extends HomeIntent {
  UploadVideoIntent();
}

class GetWeeklyPlanIntent extends HomeIntent {
  GetWeeklyPlanIntent();
}

class GetTrainingDashboardIntent extends HomeIntent {
  GetTrainingDashboardIntent();
}

class GetFullWeeklyPlanIntent extends HomeIntent {
  GetFullWeeklyPlanIntent();
}

class GetTrainingWeeklyPlanIntent extends HomeIntent {
  GetTrainingWeeklyPlanIntent();
}

class GetTrainingDailySessionIntent extends HomeIntent {
  GetTrainingDailySessionIntent();
}

class GetTrainingRecommendationsIntent extends HomeIntent {
  GetTrainingRecommendationsIntent();
}

class GetTrainingLessonsIntent extends HomeIntent {
  GetTrainingLessonsIntent();
}
