import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:injectable/injectable.dart';
import 'package:junior_football/core/base_bloc/base_cubit.dart';
import 'package:junior_football/core/error_handling/result.dart';
import 'package:junior_football/core/services/camera_service.dart';
import 'package:junior_football/feature/home/domain/entity/upload_video_entity.dart';
import 'package:junior_football/feature/home/domain/repo/home_repo.dart';
import 'package:junior_football/feature/home/presentation/view_model/video_record_state.dart';
import 'package:video_player/video_player.dart';

@injectable
class VideoRecordViewModel
    extends BaseCubit<VideoRecordState, VideoRecordIntent, VideoRecordEvent> {
  final CameraService _cameraService;
  final HomeRepo _homeRepo;
  Timer? _recordTimer;

  VideoRecordViewModel(this._cameraService, this._homeRepo)
      : super(const VideoRecordState());

  @override
  void doIntent(VideoRecordIntent intent) {
    switch (intent) {
      case InitCameraIntent():
        _initCamera();
      case ToggleRecordingIntent():
        _onRecordButtonPressed();
      case DeleteVideoIntent():
        _deleteRecordedVideo();
    }
  }

  Future<void> _initCamera() async {
    try {
      final cameras = await _cameraService.getCameras();
      if (cameras.isEmpty) {
        emit(state.copyWith(errorMessage: 'No cameras found'));
        return;
      }

      final controller = CameraController(
        cameras.first,
        ResolutionPreset.medium,
        enableAudio: true,
      );

      await controller.initialize();
      emit(state.copyWith(cameraController: controller, clearErrorMessage: true));
    } catch (e) {
      emit(state.copyWith(errorMessage: 'Camera error: $e'));
    }
  }

  Future<void> _onRecordButtonPressed() async {
    if (state.isBusy || state.isUploading) return;
    emit(state.copyWith(isBusy: true));

    try {
      if (state.isRecording) {
        await _stopRecording();
      } else {
        await _startRecording();
      }
    } finally {
      emit(state.copyWith(isBusy: false));
    }
  }

  Future<void> _startRecording() async {
    if (!state.isCameraReady) {
      emitEvent(ShowSnackBarEvent('Camera not ready'));
      return;
    }
    if (state.cameraController!.value.isRecordingVideo) return;

    await _disposeVideoPlayer();

    try {
      await state.cameraController!.startVideoRecording();

      _recordTimer?.cancel();
      _recordTimer = Timer.periodic(const Duration(seconds: 1), (_) {
        emit(state.copyWith(recordSeconds: state.recordSeconds + 1));
      });

      emit(state.copyWith(isRecording: true, recordSeconds: 0));
    } catch (e) {
      emitEvent(ShowSnackBarEvent('Could not start recording: $e'));
    }
  }

  Future<void> _stopRecording() async {
    if (!state.isCameraReady || !state.cameraController!.value.isRecordingVideo) {
      return;
    }

    _recordTimer?.cancel();
    _recordTimer = null;

    try {
      final XFile videoFile = await state.cameraController!.stopVideoRecording();
      emit(state.copyWith(isRecording: false));

      // Save to gallery
      await _saveToGallery(videoFile.path);

      // Upload Video
      await _uploadVideo(videoFile.path);
      
      await _initializeVideoPlayer(File(videoFile.path));
    } catch (e) {
      emitEvent(ShowSnackBarEvent('Could not stop recording: $e'));
      emit(state.copyWith(isRecording: false));
    }
  }

  Future<void> _uploadVideo(String path) async {
    emit(state.copyWith(isUploading: true, uploadProgress: 0.0));

    final result = await _homeRepo.uploadVideo(
      path,
      (sent, total) {
        final progress = sent / total;
        emit(state.copyWith(uploadProgress: progress));
      },
    );

    switch (result) {
      case Success<UploadVideoEntity>():
        emit(state.copyWith(
          isUploading: false,
          uploadedVideoId: result.data.videoUrl,
        ));
        emitEvent(NavigateToAnalysisEvent(result.data.videoUrl));
      case Failure<UploadVideoEntity>():
        emit(state.copyWith(isUploading: false));
        emitEvent(ShowSnackBarEvent('Upload failed: ${result.errorMessage}'));
    }
  }

  Future<void> _saveToGallery(String path) async {
    emit(state.copyWith(isSaving: true));
    final success = await _cameraService.saveVideoToGallery(path);
    if (success) {
      emitEvent(ShowSnackBarEvent('Video saved to gallery ✓'));
    } else {
      emitEvent(ShowSnackBarEvent('Could not save to gallery'));
    }
    emit(state.copyWith(isSaving: false));
  }

  Future<void> _initializeVideoPlayer(File file) async {
    try {
      final controller = VideoPlayerController.file(file);
      await controller.initialize();
      await controller.setLooping(true);
      await controller.play();

      emit(state.copyWith(videoPlayerController: controller));
    } catch (e) {
      emitEvent(ShowSnackBarEvent('VideoPlayer error: $e'));
    }
  }

  Future<void> _disposeVideoPlayer() async {
    await state.videoPlayerController?.dispose();
    emit(state.copyWith(clearVideoPlayer: true));
  }

  Future<void> _deleteRecordedVideo() async {
    await _disposeVideoPlayer();
  }

  @override
  Future<void> close() async {
    _recordTimer?.cancel();
    await state.cameraController?.dispose();
    await state.videoPlayerController?.dispose();
    return super.close();
  }
}
