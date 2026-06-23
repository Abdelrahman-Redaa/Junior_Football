import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:junior_football/core/constants/app_assets.dart';
import 'package:junior_football/core/di/di.dart';
import 'package:junior_football/feature/ai/presentation/widget/video_player.dart';
import 'package:junior_football/feature/profile/presentation/view_model/profile_state.dart';
import 'package:junior_football/feature/profile/presentation/view_model/profile_view_model.dart';

class PlayerProfileView extends StatefulWidget {
  const PlayerProfileView({super.key, this.userId});

  final String? userId;

  @override
  State<PlayerProfileView> createState() => _PlayerProfileViewState();
}

class _PlayerProfileViewState extends State<PlayerProfileView> {
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickProfileImage(BuildContext context) async {
    final viewModel = context.read<ProfileViewModel>();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (!mounted || image == null) return;

    final file = File(image.path);
    viewModel.doIntent(UploadProfilePictureIntent(file: file));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7FB),
      appBar: AppBar(
        title: Text('profile.playerProfile'.tr()),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.maybePop(context),
        ),
      ),
      body: SafeArea(
        child: BlocProvider(
          create: (context) {
            final viewModel = getIt.get<ProfileViewModel>();
            final userId = widget.userId;
            viewModel.doIntent(
              userId == null || userId.isEmpty
                  ? GetProfileIntent()
                  : GetProfileByIdIntent(userId: userId),
            );
            return viewModel;
          },
          child: BlocBuilder<ProfileViewModel, ProfileState>(
            builder: (context, state) {
              final isCurrentUserProfile = widget.userId == null;
              if (state.profile.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state.profile.isError) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        state.profile.errorMessage ?? 'Failed to load profile',
                      ),
                      SizedBox(height: 12.h),
                      ElevatedButton(
                        onPressed: () {
                          final userId = widget.userId;
                          context.read<ProfileViewModel>().doIntent(
                            userId == null || userId.isEmpty
                                ? GetProfileIntent()
                                : GetProfileByIdIntent(userId: userId),
                          );
                        },
                        child: Text('profile.retry'.tr()),
                      ),
                    ],
                  ),
                );
              }

              final profile = state.profile.data;
              if (profile == null) return const SizedBox.shrink();
              final isFollowing = profile.isFollowing ?? false;

              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Avatar / Name / Rank
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Column(
                        children: [
                          SizedBox(height: 12.h),
                          GestureDetector(
                            onTap: isCurrentUserProfile
                                ? () => _pickProfileImage(context)
                                : null,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                CircleAvatar(
                                  radius: 56.r,
                                  backgroundImage:
                                      profile.profileImageUrl != null
                                      ? NetworkImage(profile.profileImageUrl!)
                                      : null,
                                  child: profile.profileImageUrl == null
                                      ? Icon(Icons.person, size: 48.r)
                                      : null,
                                ),
                                if (state.uploadPicture.isLoading)
                                  Container(
                                    width: 112.r,
                                    height: 112.r,
                                    decoration: BoxDecoration(
                                      color: Colors.black.withValues(
                                        alpha: 0.35,
                                      ),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Center(
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                profile.fullName ?? profile.userName ?? '',
                                style: TextStyle(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(width: 8.w),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8.w,
                                  vertical: 4.h,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.green.shade600,
                                  borderRadius: BorderRadius.circular(16.r),
                                ),
                                child: Text(
                                  profile.globalRank == null
                                      ? 'Player'
                                      : '#${profile.globalRank}',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12.sp,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8.h),
                          SelectableText(
                            'ID: ${profile.userId ?? '-'}',
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 12.sp,
                            ),
                          ),
                          SizedBox(height: 16.h),

                          // Stat cards
                          Row(
                            children: [
                              _statCardSmall(
                                icon: Icons.people_outline,
                                value: '${profile.followersCount ?? 0}',
                                label: 'Followers',
                              ),
                              SizedBox(width: 8.w),
                              _statCardSmall(
                                icon: Icons.person_add_alt,
                                value: '${profile.followingCount ?? 0}',
                                label: 'Following',
                              ),
                              SizedBox(width: 8.w),
                              _statCardSmall(
                                icon: Icons.bolt_outlined,
                                value: '${profile.xp ?? 0}',
                                label: 'XP',
                              ),
                            ],
                          ),
                          SizedBox(height: 12.h),
                          if (!isCurrentUserProfile) ...[
                            ElevatedButton.icon(
                              onPressed:
                                  profile.userId == null ||
                                      state.followAction.isLoading
                                  ? null
                                  : () {
                                      final intent = isFollowing
                                          ? UnfollowUserIntent(
                                              userId: profile.userId!,
                                            )
                                          : FollowUserIntent(
                                              userId: profile.userId!,
                                            );
                                      context.read<ProfileViewModel>().doIntent(
                                        intent,
                                      );
                                    },
                              icon: state.followAction.isLoading
                                  ? SizedBox(
                                      width: 16.r,
                                      height: 16.r,
                                      child: const CircularProgressIndicator(
                                        strokeWidth: 2,
                                        color: Colors.white,
                                      ),
                                    )
                                  : Icon(
                                      isFollowing
                                          ? Icons.person_remove_alt_1_outlined
                                          : Icons.person_add_alt_1_outlined,
                                    ),
                              label: Text(isFollowing ? 'community.unfollow'.tr() : 'Follow'),
                            ),
                            SizedBox(height: 18.h),
                          ],

                          // Details
                          _infoRow(
                            Icons.cake_outlined,
                            'Age',
                            _ageText(profile.dateOfBirth),
                          ),
                          SizedBox(height: 8.h),
                          _infoRow(
                            Icons.flag_outlined,
                            'Nationality',
                            profile.country ?? '-',
                          ),
                          SizedBox(height: 8.h),
                          _infoRow(
                            Icons.height,
                            'Height/Weight',
                            '${_numberText(profile.height, suffix: ' cm')} / ${_numberText(profile.weight, suffix: ' kg')}',
                          ),
                          SizedBox(height: 8.h),
                          _infoRow(
                            Icons.sports_football,
                            'Preferred Foot',
                            profile.preferredFoot ?? '-',
                          ),
                          SizedBox(height: 8.h),
                          _infoRow(Icons.group, 'Team', profile.team ?? '-'),
                          SizedBox(height: 8.h),
                          _infoRow(
                            Icons.video_library_outlined,
                            'Posts',
                            '',
                            trailing: _videoBadge(
                              '${profile.posts?.length ?? 0} Posts',
                            ),
                          ),

                          SizedBox(height: 18.h),
                          _PlayerVideoGallery(posts: profile.posts),
                          SizedBox(height: 18.h),
                          _matchCard(),
                          SizedBox(height: 24.h),
                        ],
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

  Widget _statCardSmall({
    required IconData icon,
    required String value,
    required String label,
  }) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        decoration: BoxDecoration(
          color: Colors.green.shade600,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: Colors.white, size: 22.r),
            SizedBox(height: 8.h),
            Text(
              value,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 6.h),
            Text(label, style: TextStyle(color: Colors.white70)),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(
    IconData icon,
    String title,
    String value, {
    Widget? trailing,
  }) {
    return Row(
      children: [
        Icon(icon, size: 18.r, color: Colors.grey[700]),
        SizedBox(width: 12.w),
        Expanded(
          child: Text(title, style: TextStyle(fontSize: 14.sp)),
        ),
        if (trailing != null)
          trailing
        else
          Text(value, style: TextStyle(color: Colors.black54)),
      ],
    );
  }

  Widget _videoBadge(String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: Colors.green.shade600,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Text(
        text,
        style: TextStyle(color: Colors.white, fontSize: 12.sp),
      ),
    );
  }

  Widget _matchCard() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      elevation: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: Image.asset(
                  AppAssets.profile,
                  height: 160.h,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                left: 12.w,
                top: 12.h,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 6.h,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.green.shade600,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Text(
                    'Match',
                    style: TextStyle(color: Colors.white, fontSize: 12.sp),
                  ),
                ),
              ),
              Positioned(
                right: 12.w,
                bottom: 12.h,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.6),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Text(
                    '12.45',
                    style: TextStyle(color: Colors.white, fontSize: 12.sp),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(12.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Match Highlights - Al Ahly Vs Zamalek',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    Icon(Icons.calendar_today_outlined, size: 16.r),
                    SizedBox(width: 6.w),
                    Text('11-10-2024', style: TextStyle(color: Colors.black54)),
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

class _PlayerVideoGallery extends StatelessWidget {
  const _PlayerVideoGallery({required this.posts});

  final List<dynamic>? posts;

  @override
  Widget build(BuildContext context) {
    final videos = _videoUrlsFromPosts(posts);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFFE6E6E6)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'profile.videoGallery'.tr(),
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10.h),
          if (videos.isEmpty)
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 18.h),
              decoration: BoxDecoration(
                color: const Color(0xFFE9F2EB),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.video_library_outlined,
                    color: Colors.green.shade700,
                    size: 32.r,
                  ),
                  SizedBox(height: 8.h),
                  Text('profile.noVideos'.tr()),
                ],
              ),
            )
          else
            SizedBox(
              height: 132.h,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: videos.length,
                separatorBuilder: (context, index) => SizedBox(width: 10.w),
                itemBuilder: (context, index) =>
                    _PlayerVideoTile(videoUrl: videos[index], index: index),
              ),
            ),
        ],
      ),
    );
  }
}

class _PlayerVideoTile extends StatelessWidget {
  const _PlayerVideoTile({required this.videoUrl, required this.index});

  final String videoUrl;
  final int index;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10.r),
      onTap: () => _showVideo(context),
      child: Container(
        width: 136.w,
        decoration: BoxDecoration(
          color: const Color(0xFFE8F5EC),
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(color: Colors.green.withValues(alpha: 0.35)),
        ),
        child: Stack(
          children: [
            Center(
              child: Icon(
                Icons.play_circle_fill_rounded,
                color: Colors.green.shade700,
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
                  style: TextStyle(color: Colors.white, fontSize: 12.sp),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showVideo(BuildContext context) {
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

String _ageText(DateTime? dateOfBirth) {
  if (dateOfBirth == null) return '-';
  final now = DateTime.now();
  var age = now.year - dateOfBirth.year;
  final hadBirthday =
      now.month > dateOfBirth.month ||
      (now.month == dateOfBirth.month && now.day >= dateOfBirth.day);
  if (!hadBirthday) age--;
  return age < 0 ? '-' : '$age Years Old';
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
