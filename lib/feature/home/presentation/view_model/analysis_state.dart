import 'package:equatable/equatable.dart';
import 'package:junior_football/core/base_bloc/base_state.dart';
import 'package:junior_football/feature/home/domain/entity/analysis_ai_response_entity.dart';

class AnalysisState extends Equatable {
  final BaseState<AnalysisEntity>? analysisVideo;
  final double? analysisProgress;
  const AnalysisState({this.analysisVideo, this.analysisProgress});
  AnalysisState copyWith({
    BaseState<AnalysisEntity>? analysisVideo,
    double? analysisProgress,
  }) {
    return AnalysisState(
      analysisVideo: analysisVideo ?? this.analysisVideo,
      analysisProgress: analysisProgress ?? this.analysisProgress,
    );
  }

  @override
  List<Object?> get props => [analysisProgress, analysisVideo];
}

sealed class AnalysisEvent {}

class AnalysisVideoEvent extends AnalysisEvent {
  final AnalysisEntity analysisEntity;

  AnalysisVideoEvent(this.analysisEntity);
}

class SendToast extends AnalysisEvent {
  final String message;

  SendToast(this.message);
}

sealed class AnalysisHomeIntent {}

class AnalysisVideoIntent extends AnalysisHomeIntent {
  final String videoUrl;
  AnalysisVideoIntent({required this.videoUrl});
}
