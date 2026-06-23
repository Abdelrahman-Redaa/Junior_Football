import 'dart:async';
import 'package:easy_localization/easy_localization.dart';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:junior_football/core/di/di.dart';
import 'package:junior_football/core/routes/routes_name.dart';
import 'package:junior_football/feature/home/presentation/view_model/video_record_state.dart';
import 'package:junior_football/feature/home/presentation/view_model/video_record_view_model.dart';

class VideoRecorderScreen extends StatefulWidget {
  const VideoRecorderScreen({super.key});

  @override
  State<VideoRecorderScreen> createState() => _VideoRecorderScreenState();
}

class _VideoRecorderScreenState extends State<VideoRecorderScreen> {
  late final VideoRecordViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = getIt<VideoRecordViewModel>();
    _viewModel.doIntent(InitCameraIntent());
  }

  @override
  void dispose() {
    _viewModel.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _viewModel,
      child: MultiBlocListener(
        listeners: [
          BlocListener<VideoRecordViewModel, VideoRecordState>(
            listenWhen: (prev, curr) => prev.errorMessage != curr.errorMessage,
            listener: (context, state) {
              if (state.errorMessage != null) {
                _showSnack(context, state.errorMessage!);
              }
            },
          ),
          BlocListener<VideoRecordViewModel, VideoRecordState>(
            listener: (context, state) {
              // We use the event stream from BaseCubit for navigation
            },
          ),
        ],
        child: StreamListener<VideoRecordEvent>(
          stream: _viewModel.eventStream,
          onEvent: (event) {
            if (event is ShowSnackBarEvent) {
              _showSnack(context, event.message);
            } else if (event is NavigateToAnalysisEvent) {
              Navigator.pushReplacementNamed(
                context,
                AppRoutes.analyzeWithVideoView,
                arguments: event.videoUrl,
              );
            }
          },
          child: BlocBuilder<VideoRecordViewModel, VideoRecordState>(
            builder: (context, state) {
              if (!state.isCameraReady) {
                return const Scaffold(
                  backgroundColor: Colors.black,
                  body: Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  ),
                );
              }

              return Scaffold(
                backgroundColor: Colors.black,
                body: Stack(
                  children: [
                    // Full-screen camera preview
                    Positioned.fill(
                      child: CameraPreview(state.cameraController!),
                    ),

                    const Center(child: _CameraFrame()),

                    if (state.isRecording)
                      Positioned(
                        top: 60,
                        left: 20,
                        child: _TimerIndicator(
                          timerText: _formatDuration(state.recordSeconds),
                        ),
                      ),

                    // Saving or Uploading indicator
                    Positioned(
                      top: 60,
                      right: 20,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          if (state.isSaving) const _SavingIndicator(),
                          if (state.isUploading) ...[
                            const SizedBox(height: 8),
                            _UploadProgressIndicator(
                              progress: state.uploadProgress,
                            ),
                          ],
                        ],
                      ),
                    ),

                    // Record / Stop button
                    Positioned(
                      bottom: 40,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: _RecordButton(
                          isRecording: state.isRecording,
                          isBusy: state.isBusy || state.isUploading,
                          onPressed: () =>
                              _viewModel.doIntent(ToggleRecordingIntent()),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void _showSnack(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  String _formatDuration(int seconds) {
    final m = (seconds ~/ 60).toString().padLeft(2, '0');
    final s = (seconds % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }
}

/// Helper widget to listen to events from BaseCubit
class StreamListener<T> extends StatefulWidget {
  final Stream<T> stream;
  final void Function(T event) onEvent;
  final Widget child;

  const StreamListener({
    super.key,
    required this.stream,
    required this.onEvent,
    required this.child,
  });

  @override
  State<StreamListener<T>> createState() => _StreamListenerState<T>();
}

class _StreamListenerState<T> extends State<StreamListener<T>> {
  StreamSubscription<T>? _subscription;

  @override
  void initState() {
    super.initState();
    _subscription = widget.stream.listen(widget.onEvent);
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}

// ═══════════════════════════ UI COMPONENTS ═══════════════════════════

class _UploadProgressIndicator extends StatelessWidget {
  final double progress;
  const _UploadProgressIndicator({required this.progress});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.6),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 14,
            height: 14,
            child: CircularProgressIndicator(
              value: progress,
              strokeWidth: 2,
              color: const Color(0xFF2EA043),
              backgroundColor: Colors.white24,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            '${"videoRecord.uploading".tr()}${(progress * 100).toInt()}%',
            style: const TextStyle(color: Colors.white, fontSize: 13),
          ),
        ],
      ),
    );
  }
}

class _SavingIndicator extends StatelessWidget {
  const _SavingIndicator();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.6),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 14,
            height: 14,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            'videoRecord.saving'.tr(),
            style: TextStyle(color: Colors.white, fontSize: 13),
          ),
        ],
      ),
    );
  }
}

class _CameraFrame extends StatelessWidget {
  const _CameraFrame();

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 220,
      height: 220,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(size: Size(220, 220), painter: _FramePainter()),
          Icon(Icons.add, size: 40, color: Color(0xFF2EA043)),
        ],
      ),
    );
  }
}

class _FramePainter extends CustomPainter {
  const _FramePainter();

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF2EA043)
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;
    const c = 85.0;

    canvas.drawLine(Offset.zero, const Offset(c, 0), paint);
    canvas.drawLine(Offset.zero, const Offset(0, c), paint);
    canvas.drawLine(Offset(size.width, 0), Offset(size.width - c, 0), paint);
    canvas.drawLine(Offset(size.width, 0), Offset(size.width, c), paint);
    canvas.drawLine(Offset(0, size.height), Offset(0, size.height - c), paint);
    canvas.drawLine(Offset(0, size.height), Offset(c, size.height), paint);
    canvas.drawLine(
      Offset(size.width, size.height),
      Offset(size.width - c, size.height),
      paint,
    );
    canvas.drawLine(
      Offset(size.width, size.height),
      Offset(size.width, size.height - c),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _TimerIndicator extends StatelessWidget {
  final String timerText;
  const _TimerIndicator({required this.timerText});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.55),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 10,
            width: 10,
            decoration: const BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            timerText,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class _RecordButton extends StatelessWidget {
  final bool isRecording;
  final bool isBusy;
  final VoidCallback onPressed;
  const _RecordButton({
    required this.isRecording,
    required this.onPressed,
    this.isBusy = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isBusy ? null : onPressed,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: isRecording ? 90 : 80,
        width: isRecording ? 90 : 80,
        decoration: BoxDecoration(
          color: isBusy
              ? Colors.grey
              : (isRecording ? Colors.red : Colors.white),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.35),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: isBusy && !isRecording
            ? const Center(
                child: CircularProgressIndicator(color: Colors.black))
            : Icon(
                isRecording ? Icons.stop_rounded : Icons.videocam_rounded,
                color: isRecording ? Colors.white : Colors.black,
                size: 38,
              ),
      ),
    );
  }
}
