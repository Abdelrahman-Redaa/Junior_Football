import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:junior_football/core/utilities/spaces.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';

class VideoPlayerWidget extends StatefulWidget {
  const VideoPlayerWidget({super.key, required this.videoUrl});
  final String videoUrl;

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayerWidget> {
  late final Player player = Player();
  late final VideoController _controller = VideoController(player);

  @override
  void initState() {
    super.initState();
    player.open(
      Media(widget.videoUrl),
      play: false,
    );
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 151.h,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: const Color(0xffADD6B6),
          ),
          clipBehavior: Clip.antiAlias,
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox.expand(
                child: Video(controller: _controller),
              ),

              StreamBuilder<bool>(
                stream: player.stream.playing,
                builder: (context, snapshot) {
                  final isPlaying = snapshot.data ?? false;

                  return Center(
                    child: GestureDetector(
                      onTap: () {
                        player.playOrPause();
                      },
                      child: CircleAvatar(
                        radius: 28,
                        backgroundColor: Colors.black45,
                        child: Icon(
                          isPlaying ? Icons.pause : Icons.play_arrow,
                          color: Colors.white,
                          size: 32.sp,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        const VerticalSpace(12),
      ],
    );
  }
}