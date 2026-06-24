import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/routes/routes_name.dart';
import '../../../../core/utilities/theme_extension.dart';

class CommunityPostCard extends StatelessWidget {
  final String name;
  final String time;
  final String image;
  final String? content;
  final String? postImage;
  final int? likes;
  final int? comments;
  final VoidCallback? onLikeTap;
  final VoidCallback? onCommentTap;
  final VoidCallback? onUnfollowTap;
  final VoidCallback? onAuthorTap;
  final VoidCallback? onDeleteTap;
  final bool isLiked;

  const CommunityPostCard({
    super.key,
    required this.name,
    required this.time,
    required this.image,
    this.content,
    this.postImage,
    this.likes,
    this.comments,
    this.onLikeTap,
    this.onCommentTap,
    this.onUnfollowTap,
    this.onAuthorTap,
    this.onDeleteTap,
    this.isLiked = false,
  });

  @override
  Widget build(BuildContext context) {
    var theme = context.appTheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            InkWell(
              onTap: onAuthorTap,
              customBorder: const CircleBorder(),
              child: CircleAvatar(
                radius: 22.r,
                backgroundColor: theme.borderColor,
                child: CachedNetworkImage(
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),

                  errorWidget: (context, url, error) => const Icon(Icons.error),
                  imageUrl: image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: InkWell(
                onTap: onAuthorTap,
                borderRadius: BorderRadius.circular(6.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: theme.semiBold16,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      time,
                      style: theme.regular14.copyWith(color: theme.subTitle),
                    ),
                  ],
                ),
              ),
            ),
            if (onUnfollowTap != null) ...[
              SizedBox(width: 8.w),
              TextButton(
                onPressed: onUnfollowTap,
                child: Text('communityPost.unfollow'.tr()),
              ),
            ],
            if (onDeleteTap != null)
              IconButton(
                onPressed: onDeleteTap,
                icon: const Icon(Icons.delete_outline),
                color: Colors.red,
              ),
          ],
        ),
        SizedBox(height: 12.h),
        if (content != null && content!.isNotEmpty) ...[
          Text(content!, style: theme.regular18),
          SizedBox(height: 10.h),
        ],
        if (postImage != null && postImage!.isNotEmpty) ...[
          ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => _imageViewer(postImage!)),
                );
              },
              child: CachedNetworkImage(
                imageUrl: postImage!,
                width: double.infinity,
                height: 220.h,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  color: theme.borderColor,
                  child: const Center(child: CircularProgressIndicator()),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
          ),
          SizedBox(height: 10.h),
        ],
        Divider(color: theme.borderColor, thickness: 0.5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _action(
              isLiked ? Icons.favorite : Icons.favorite_border,
              "${likes ?? 0}",
              context,
              iconColor: isLiked ? Colors.red : null,
              onTap: onLikeTap,
            ),
            _action(
              Icons.mode_comment_outlined,
              "${comments ?? 0}",
              context,
              onTap:
                  onCommentTap ??
                  () => Navigator.pushNamed(context, AppRoutes.postView),
            ),
            _action(Icons.share, "communityPost.share".tr(), context, onTap: () => _showShareSheet(context)),
          ],
        ),
      ],
    );
  }

  Widget _action(
    IconData icon,
    String text,
    BuildContext context, {
    VoidCallback? onTap,
    Color? iconColor,
  }) {
    var theme = context.appTheme;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8.r),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
        child: Row(
          children: [
            Icon(icon, size: 18.w, color: iconColor ?? theme.subTitle),
            SizedBox(width: 5.w),
            Text(text, style: theme.regular14.copyWith(color: theme.subTitle)),
          ],
        ),
      ),
    );
  }

  Widget _imageViewer(String image) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTap: () => Navigator.pop,
        child: Center(
          child: InteractiveViewer(
            child: image.startsWith('http')
                ? CachedNetworkImage(imageUrl: image)
                : Image.asset(image),
          ),
        ),
      ),
    );
  }
  void _showShareSheet(BuildContext context) {
    final postLink = postImage ?? content ?? '';
    showModalBottomSheet<void>(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (ctx) {
        final sheetTheme = ctx.appTheme;
        return SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: sheetTheme.progressTrack,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'communityPost.share'.tr(),
                style: sheetTheme.semiBold16,
              ),
              const SizedBox(height: 12),
              ListTile(
                leading: const Icon(Icons.link_rounded, color: Colors.blue),
                title: Text('communityPost.copyLink'.tr()),
                onTap: () {
                  Clipboard.setData(ClipboardData(text: postLink));
                  Navigator.pop(ctx);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('communityPost.linkCopied'.tr()),
                      duration: const Duration(seconds: 2),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
              ),
              ListTile(
                leading:
                    const Icon(Icons.content_copy_rounded, color: Colors.green),
                title: Text('communityPost.copyContent'.tr()),
                onTap: () {
                  Clipboard.setData(ClipboardData(text: content ?? ''));
                  Navigator.pop(ctx);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('communityPost.contentCopied'.tr()),
                      duration: const Duration(seconds: 2),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      );
      },
    );
  }
}
