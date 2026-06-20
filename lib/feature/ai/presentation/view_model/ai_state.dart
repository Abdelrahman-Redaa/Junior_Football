import 'package:equatable/equatable.dart';
import 'package:junior_football/core/base_bloc/base_state.dart';
import 'package:junior_football/feature/ai/domain/entity/injury_prediction_entity.dart';
import 'package:junior_football/feature/ai/domain/entity/recent_report_entity.dart';
import 'package:junior_football/feature/ai/domain/entity/twin_player_entity.dart';

class AiState extends Equatable {
  final BaseState<List<RecentAiReportEntity>>? recentReport;
  final BaseState<InjuryPredictionEntity>? injuryPrediction;
  final BaseState<TwinPlayerEntity>? skillTwin;

  const AiState({
    this.recentReport,
    this.injuryPrediction,
    this.skillTwin,
  });

  AiState copyWith({
    BaseState<List<RecentAiReportEntity>>? recentReport,
    BaseState<InjuryPredictionEntity>? injuryPrediction,
    BaseState<TwinPlayerEntity>? skillTwin,
  }) {
    return AiState(
      recentReport: recentReport ?? this.recentReport,
      injuryPrediction: injuryPrediction ?? this.injuryPrediction,
      skillTwin: skillTwin ?? this.skillTwin,
    );
  }

  @override
  List<Object?> get props => [recentReport, injuryPrediction, skillTwin];
}

sealed class AiEvent {}

class SendToast extends AiEvent {
  final String message;

  SendToast(this.message);
}

sealed class AIIntent {}

class GetRecentReportIntent extends AIIntent {}

class GetInjuryPredictionIntent extends AIIntent {}

class GetSkillTwinIntent extends AIIntent {}
