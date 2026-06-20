import 'package:injectable/injectable.dart';
import 'package:junior_football/core/error_handling/result.dart';
import 'package:junior_football/feature/ai/data/datasource/ai_data_source.dart';
import 'package:junior_football/feature/ai/data/models/chat_ai_response.dart';
import 'package:junior_football/feature/ai/data/models/injury_prediction_response.dart';
import 'package:junior_football/feature/ai/data/models/recent_ai_report_response.dart';
import 'package:junior_football/feature/ai/data/models/twin_player_response.dart';
import 'package:junior_football/feature/ai/domain/entity/chat_message_entity.dart';
import 'package:junior_football/feature/ai/domain/entity/injury_prediction_entity.dart';
import 'package:junior_football/feature/ai/domain/entity/recent_report_entity.dart';
import 'package:junior_football/feature/ai/domain/entity/twin_player_entity.dart';
import 'package:junior_football/feature/ai/domain/repo/ai_repo.dart';
import 'package:junior_football/feature/ai/mapper/ai_mapper.dart';

@LazySingleton(as: AiRepo)
class AiRepoImpl implements AiRepo {
  final AiDataSource _aiDataSource;

  AiRepoImpl(this._aiDataSource);

  @override
  Future<Result<List<RecentAiReportEntity>>> getRecentAiReport() async {
    final result = await _aiDataSource.getRecentAiReports();
    switch (result) {
      case Success<List<RecentAiReportResponse>>():
        return Success(result.data.map((e) => e.toEntity()).toList());
      case Failure<List<RecentAiReportResponse>>():
        return Failure(result.errorMessage);
    }
  }

  @override
  Future<Result<InjuryPredictionEntity>> getInjuryPrediction() async {
    final result = await _aiDataSource.getInjuryPrediction();
    switch (result) {
      case Success<InjuryPredictionResponse>():
        return Success(result.data.toEntity());
      case Failure<InjuryPredictionResponse>():
        return Failure(result.errorMessage);
    }
  }

  @override
  Future<Result<TwinPlayerEntity>> getSkillTwin() async {
    final result = await _aiDataSource.getSkillTwin();
    switch (result) {
      case Success<TwinPlayerResponse>():
        return Success(result.data.toEntity());
      case Failure<TwinPlayerResponse>():
        return Failure(result.errorMessage);
    }
  }

  @override
  Future<Result<ChatMessageEntity>> chatAi(String message) async {
    final result = await _aiDataSource.chatAi(message);
    switch (result) {
      case Success<ChatAiResponse>():
        return Success(result.data.toEntity());
      case Failure<ChatAiResponse>():
        return Failure(result.errorMessage);
    }
  }
}
