import 'dart:io';

import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:junior_football/core/utilities/show_toast_message.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:junior_football/core/constants/app_assets.dart';
import 'package:junior_football/core/di/di.dart';
import 'package:junior_football/core/routes/routes_name.dart';
import 'package:junior_football/core/utilities/app_local_storage.dart';
import 'package:junior_football/core/utilities/custom_menu.dart';
import 'package:junior_football/core/utilities/theme_extension.dart';
import 'package:junior_football/feature/ai/presentation/widget/video_player.dart';
import 'package:junior_football/feature/profile/domain/entities/user_profile_entity.dart';
import 'package:junior_football/feature/profile/presentation/view_model/profile_state.dart';
import 'package:junior_football/feature/profile/presentation/view_model/profile_view_model.dart';
import 'package:junior_football/feature/profile/presentation/views/edit_profile.dart';
import 'package:junior_football/feature/profile/presentation/widgets/setting_sections.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt.get<ProfileViewModel>()..doIntent(GetProfileIntent()),
      child: const _ProfileBody(),
    );
  }
}

class _ProfileBody extends StatelessWidget {
  const _ProfileBody();

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text('profile.title'.tr()),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () {
              final vm = context.read<ProfileViewModel>();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (innerContext) => BlocProvider.value(
                    value: vm,
                    child: Scaffold(
                      appBar: AppBar(title: Text('settings.title'.tr())),
                      body: SafeArea(
                        child: SingleChildScrollView(
                          padding: EdgeInsets.all(16.w),
                          child: SettingSections(
                            onLogout: () => _confirmLogout(innerContext),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: BlocConsumer<ProfileViewModel, ProfileState>(
          listenWhen: (previous, current) =>
              previous.followAction != current.followAction ||
              previous.uploadVideo != current.uploadVideo ||
              previous.updateProfileState != current.updateProfileState,
          listener: (context, state) {
            if (state.followAction.isError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    state.followAction.errorMessage ?? 'Action failed',
                  ),
                ),
              );
            }
            if (state.uploadVideo.isError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    state.uploadVideo.errorMessage ?? 'Video upload failed',
                  ),
                ),
              );
            }
            if (state.uploadVideo.isLoaded) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('profile.videoUploaded'.tr())),
              );
            }
            if (state.updateProfileState.isLoaded) {
              ShowToastMessage.show(
                context: context,
                message: "Profile Updated Successfully",
                isError: false,
              );
            }
            if (state.updateProfileState.isError) {
              ShowToastMessage.show(
                context: context,
                message:
                    state.updateProfileState.errorMessage ??
                    "Failed to update profile",
                isError: true,
              );
            }
          },
          builder: (context, state) {
            if (state.profile.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.profile.isError) {
              return _ErrorState(message: state.profile.errorMessage);
            }

            final profile = state.profile.data;
            if (profile == null) return const SizedBox.shrink();

            return RefreshIndicator(
              onRefresh: () async {
                context.read<ProfileViewModel>().doIntent(GetProfileIntent());
              },
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 32.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _ProfileHeader(
                      profile: profile,
                      isFollowLoading: state.followAction.isLoading,
                    ),
                    SizedBox(height: 16.h),
                    _StatsRow(profile: profile),
                    SizedBox(height: 16.h),
                    _DetailsSection(profile: profile),
                    SizedBox(height: 16.h),
                    _VideoGallerySection(
                      profile: profile,
                      isUploading: state.uploadVideo.isLoading,
                      progress: state.uploadVideoProgress,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> _confirmLogout(BuildContext context) async {
    final shouldLogout = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text('logout.title'.tr()),
        content: Text('logout.content'.tr()),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: Text('logout.cancel'.tr()),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: Text('logout.confirm'.tr()),
          ),
        ],
      ),
    );

    if (shouldLogout != true || !context.mounted) return;
    await AppLocalStorage.clearAllSecuredData();
    await AppLocalStorage.clearAllData();
    if (!context.mounted) return;
    Navigator.of(
      context,
    ).pushNamedAndRemoveUntil(AppRoutes.loginView, (route) => false);
  }
}

class _VideoGallerySection extends StatelessWidget {
  const _VideoGallerySection({
    required this.profile,
    required this.isUploading,
    required this.progress,
  });

  final UserProfileEntity profile;
  final bool isUploading;
  final double progress;

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    final videos = {
      ...(profile.videosUrl ?? []),
      ..._videoUrlsFromPosts(profile.posts),
    }.toList();

    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: theme.secondary,
        border: Border.all(color: theme.borderColor),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'profile.videoGallery'.tr(),
                  style: theme.semiBold24,
                ),
              ),
              TextButton.icon(
                onPressed: isUploading
                    ? null
                    : () => _pickAndUploadVideo(context),
                icon: const Icon(Icons.upload_file_outlined),
                label: Text('profile.upload'.tr()),
              ),
            ],
          ),
          if (isUploading) ...[
            SizedBox(height: 8.h),
            Text('${progress.floor()}%', style: theme.semiBold16),
            SizedBox(height: 8.h),
            LinearProgressIndicator(
              value: progress <= 0 ? null : progress / 100,
              color: theme.primary,
              backgroundColor: theme.borderColor,
            ),
          ],
          if (!isUploading && videos.isEmpty) ...[
            SizedBox(height: 10.h),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 12.w),
              decoration: BoxDecoration(
                color: theme.primary.withValues(alpha: 0.06),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.video_library_outlined,
                    color: theme.primary,
                    size: 32.r,
                  ),
                  SizedBox(height: 8.h),
                  Text('profile.noVideos'.tr(), style: theme.semiBold16),
                  SizedBox(height: 4.h),
                  Text(
                    'Upload a video to show it on your profile',
                    textAlign: TextAlign.center,
                    style: theme.medium14.copyWith(color: theme.subTitle),
                  ),
                ],
              ),
            ),
          ],
          if (videos.isNotEmpty) ...[
            SizedBox(height: 10.h),
            SizedBox(
              height: 132.h,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: videos.length,
                separatorBuilder: (context, index) => SizedBox(width: 10.w),
                itemBuilder: (context, index) =>
                    _VideoTile(videoUrl: videos[index], index: index),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Future<void> _pickAndUploadVideo(BuildContext context) async {
    final picker = ImagePicker();
    final video = await picker.pickVideo(source: ImageSource.gallery);
    if (video == null || !context.mounted) return;
    context.read<ProfileViewModel>().doIntent(
      UploadProfileVideoIntent(file: File(video.path)),
    );
  }
}

class _VideoTile extends StatelessWidget {
  const _VideoTile({required this.videoUrl, required this.index});

  final String videoUrl;
  final int index;

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;

    return InkWell(
      borderRadius: BorderRadius.circular(10.r),
      onTap: () => _showVideo(context, videoUrl),
      child: Container(
        width: 136.w,
        decoration: BoxDecoration(
          color: theme.accentSurface,
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(color: theme.primary.withValues(alpha: 0.35)),
        ),
        child: Stack(
          children: [
            Center(
              child: Icon(
                Icons.play_circle_fill_rounded,
                color: theme.primary,
                size: 48.r,
              ),
            ),
            Positioned(
              left: 8.w,
              top: 8.h,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.55),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  'Video ${index + 1}',
                  style: theme.medium14.copyWith(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showVideo(BuildContext context, String videoUrl) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        insetPadding: EdgeInsets.all(16.w),
        child: Padding(
          padding: EdgeInsets.all(12.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              VideoPlayerWidget(videoUrl: videoUrl),
              SizedBox(height: 12.h),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('profile.close'.tr()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader({required this.profile, required this.isFollowLoading});

  final UserProfileEntity profile;
  final bool isFollowLoading;

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    final name = _fallback(profile.fullName, profile.userName, 'Player');
    final userId = profile.userId ?? '-';
    final isFollowing = profile.isFollowing ?? false;

    return Container(
      decoration: BoxDecoration(
        color: theme.secondary,
        border: Border.all(color: theme.borderColor),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.all(14.w),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 42.r,
                  backgroundColor: theme.primary.withValues(alpha: 0.12),
                  backgroundImage: _networkImage(profile.profileImageUrl),
                  child: profile.profileImageUrl == null
                      ? Icon(Icons.person, size: 42.r, color: theme.primary)
                      : null,
                ),
                SizedBox(height: 10.h),
                Text(
                  name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.semiBold24,
                ),
                SizedBox(height: 4.h),
                Text(
                  profile.email ?? profile.userName ?? '',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.regular14.copyWith(color: theme.subTitle),
                ),
                SizedBox(height: 8.h),
                _IdBadge(userId: userId),
                if ((profile.bio ?? '').isNotEmpty) ...[
                  SizedBox(height: 10.h),
                  Text(
                    profile.bio!,
                    textAlign: TextAlign.center,
                    style: theme.regular14.copyWith(color: theme.subTitle),
                  ),
                ],
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () async {
                          final vm = context.read<ProfileViewModel>();
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => BlocProvider.value(
                                value: vm,
                                child: EditProfileView(initialProfile: profile),
                              ),
                              settings: const RouteSettings(
                                name: AppRoutes.editProfileView,
                              ),
                            ),
                          );
                        },
                        icon: const Icon(Icons.edit_outlined),
                        label: Text('profile.editProfile'.tr()),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StatsRow extends StatelessWidget {
  const _StatsRow({required this.profile});

  final UserProfileEntity profile;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _StatTile(
          value: '${profile.followersCount ?? 0}',
          label: 'Followers',
          icon: Icons.group_outlined,
        ),
        SizedBox(width: 8.w),
        _StatTile(
          value: '${profile.followingCount ?? 0}',
          label: 'Following',
          icon: Icons.person_add_alt_outlined,
        ),
        SizedBox(width: 8.w),
        _StatTile(
          value: '${profile.xp ?? 0}',
          label: 'XP',
          icon: Icons.bolt_outlined,
        ),
      ],
    );
  }
}

class _StatTile extends StatelessWidget {
  const _StatTile({
    required this.value,
    required this.label,
    required this.icon,
  });

  final String value;
  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;

    return Expanded(
      child: Container(
        height: 94.h,
        padding: EdgeInsets.all(10.w),
        decoration: BoxDecoration(
          color: theme.primary,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: theme.secondary, size: 22.r),
            SizedBox(height: 8.h),
            Text(
              value,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: theme.semiBold16.copyWith(color: theme.secondary),
            ),
            Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: theme.medium14.copyWith(color: theme.secondary),
            ),
          ],
        ),
      ),
    );
  }
}

class _DetailsSection extends StatelessWidget {
  const _DetailsSection({required this.profile});

  final UserProfileEntity profile;

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;

    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: theme.secondary,
        border: Border.all(color: theme.borderColor),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('profile.playerInfo'.tr(), style: theme.semiBold24),
          SizedBox(height: 8.h),
          _InfoRow(
            icon: Icons.badge_outlined,
            title: 'User ID',
            value: profile.userId ?? '-',
          ),
          _InfoRow(
            icon: Icons.phone_outlined,
            title: 'Phone Number',
            value: profile.phoneNumber ?? '-',
          ),
          _InfoRow(
            icon: Icons.cake_outlined,
            title: 'Age',
            value: _ageText(profile.dateOfBirth),
          ),
          _InfoRow(
            icon: Icons.flag_outlined,
            title: 'Country',
            value: profile.country ?? '-',
          ),
          _InfoRow(
            icon: Icons.sports_soccer_outlined,
            title: 'Position',
            value: profile.playingPosition ?? '-',
          ),
          _InfoRow(
            icon: Icons.straighten_outlined,
            title: 'Height / Weight',
            value:
                '${_numberText(profile.height, suffix: ' cm')} / ${_numberText(profile.weight, suffix: ' kg')}',
          ),
          _InfoRow(
            icon: Icons.directions_run_outlined,
            title: 'Preferred Foot',
            value: profile.preferredFoot ?? '-',
          ),
          _InfoRow(
            icon: Icons.shield_outlined,
            title: 'Team',
            value: profile.team ?? '-',
          ),
          _InfoRow(
            icon: Icons.emoji_events_outlined,
            title: 'Global Rank',
            value: profile.globalRank == null ? '-' : '#${profile.globalRank}',
          ),
          _InfoRow(
            icon: Icons.article_outlined,
            title: 'Posts',
            value: '${profile.posts?.length ?? 0}',
            showDivider: false,
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.icon,
    required this.title,
    required this.value,
    this.showDivider = true,
  });

  final IconData icon;
  final String title;
  final String value;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10.h),
          child: Row(
            children: [
              Icon(icon, color: theme.primary, size: 20.r),
              SizedBox(width: 10.w),
              Expanded(child: Text(title, style: theme.semiBold16)),
              SizedBox(width: 10.w),
              Flexible(
                child: Text(
                  value,
                  maxLines: 2,
                  textAlign: TextAlign.end,
                  overflow: TextOverflow.ellipsis,
                  style: theme.regular14.copyWith(color: theme.subTitle),
                ),
              ),
            ],
          ),
        ),
        if (showDivider) Divider(height: 1, color: theme.borderColor),
      ],
    );
  }
}

class _IdBadge extends StatelessWidget {
  const _IdBadge({required this.userId});

  final String userId;

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;

    return InkWell(
      borderRadius: BorderRadius.circular(999),
      onTap: () {
        Clipboard.setData(ClipboardData(text: userId));
        ShowToastMessage.show(
          context: context,
          message: "ID copied to clipboard",
          isError: false,
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
        decoration: BoxDecoration(
          color: theme.primary.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(999),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'ID: $userId',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: theme.medium14.copyWith(color: theme.primary),
            ),
            SizedBox(width: 4.w),
            Icon(Icons.copy, size: 14.r, color: theme.primary),
          ],
        ),
      ),
    );
  }
}

class _ErrorState extends StatelessWidget {
  const _ErrorState({this.message});

  final String? message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              message ?? 'Failed to load profile',
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 12.h),
            ElevatedButton(
              onPressed: () =>
                  context.read<ProfileViewModel>().doIntent(GetProfileIntent()),
              child: Text('profile.retry'.tr()),
            ),
          ],
        ),
      ),
    );
  }
}

ImageProvider? _networkImage(String? url) {
  if (url == null || url.isEmpty) return null;
  return NetworkImage(url);
}

String _fallback(String? first, String? second, String fallback) {
  if (first != null && first.trim().isNotEmpty) return first;
  if (second != null && second.trim().isNotEmpty) return second;
  return fallback;
}

String _ageText(DateTime? dateOfBirth) {
  if (dateOfBirth == null) return '-';
  final now = DateTime.now();
  var age = now.year - dateOfBirth.year;
  final hadBirthday =
      now.month > dateOfBirth.month ||
      (now.month == dateOfBirth.month && now.day >= dateOfBirth.day);
  if (!hadBirthday) age--;
  return age < 0 ? '-' : '$age years';
}

String _numberText(num? value, {required String suffix}) {
  if (value == null) return '-';
  final number = value % 1 == 0 ? value.toInt().toString() : value.toString();
  return '$number$suffix';
}

List<String> _videoUrlsFromPosts(List<dynamic>? posts) {
  if (posts == null) return const [];

  return posts
      .map(_videoUrlFromPost)
      .whereType<String>()
      .where((url) => url.trim().isNotEmpty)
      .toList();
}

String? _videoUrlFromPost(dynamic post) {
  if (post is String && _looksLikeVideoUrl(post)) return post;
  if (post is! Map) return null;

  for (final key in const [
    'videoUrl',
    'videoURL',
    'mediaUrl',
    'url',
    'fileUrl',
  ]) {
    final value = post[key];
    if (value is String && _looksLikeVideoUrl(value)) return value;
  }

  return null;
}

bool _looksLikeVideoUrl(String value) {
  final lower = value.toLowerCase();
  return lower.startsWith('http') &&
      (lower.contains('.mp4') ||
          lower.contains('.mov') ||
          lower.contains('.m3u8') ||
          lower.contains('/videos/'));
}
