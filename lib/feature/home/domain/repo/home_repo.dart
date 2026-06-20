import 'package:junior_football/core/error_handling/result.dart';
import 'package:junior_football/feature/home/data/models/request/analysis_ai_request.dart';
import 'package:junior_football/feature/home/domain/entity/analysis_ai_response_entity.dart';
import 'package:junior_football/feature/home/domain/entity/community_feed_entity.dart';
import 'package:junior_football/feature/home/domain/entity/upload_video_entity.dart';
import 'package:junior_football/feature/home/domain/entity/weekly_plan_entity.dart';
import 'package:junior_football/feature/home/domain/entity/full_weekly_plan_entity.dart';
import 'package:junior_football/feature/home/domain/entity/training_dashboard_entity.dart';

abstract interface class HomeRepo {
  Future<Result<UploadVideoEntity>> uploadVideo(
      String path,
      void Function(int sent, int total)? onProgress,
      );
  Future<Result<AnalysisEntity>> analysisAiVideo(
    AnalysisAiRequest analysisRequest,
      void Function(int sent, int total)? onProgress,
  );
  Future<Result<List<CommunityFeedEntity>>> getCommunityFeed();
  //Future<Result<WeeklyPlanEntity>> getWeeklyPlan();
  Future<Result<TrainingDashboardEntity>> getTrainingDashboard();
  Future<Result<List<FullWeeklyPlanEntity>>> getFullWeeklyPlan();
}
