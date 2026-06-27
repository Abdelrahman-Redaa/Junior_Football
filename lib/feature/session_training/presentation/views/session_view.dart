import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:junior_football/core/utilities/spaces.dart';
import 'package:junior_football/core/utilities/theme_extension.dart';

import '../../../ai/presentation/widget/video_player.dart';

class SessionView extends StatefulWidget {
  const SessionView({super.key, this.args});

  final TrainingVideoArgs? args;

  @override
  State<SessionView> createState() => _SessionViewState();
}

class TrainingVideoArgs {
  final String title;
  final String videoUrl;
  final String? description;
  final String? duration;
  final String? difficulty;
  final String? xp;
  final String? coachNote;
  final List<String>? instructions;

  const TrainingVideoArgs({
    required this.title,
    required this.videoUrl,
    this.description,
    this.duration,
    this.difficulty,
    this.xp,
    this.coachNote,
    this.instructions,
  });
}

class _SessionViewState extends State<SessionView> {
  final List<String> _videoUrls = [
    'https://footballfc.runasp.net/uploads/videos/21db6443-5d9c-4b6b-bf44-20e1074237fe.mp4',
    'https://footballfc.runasp.net/uploads/videos/0a96d26c-169b-4d50-be6a-796601a8cac5.mp4',
    'https://footballfc.runasp.net/uploads/videos/15003242-488c-47de-a470-a607a7a45971.mp4',
  ];
  late final String videoUrl =
      widget.args?.videoUrl ?? _videoUrls[0]; // Avoid Random() for simplicity
  late final String title = widget.args?.title ?? "home.sessionTitle".tr();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 393 / 217,
              child: VideoPlayerWidget(videoUrl: videoUrl),
            ),
            const VerticalSpace(38),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSpeedTraining(context),
                  if ((widget.args?.description ?? '').isNotEmpty) ...[
                    const VerticalSpace(12),
                    Text(
                      widget.args!.description!,
                      style: theme.regular14.copyWith(color: theme.neutral),
                    ),
                  ],
                  const VerticalSpace(16),
                  _buildMetaRow(context),
                  const VerticalSpace(32),
                  Text("home.instructions".tr(), style: theme.medium14),
                  const VerticalSpace(20),
                  _buildInstructions(context),
                  const VerticalSpace(100),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInstructions(BuildContext context) {
    final theme = context.appTheme;
    final listOfInstructions = widget.args?.instructions?.isNotEmpty == true
        ? widget.args!.instructions!
        : [
            "home.instruction1".tr(),
            "home.instruction2".tr(),
            "home.instruction3".tr(),
          ];
    return Column(
      children: List.generate(
        listOfInstructions.length,
        (index) => Padding(
          padding: const EdgeInsets.only(bottom: 32),
          child: ListTile(
            title: Text(listOfInstructions[index], style: theme.regular14),
            leading: CircleAvatar(
              backgroundColor: theme.accentSurface,
              child: Text(
                (index + 1).toString(),
                style: theme.regular14.copyWith(color: theme.primary),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSpeedTraining(BuildContext context) {
    final theme = context.appTheme;
    return Row(
      children: [
        Expanded(child: Text(title, style: theme.semiBold24)),
        const Spacer(),
        Icon(Icons.access_time_filled_outlined, color: theme.neutral),
        const HorizontalSpace(5),
        Text(
          "home.sessionDuration".tr(),
          style: theme.medium14.copyWith(color: theme.neutral),
        ),
      ],
    );
  }

  Widget _buildMetaRow(BuildContext context) {
    final theme = context.appTheme;
    final items = [
      if ((widget.args?.duration ?? '').isNotEmpty)
        _MetaItem(Icons.timer_outlined, widget.args!.duration!),
      if ((widget.args?.difficulty ?? '').isNotEmpty)
        _MetaItem(Icons.signal_cellular_alt, widget.args!.difficulty!),
      if ((widget.args?.xp ?? '').isNotEmpty)
        _MetaItem(Icons.bolt_outlined, widget.args!.xp!),
    ];
    if (items.isEmpty && (widget.args?.coachNote ?? '').isEmpty) {
      return const SizedBox.shrink();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(spacing: 8, runSpacing: 8, children: items),
        if ((widget.args?.coachNote ?? '').isNotEmpty) ...[
          const VerticalSpace(12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: theme.accentSurface,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Text(widget.args!.coachNote!, style: theme.regular14),
          ),
        ],
      ],
    );
  }
}

class _MetaItem extends StatelessWidget {
  const _MetaItem(this.icon, this.label);

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: theme.accentSurface,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: theme.primary),
          const HorizontalSpace(6),
          Text(label, style: theme.medium14),
        ],
      ),
    );
  }
}
