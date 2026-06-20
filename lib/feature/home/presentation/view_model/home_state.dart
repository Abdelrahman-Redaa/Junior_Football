import 'package:equatable/equatable.dart';
import 'package:junior_football/core/base_bloc/base_state.dart';
import 'package:junior_football/feature/home/domain/entity/upload_video_entity.dart';
import 'package:junior_football/feature/home/domain/entity/weekly_plan_entity.dart';
import 'package:junior_football/feature/home/domain/entity/full_weekly_plan_entity.dart';
import 'package:junior_football/feature/home/domain/entity/training_dashboard_entity.dart';

class HomeState extends Equatable {
  final BaseState<UploadVideoEntity>? uploadVideo;
  final BaseState<WeeklyPlanEntity> weeklyPlan;
  final BaseState<TrainingDashboardEntity> trainingDashboard;
  final BaseState<List<FullWeeklyPlanEntity>> fullWeeklyPlan;
  final double? progress;
  const HomeState({
    this.uploadVideo,
    required this.weeklyPlan,
    required this.trainingDashboard,
    required this.fullWeeklyPlan,
    this.progress,
  });
  HomeState copyWith({
    BaseState<UploadVideoEntity>? uploadVideo,
    BaseState<WeeklyPlanEntity>? weeklyPlan,
    BaseState<TrainingDashboardEntity>? trainingDashboard,
    BaseState<List<FullWeeklyPlanEntity>>? fullWeeklyPlan,
    double? progress,
  }) {
    return HomeState(
      uploadVideo: uploadVideo ?? this.uploadVideo,
      weeklyPlan: weeklyPlan ?? this.weeklyPlan,
      trainingDashboard: trainingDashboard ?? this.trainingDashboard,
      fullWeeklyPlan: fullWeeklyPlan ?? this.fullWeeklyPlan,
      progress: progress ?? this.progress,
    );
  }

  @override
List<Object?> get props => [uploadVideo, progress, weeklyPlan, trainingDashboard, fullWeeklyPlan];
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
