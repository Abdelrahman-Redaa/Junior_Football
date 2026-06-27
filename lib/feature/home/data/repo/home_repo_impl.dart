import 'package:injectable/injectable.dart';
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
import 'package:junior_football/feature/home/domain/entity/analysis_ai_response_entity.dart';
import 'package:junior_football/feature/home/domain/entity/community_feed_entity.dart';
import 'package:junior_football/feature/home/domain/entity/upload_video_entity.dart';
import 'package:junior_football/feature/home/domain/entity/training_dashboard_entity.dart';
import 'package:junior_football/feature/home/domain/entity/full_weekly_plan_entity.dart';
import 'package:junior_football/feature/home/domain/entity/training_lesson_entity.dart';
import 'package:junior_football/feature/home/domain/entity/training_weekly_plan_entity.dart';
import 'package:junior_football/feature/home/domain/repo/home_repo.dart';
import 'package:junior_football/feature/home/mapper/home_mapper.dart';

@LazySingleton(as: HomeRepo)
class HomeRepoImpl implements HomeRepo {
  final HomeDataSource _homeDataSource;
  HomeRepoImpl(this._homeDataSource);

  @override
  Future<Result<UploadVideoEntity>> uploadVideo(
    String path,
    void Function(int sent, int total)? onProgress,
  ) async {
    final result = await _homeDataSource.uploadVideoToAi(path, onProgress);
    switch (result) {
      case Success<UploadVideoResponse>():
        return Success(result.data.toEntity());
      case Failure<UploadVideoResponse>():
        return Failure(result.errorMessage);
    }
  }

  @override
  Future<Result<AnalysisEntity>> analysisAiVideo(
    AnalysisAiRequest analysisRequest,
    void Function(int sent, int total)? onProgress,
  ) async {
    final result = await _homeDataSource.analysisAiVideo(
      analysisRequest,
      onProgress,
    );
    switch (result) {
      case Success<AnalysisAiResponse>():
        return Success(result.data.toEntity());
      case Failure<AnalysisAiResponse>():
        return Failure(result.errorMessage);
    }
  }

  @override
  Future<Result<List<CommunityFeedEntity>>> getCommunityFeed() async {
    final result = await _homeDataSource.getCommunityFeed();
    switch (result) {
      case Success<List<CommunityFeedResponse>>():
        return Success(result.data.map((e) => e.toEntity()).toList());
      case Failure<List<CommunityFeedResponse>>():
        return Failure(result.errorMessage);
    }
  }

  // @override
  // Future<Result<WeeklyPlanEntity>> getWeeklyPlan() async {
  //   final result = await _homeDataSource.getWeeklyPlan();
  //   switch (result) {
  //     case Success<WeeklyProcessResponse>():
  //       return Success(result.data.toEntity());
  //     case Failure<WeeklyProcessResponse>():
  //       return Failure(result.errorMessage);
  //   }
  // }

  @override
  Future<Result<TrainingDashboardEntity>> getTrainingDashboard() async {
    final result = await _homeDataSource.getTrainingDashboard();
    switch (result) {
      case Success<TrainingDashboard>():
        return Success(result.data.toEntity());
      case Failure<TrainingDashboard>():
        return Failure(result.errorMessage);
    }
  }

  @override
  Future<Result<List<FullWeeklyPlanEntity>>> getFullWeeklyPlan() async {
    final result = await _homeDataSource.getFullWeeklyPlan();
    switch (result) {
      case Success<List<FullWeeklyPlanResponse>>():
        return Success(result.data.map((e) => e.toEntity()).toList());
      case Failure<List<FullWeeklyPlanResponse>>():
        return Failure(result.errorMessage);
    }
  }

  @override
  Future<Result<TrainingWeeklyPlanEntity>> getTrainingWeeklyPlan() async {
    final result = await _homeDataSource.getTrainingWeeklyPlan();
    switch (result) {
      case Success<TrainingWeeklyPlanResponse>():
        return Success(result.data.toEntity());
      case Failure<TrainingWeeklyPlanResponse>():
        return Failure(result.errorMessage);
    }
  }

  @override
  Future<Result<TodaySessionEntity>> getTrainingDailySession() async {
    final result = await _homeDataSource.getTrainingDailySession();
    switch (result) {
      case Success<TodaySession>():
        return Success(result.data.toEntity());
      case Failure<TodaySession>():
        return Failure(result.errorMessage);
    }
  }

  @override
  Future<Result<List<QuickRecommendationEntity>>>
  getTrainingRecommendations() async {
    final result = await _homeDataSource.getTrainingRecommendations();
    switch (result) {
      case Success<List<QuickRecommendations>>():
        return Success(result.data.map((e) => e.toEntity()).toList());
      case Failure<List<QuickRecommendations>>():
        return Failure(result.errorMessage);
    }
  }

  @override
  Future<Result<LessonsListEntity>> getSpeedLessons() =>
      _mapLessons(_homeDataSource.getSpeedLessons());

  @override
  Future<Result<LessonsListEntity>> getShootingLessons() =>
      _mapLessons(_homeDataSource.getShootingLessons());

  @override
  Future<Result<LessonsListEntity>> getPassingLessons() =>
      _mapLessons(_homeDataSource.getPassingLessons());

  Future<Result<LessonsListEntity>> _mapLessons(
    Future<Result<LessonsListResponse>> request,
  ) async {
    final result = await request;
    switch (result) {
      case Success<LessonsListResponse>():
        return Success(result.data.toEntity());
      case Failure<LessonsListResponse>():
        return Failure(result.errorMessage);
    }
  }
}
