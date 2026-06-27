import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:junior_football/core/api/api_client.dart';
import 'package:junior_football/core/error_handling/execute_api.dart';
import 'package:junior_football/core/error_handling/result.dart';
import 'package:junior_football/feature/home/data/datasource/home_data_source.dart';
import 'package:junior_football/feature/home/data/models/request/analysis_ai_request.dart';
import 'package:junior_football/feature/home/data/models/response/analysis_ai_response.dart';
import 'package:junior_football/feature/home/data/models/response/community_feed.dart';
import 'package:junior_football/feature/home/data/models/response/upload_video_response.dart';
import 'package:junior_football/feature/home/data/models/response/full_weekly_plan_response.dart';
import 'package:junior_football/feature/home/data/models/response/training_dashboard.dart';
import 'package:junior_football/feature/home/data/models/response/training_lesson_response.dart';
import 'package:junior_football/feature/home/data/models/response/training_weekly_plan_response.dart';

@LazySingleton(as: HomeDataSource)
class HomeDataSourceImpl implements HomeDataSource {
  final ApiClient _apiClient;

  HomeDataSourceImpl(this._apiClient);
  @override
  Future<Result<UploadVideoResponse>> uploadVideoToAi(
    String path,
    void Function(int sent, int total)? onProgress,
  ) => executeApi(
    () => _apiClient.uploadVideoAi(file: File(path), onProgress: onProgress),
  );

  @override
  Future<Result<AnalysisAiResponse>> analysisAiVideo(
    AnalysisAiRequest analysisRequest,
    void Function(int sent, int total)? onProgress,
  ) => executeApi(
    () => _apiClient.analysisVideo(
      analysisAiRequest: analysisRequest,
      onProgress: onProgress,
    ),
  );

  @override
  Future<Result<List<CommunityFeedResponse>>> getCommunityFeed() =>
      executeApi(() => _apiClient.getCommunityFeed());

  // @override
  // Future<Result<WeeklyProcessResponse>> getWeeklyPlan() => executeApi(
  //   () => _apiClient.getWeeklyPlan(),
  // );

  @override
  Future<Result<TrainingDashboard>> getTrainingDashboard() =>
      executeApi(() => _apiClient.getTrainingDashboard());

  @override
  Future<Result<List<FullWeeklyPlanResponse>>> getFullWeeklyPlan() =>
      executeApi(() => _apiClient.getFullWeeklyPlan());

  @override
  Future<Result<TrainingWeeklyPlanResponse>> getTrainingWeeklyPlan() =>
      executeApi(() => _apiClient.getTrainingWeeklyPlan());

  @override
  Future<Result<TodaySession>> getTrainingDailySession() =>
      executeApi(() => _apiClient.getTrainingDailySession());

  @override
  Future<Result<List<QuickRecommendations>>> getTrainingRecommendations() =>
      executeApi(() => _apiClient.getTrainingRecommendations());

  @override
  Future<Result<LessonsListResponse>> getSpeedLessons() =>
      executeApi(() => _apiClient.getSpeedLessons());

  @override
  Future<Result<LessonsListResponse>> getShootingLessons() =>
      executeApi(() => _apiClient.getShootingLessons());

  @override
  Future<Result<LessonsListResponse>> getPassingLessons() =>
      executeApi(() => _apiClient.getPassingLessons());
}
