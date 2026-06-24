import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:junior_football/core/utilities/spaces.dart';
import 'package:junior_football/core/utilities/theme_extension.dart';
import 'package:junior_football/feature/ai/presentation/view_model/ai_state.dart';
import 'package:junior_football/feature/ai/presentation/view_model/ai_view_model.dart';
import 'package:junior_football/feature/ai/presentation/widget/video_player.dart';

class SkillTwinView extends StatelessWidget {
  const SkillTwinView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return Scaffold(
      appBar: AppBar(title: Text("aiHub.skillTwin".tr())),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: BlocBuilder<AiViewModel, AiState>(
          builder: (context, state) {
            final skillTwin = state.skillTwin;
            if (state.skillTwin?.isLoading ?? false) {
              return const Center(child: CircularProgressIndicator());
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "skillTwin.yourSkillTwin".tr(),
                  style: theme.semiBold24.copyWith(fontWeight: FontWeight.w700),
                ),
                VerticalSpace(4),
                Text(
                  "skillTwin.comparePerformance".tr(),
                  style: theme.regular16,
                  maxLines: 2,
                ),
                VerticalSpace(16),
                _PlayerCard(
                  playerImage: skillTwin?.data?.twinProfileImageUrl ?? '',
                  playerName: '${skillTwin?.data?.twinPlayerName}',
                  playerDesc: '${skillTwin?.data?.matchDescription}',
                  playerMatch: skillTwin?.data?.matchPercentage ?? 0,
                ),
                VerticalSpace(33),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: theme.accentSurface,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${"skillTwin.learnFrom".tr()}${skillTwin?.data?.twinPlayerName}",
                          style: theme.semiBold24,
                        ),
                        VerticalSpace(24),
                        Expanded(
                          child: ListView.builder(
                            itemCount: skillTwin?.data?.mediaGallery?.length ??0,
                            itemBuilder: (context, index) => Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: VideoPlayerWidget(
                                videoUrl:
                                    skillTwin
                                        ?.data
                                        ?.mediaGallery?[index]
                                        .getVideoUrl ??
                                    "",
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

final class _PlayerCard extends StatelessWidget {
  const _PlayerCard({
    required this.playerImage,
    required this.playerName,
    required this.playerDesc,
    required this.playerMatch,
  });

  final String playerImage;
  final String playerName;
  final String playerDesc;
  final int playerMatch;

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: theme.primary,
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        title: Text(
          "$playerMatch%${"skillTwin.match".tr()}",
          style: theme.regular16.copyWith(color: theme.secondary),
        ),
        subtitle: Text(
          playerName,
          style: theme.semiBold16.copyWith(color: theme.secondary),
        ),
        leading: CachedNetworkImage(
          width: 50,
          height: 50,

          fit: BoxFit.fitWidth,
          imageUrl: playerImage,
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      ),
    );
  }
}
