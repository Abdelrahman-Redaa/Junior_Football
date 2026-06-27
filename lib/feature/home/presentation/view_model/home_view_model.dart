import 'package:injectable/injectable.dart';
import 'package:junior_football/core/base_bloc/base_cubit.dart';
import 'package:junior_football/core/base_bloc/base_state.dart';
import 'package:junior_football/core/error_handling/result.dart';
import 'package:junior_football/core/services/video_picker_service.dart';
import 'package:junior_football/feature/home/domain/entity/upload_video_entity.dart';
import 'package:junior_football/feature/home/domain/entity/training_dashboard_entity.dart';
import 'package:junior_football/feature/home/domain/entity/full_weekly_plan_entity.dart';
import 'package:junior_football/feature/home/domain/entity/training_lesson_entity.dart';
import 'package:junior_football/feature/home/domain/entity/training_weekly_plan_entity.dart';
import 'package:junior_football/feature/home/domain/repo/home_repo.dart';
import 'package:junior_football/feature/home/presentation/view_model/home_state.dart';

@injectable
class HomeViewModel extends BaseCubit<HomeState, HomeIntent, HomeEvent> {
  HomeViewModel(this._homeRepo, this.videoPickerService)
    : super(
        HomeState(
          uploadVideo: BaseState.init(),
          weeklyPlan: BaseState.init(),
          trainingDashboard: BaseState.init(),
          fullWeeklyPlan: BaseState.init(),
          trainingWeeklyPlan: BaseState.init(),
          trainingDailySession: BaseState.init(),
          trainingRecommendations: BaseState.init(),
          speedLessons: BaseState.init(),
          shootingLessons: BaseState.init(),
          passingLessons: BaseState.init(),
          progress: 0,
        ),
      );
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
      case GetTrainingWeeklyPlanIntent():
        _getTrainingWeeklyPlan();
      case GetTrainingDailySessionIntent():
        _getTrainingDailySession();
      case GetTrainingRecommendationsIntent():
        _getTrainingRecommendations();
      case GetTrainingLessonsIntent():
        _getTrainingLessons();
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
          emitEvent(UploadVideoEvent(result.data.videoUrl));
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
        emit(
          state.copyWith(
            trainingDashboard: BaseState.error(result.errorMessage),
          ),
        );
    }
  }

  Future<void> _getFullWeeklyPlan() async {
    emit(state.copyWith(fullWeeklyPlan: BaseState.loading()));
    final result = await _homeRepo.getFullWeeklyPlan();
    switch (result) {
      case Success<List<FullWeeklyPlanEntity>>():
        emit(state.copyWith(fullWeeklyPlan: BaseState.loaded(result.data)));
      case Failure<List<FullWeeklyPlanEntity>>():
        emit(
          state.copyWith(fullWeeklyPlan: BaseState.error(result.errorMessage)),
        );
    }
  }

  Future<void> _getTrainingWeeklyPlan() async {
    emit(state.copyWith(trainingWeeklyPlan: BaseState.loading()));
    final result = await _homeRepo.getTrainingWeeklyPlan();
    switch (result) {
      case Success<TrainingWeeklyPlanEntity>():
        emit(state.copyWith(trainingWeeklyPlan: BaseState.loaded(result.data)));
      case Failure<TrainingWeeklyPlanEntity>():
        emit(
          state.copyWith(
            trainingWeeklyPlan: BaseState.error(result.errorMessage),
          ),
        );
    }
  }

  Future<void> _getTrainingDailySession() async {
    emit(state.copyWith(trainingDailySession: BaseState.loading()));
    final result = await _homeRepo.getTrainingDailySession();
    switch (result) {
      case Success<TodaySessionEntity>():
        emit(
          state.copyWith(trainingDailySession: BaseState.loaded(result.data)),
        );
      case Failure<TodaySessionEntity>():
        emit(
          state.copyWith(
            trainingDailySession: BaseState.error(result.errorMessage),
          ),
        );
    }
  }

  Future<void> _getTrainingRecommendations() async {
    emit(state.copyWith(trainingRecommendations: BaseState.loading()));
    final result = await _homeRepo.getTrainingRecommendations();
    switch (result) {
      case Success<List<QuickRecommendationEntity>>():
        emit(
          state.copyWith(
            trainingRecommendations: BaseState.loaded(result.data),
          ),
        );
      case Failure<List<QuickRecommendationEntity>>():
        emit(
          state.copyWith(
            trainingRecommendations: BaseState.error(result.errorMessage),
          ),
        );
    }
  }

  Future<void> _getTrainingLessons() async {
    emit(
      state.copyWith(
        speedLessons: BaseState.loading(),
        shootingLessons: BaseState.loading(),
        passingLessons: BaseState.loading(),
      ),
    );
    final speed = await _homeRepo.getSpeedLessons();
    switch (speed) {
      case Success<LessonsListEntity>():
        emit(state.copyWith(speedLessons: BaseState.loaded(speed.data)));
      case Failure<LessonsListEntity>():
        emit(state.copyWith(speedLessons: BaseState.error(speed.errorMessage)));
    }
    final shooting = await _homeRepo.getShootingLessons();
    switch (shooting) {
      case Success<LessonsListEntity>():
        emit(state.copyWith(shootingLessons: BaseState.loaded(shooting.data)));
      case Failure<LessonsListEntity>():
        emit(
          state.copyWith(
            shootingLessons: BaseState.error(shooting.errorMessage),
          ),
        );
    }
    final passing = await _homeRepo.getPassingLessons();
    switch (passing) {
      case Success<LessonsListEntity>():
        emit(state.copyWith(passingLessons: BaseState.loaded(passing.data)));
      case Failure<LessonsListEntity>():
        emit(
          state.copyWith(passingLessons: BaseState.error(passing.errorMessage)),
        );
    }
  }

  void _calculateProgress(int sent, int total) {
    final progress = (sent / total) * 100;
    emit(state.copyWith(progress: progress));
  }
}
