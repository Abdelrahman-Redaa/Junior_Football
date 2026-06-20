import 'package:injectable/injectable.dart';
import 'package:junior_football/core/base_bloc/base_cubit.dart';
import 'package:junior_football/core/base_bloc/base_state.dart';
import 'package:junior_football/core/error_handling/result.dart';
import 'package:junior_football/core/services/video_picker_service.dart';
import 'package:junior_football/feature/home/domain/entity/upload_video_entity.dart';
import 'package:junior_football/feature/home/domain/entity/training_dashboard_entity.dart';
import 'package:junior_football/feature/home/domain/entity/full_weekly_plan_entity.dart';
import 'package:junior_football/feature/home/domain/repo/home_repo.dart';
import 'package:junior_football/feature/home/presentation/view_model/home_state.dart';

@injectable
class HomeViewModel extends BaseCubit<HomeState, HomeIntent, HomeEvent> {
  HomeViewModel(this._homeRepo, this.videoPickerService)
    : super(HomeState(
        uploadVideo: BaseState.init(),
        weeklyPlan: BaseState.init(),
        trainingDashboard: BaseState.init(),
        fullWeeklyPlan: BaseState.init(),
        progress: 0,
      ));
  final HomeRepo _homeRepo;
  final VideoPickerService videoPickerService;

  @override
  void doIntent(HomeIntent intent) {
    switch (intent) {
      case UploadVideoIntent():
        _uploadVideo();
       case GetWeeklyPlanIntent():
      //   _getWeeklyPlan();
      case GetTrainingDashboardIntent():
        _getTrainingDashboard();
      case GetFullWeeklyPlanIntent():
        _getFullWeeklyPlan();
    }
  }

  Future<void> _uploadVideo() async {
    emit(state.copyWith(uploadVideo: BaseState.loading()));
    videoPickerService.pickVideo().then((file) async {
      final filePath = file?.path;
      if (filePath == null) {
        emit(state.copyWith(uploadVideo: BaseState.error("No video selected")));
        return;
      }
      final result = await _homeRepo.uploadVideo(filePath, _calculateProgress);
      switch (result) {
        case Success<UploadVideoEntity>():
          emit(state.copyWith(uploadVideo: BaseState.loaded(result.data)));
          emitEvent(UploadVideoEvent(
            result.data.videoUrl,
          ));
        case Failure<UploadVideoEntity>():
          emit(
            state.copyWith(uploadVideo: BaseState.error(result.errorMessage)),
          );
          emitEvent(SendToast(result.errorMessage));
      }
    });
  }

  // Future<void> _getWeeklyPlan() async {
  //   emit(state.copyWith(weeklyPlan: BaseState.loading()));
  //   final result = await _homeRepo.getWeeklyPlan();
  //   switch (result) {
  //     case Success<WeeklyPlanEntity>():
  //       emit(state.copyWith(weeklyPlan: BaseState.loaded(result.data)));
  //     case Failure<WeeklyPlanEntity>():
  //       emit(state.copyWith(weeklyPlan: BaseState.error(result.errorMessage)));
  //   }
  // }

  Future<void> _getTrainingDashboard() async {
    emit(state.copyWith(trainingDashboard: BaseState.loading()));
    final result = await _homeRepo.getTrainingDashboard();
    switch (result) {
      case Success<TrainingDashboardEntity>():
        emit(state.copyWith(trainingDashboard: BaseState.loaded(result.data)));
      case Failure<TrainingDashboardEntity>():
        emit(state.copyWith(trainingDashboard: BaseState.error(result.errorMessage)));
    }
  }

  Future<void> _getFullWeeklyPlan() async {
    emit(state.copyWith(fullWeeklyPlan: BaseState.loading()));
    final result = await _homeRepo.getFullWeeklyPlan();
    switch (result) {
      case Success<List<FullWeeklyPlanEntity>>():
        emit(state.copyWith(fullWeeklyPlan: BaseState.loaded(result.data)));
      case Failure<List<FullWeeklyPlanEntity>>():
        emit(state.copyWith(fullWeeklyPlan: BaseState.error(result.errorMessage)));
    }
  }

  void _calculateProgress(int sent, int total) {
    final progress = (sent / total) * 100;
    emit(state.copyWith(progress: progress));
  }
}
