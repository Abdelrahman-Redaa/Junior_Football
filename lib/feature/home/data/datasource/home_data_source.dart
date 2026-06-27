import 'package:junior_football/feature/home/data/models/request/analysis_ai_request.dart';
import 'package:junior_football/feature/home/data/models/response/analysis_ai_response.dart';
import 'package:junior_football/feature/home/data/models/response/community_feed.dart';
import 'package:junior_football/feature/home/data/models/response/upload_video_response.dart';
import 'package:junior_football/feature/home/data/models/response/full_weekly_plan_response.dart';
import 'package:junior_football/feature/home/data/models/response/training_dashboard.dart';
import 'package:junior_football/feature/home/data/models/response/training_lesson_response.dart';
import 'package:junior_football/feature/home/data/models/response/training_weekly_plan_response.dart';

import '../../../../core/error_handling/result.dart' show Result;

abstract interface class HomeDataSource {
  Future<Result<UploadVideoResponse>> uploadVideoToAi(
    String path,
    void Function(int sent, int total)? onProgress,
  );
  Future<Result<AnalysisAiResponse>> analysisAiVideo(
    AnalysisAiRequest analysisRequest,
    void Function(int sent, int total)? onProgress,
  );
  Future<Result<List<CommunityFeedResponse>>> getCommunityFeed();
  //Future<Result<WeeklyProcessResponse>> getWeeklyPlan();
  Future<Result<TrainingDashboard>> getTrainingDashboard();
  Future<Result<List<FullWeeklyPlanResponse>>> getFullWeeklyPlan();
  Future<Result<TrainingWeeklyPlanResponse>> getTrainingWeeklyPlan();
  Future<Result<TodaySession>> getTrainingDailySession();
  Future<Result<List<QuickRecommendations>>> getTrainingRecommendations();
  Future<Result<LessonsListResponse>> getSpeedLessons();
  Future<Result<LessonsListResponse>> getShootingLessons();
  Future<Result<LessonsListResponse>> getPassingLessons();
}
