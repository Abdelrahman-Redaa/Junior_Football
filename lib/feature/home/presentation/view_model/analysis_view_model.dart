import 'package:injectable/injectable.dart';
import 'package:junior_football/core/base_bloc/base_cubit.dart';
import 'package:junior_football/core/base_bloc/base_state.dart';
import 'package:junior_football/core/error_handling/result.dart';
import 'package:junior_football/feature/home/data/models/request/analysis_ai_request.dart';
import 'package:junior_football/feature/home/domain/entity/analysis_ai_response_entity.dart';
import 'package:junior_football/feature/home/domain/repo/home_repo.dart';
import 'package:junior_football/feature/home/presentation/view_model/analysis_state.dart';

@injectable
class AnalysisViewModel
    extends BaseCubit<AnalysisState, AnalysisHomeIntent, AnalysisEvent> {
  AnalysisViewModel(this._homeRepo)
    : super(
        AnalysisState(analysisVideo: BaseState.init(), analysisProgress: 0),
      );
  final HomeRepo _homeRepo;
  @override
  void doIntent(AnalysisHomeIntent intent) {
    switch (intent) {
      case AnalysisVideoIntent():
        _analysisVideo(intent.videoUrl);
    }
  }

  Future<void> _analysisVideo(String videoUrl) async {
    emit(state.copyWith(analysisVideo: BaseState.loading()));
    final result = await _homeRepo.analysisAiVideo(
      AnalysisAiRequest(
        videoUrl: videoUrl,
        drillType: "Passing",
      ),
      _calculateAnalysisProgress,
    );
    switch (result) {
      case Success<AnalysisEntity>():
        emit(state.copyWith(analysisVideo: BaseState.loaded(result.data)));
        emitEvent(AnalysisVideoEvent(result.data));
      case Failure<AnalysisEntity>():
        emit(
          state.copyWith(analysisVideo: BaseState.error(result.errorMessage)),
        );
        emitEvent(SendToast(result.errorMessage));
    }
  }

  void _calculateAnalysisProgress(int sent, int total) {
    final progress = (sent / total) * 100;
    emit(state.copyWith(analysisProgress: progress));
  }
}
