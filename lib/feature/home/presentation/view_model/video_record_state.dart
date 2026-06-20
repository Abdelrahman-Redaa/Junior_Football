import 'package:camera/camera.dart';
import 'package:equatable/equatable.dart';
import 'package:video_player/video_player.dart';

class VideoRecordState extends Equatable {
  final CameraController? cameraController;
  final VideoPlayerController? videoPlayerController;
  final bool isRecording;
  final bool isBusy;
  final bool isSaving;
  final bool isUploading;
  final double uploadProgress;
  final int recordSeconds;
  final String? errorMessage;
  final String? uploadedVideoId;

  const VideoRecordState({
    this.cameraController,
    this.videoPlayerController,
    this.isRecording = false,
    this.isBusy = false,
    this.isSaving = false,
    this.isUploading = false,
    this.uploadProgress = 0.0,
    this.recordSeconds = 0,
    this.errorMessage,
    this.uploadedVideoId,
  });

  VideoRecordState copyWith({
    CameraController? cameraController,
    VideoPlayerController? videoPlayerController,
    bool? isRecording,
    bool? isBusy,
    bool? isSaving,
    bool? isUploading,
    double? uploadProgress,
    int? recordSeconds,
    String? errorMessage,
    String? uploadedVideoId,
    bool clearVideoPlayer = false,
    bool clearErrorMessage = false,
  }) {
    return VideoRecordState(
      cameraController: cameraController ?? this.cameraController,
      videoPlayerController:
          clearVideoPlayer ? null : (videoPlayerController ?? this.videoPlayerController),
      isRecording: isRecording ?? this.isRecording,
      isBusy: isBusy ?? this.isBusy,
      isSaving: isSaving ?? this.isSaving,
      isUploading: isUploading ?? this.isUploading,
      uploadProgress: uploadProgress ?? this.uploadProgress,
      recordSeconds: recordSeconds ?? this.recordSeconds,
      errorMessage: clearErrorMessage ? null : (errorMessage ?? this.errorMessage),
      uploadedVideoId: uploadedVideoId ?? this.uploadedVideoId,
    );
  }

  bool get isCameraReady =>
      cameraController != null && cameraController!.value.isInitialized;

  @override
  List<Object?> get props => [
        cameraController,
        videoPlayerController,
        isRecording,
        isBusy,
        isSaving,
        isUploading,
        uploadProgress,
        recordSeconds,
        errorMessage,
        uploadedVideoId,
      ];
}

sealed class VideoRecordIntent {}

class InitCameraIntent extends VideoRecordIntent {}

class ToggleRecordingIntent extends VideoRecordIntent {}

class DeleteVideoIntent extends VideoRecordIntent {}

sealed class VideoRecordEvent {
  final String message;
  VideoRecordEvent(this.message);
}

class ShowSnackBarEvent extends VideoRecordEvent {
  ShowSnackBarEvent(super.message);
}

class NavigateToAnalysisEvent extends VideoRecordEvent {
  final String videoUrl;
  NavigateToAnalysisEvent(this.videoUrl) : super('Navigate to analysis');
}
