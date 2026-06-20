import 'package:injectable/injectable.dart';
import 'package:junior_football/core/base_bloc/base_cubit.dart';
import 'package:junior_football/core/base_bloc/base_state.dart';
import 'package:junior_football/core/error_handling/result.dart';
import 'package:junior_football/feature/ai/domain/entity/injury_prediction_entity.dart';
import 'package:junior_football/feature/ai/domain/entity/recent_report_entity.dart';
import 'package:junior_football/feature/ai/domain/entity/twin_player_entity.dart';
import 'package:junior_football/feature/ai/domain/repo/ai_repo.dart';
import 'package:junior_football/feature/ai/presentation/view_model/ai_state.dart';

@injectable
class AiViewModel extends BaseCubit<AiState, AIIntent, AiEvent> {
  AiViewModel(this._aiRepo)
      : super(
          AiState(
            recentReport: BaseState.init(),
            injuryPrediction: BaseState.init(),
            skillTwin: BaseState.init(),
          ),
        );
  final AiRepo _aiRepo;

  @override
  void doIntent(AIIntent intent) {
    switch (intent) {
      case GetRecentReportIntent():
        _getRecentReport();
      case GetInjuryPredictionIntent():
        _getInjuryPrediction();
      case GetSkillTwinIntent():
        _getSkillTwin();
    }
  }

  Future<void> _getRecentReport() async {
    emit(state.copyWith(recentReport: BaseState.loading()));
    final result = await _aiRepo.getRecentAiReport();
    switch (result) {
      case Success<List<RecentAiReportEntity>>():
        emit(state.copyWith(recentReport: BaseState.loaded(result.data)));

      case Failure<List<RecentAiReportEntity>>():
        emit(
          state.copyWith(recentReport: BaseState.error(result.errorMessage)),
        );
    }
  }

  Future<void> _getInjuryPrediction() async {
    emit(state.copyWith(injuryPrediction: BaseState.loading()));
    final result = await _aiRepo.getInjuryPrediction();
    switch (result) {
      case Success<InjuryPredictionEntity>():
        emit(state.copyWith(injuryPrediction: BaseState.loaded(result.data)));

      case Failure<InjuryPredictionEntity>():
        emit(
          state.copyWith(
              injuryPrediction: BaseState.error(result.errorMessage)),
        );
    }
  }

  Future<void> _getSkillTwin() async {
    emit(state.copyWith(skillTwin: BaseState.loading()));
    final result = await _aiRepo.getSkillTwin();
    switch (result) {
      case Success<TwinPlayerEntity>():
        emit(state.copyWith(skillTwin: BaseState.loaded(result.data)));

      case Failure<TwinPlayerEntity>():
        emit(
          state.copyWith(skillTwin: BaseState.error(result.errorMessage)),
        );
    }
  }
}
