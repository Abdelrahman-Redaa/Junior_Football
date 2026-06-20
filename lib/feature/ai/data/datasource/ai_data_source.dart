import 'package:junior_football/core/error_handling/result.dart';
import 'package:junior_football/feature/ai/data/models/chat_ai_response.dart';
import 'package:junior_football/feature/ai/data/models/injury_prediction_response.dart';
import 'package:junior_football/feature/ai/data/models/recent_ai_report_response.dart';
import 'package:junior_football/feature/ai/data/models/twin_player_response.dart';

abstract interface class AiDataSource {
  Future<Result<List<RecentAiReportResponse>>> getRecentAiReports();
  Future<Result<InjuryPredictionResponse>> getInjuryPrediction();
  Future<Result<TwinPlayerResponse>> getSkillTwin();
  Future<Result<ChatAiResponse>> chatAi(String message);
}
