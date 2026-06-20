import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:junior_football/feature/home/domain/entity/community_feed_entity.dart';

import '../../../../core/utilities/theme_extension.dart';

class CommentItem extends StatelessWidget {
  final CommentsEntity comment;

  const CommentItem({super.key, required this.comment});

  @override
  Widget build(BuildContext context) {
    var theme = context.appTheme;

    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 20.r,

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
              placeholder: (context, url) => const CircularProgressIndicator(),
              imageUrl: comment.userProfileImage,
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),

          SizedBox(width: 10.w),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                color: theme.borderColor.withOpacity(0.3),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    comment.userName,
                    style: theme.semiBold16.copyWith(fontSize: 14.sp),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    comment.content,
                    style: theme.regular14.copyWith(fontSize: 13.sp),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
