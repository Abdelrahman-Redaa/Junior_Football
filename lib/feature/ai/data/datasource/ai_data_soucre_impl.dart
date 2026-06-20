import 'package:injectable/injectable.dart';
import 'package:junior_football/core/api/api_client.dart';
import 'package:junior_football/core/error_handling/execute_api.dart';
import 'package:junior_football/core/error_handling/result.dart';
import 'package:junior_football/feature/ai/data/datasource/ai_data_source.dart';
import 'package:junior_football/feature/ai/data/models/chat_ai_response.dart';
import 'package:junior_football/feature/ai/data/models/injury_prediction_response.dart';
import 'package:junior_football/feature/ai/data/models/recent_ai_report_response.dart';
import 'package:junior_football/feature/ai/data/models/twin_player_response.dart';

@LazySingleton(as: AiDataSource)
class AiDataSourceImpl implements AiDataSource {
  final ApiClient _apiClient;

  AiDataSourceImpl(this._apiClient);
  @override
  Future<Result<List<RecentAiReportResponse>>> getRecentAiReports() =>
      executeApi(() => _apiClient.getRecentAiReports());

  @override
  Future<Result<InjuryPredictionResponse>> getInjuryPrediction() =>
      executeApi(() => _apiClient.getInjuryPrediction());

  @override
  Future<Result<TwinPlayerResponse>> getSkillTwin() =>
      executeApi(() => _apiClient.getSkillTwin());

  @override
  Future<Result<ChatAiResponse>> chatAi(String message) =>
      executeApi(() => _apiClient.chatAi(message));
}
