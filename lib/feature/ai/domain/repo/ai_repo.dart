import 'package:junior_football/core/error_handling/result.dart';
import 'package:junior_football/feature/ai/domain/entity/chat_message_entity.dart';
import 'package:junior_football/feature/ai/domain/entity/injury_prediction_entity.dart';
import 'package:junior_football/feature/ai/domain/entity/recent_report_entity.dart';
import 'package:junior_football/feature/ai/domain/entity/twin_player_entity.dart';

abstract interface class AiRepo {
  Future<Result<List<RecentAiReportEntity>>> getRecentAiReport();
  Future<Result<InjuryPredictionEntity>> getInjuryPrediction();
  Future<Result<TwinPlayerEntity>> getSkillTwin();
  Future<Result<ChatMessageEntity>> chatAi(String message);
}
