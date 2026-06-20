import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utilities/theme_extension.dart';
import 'custom_click.dart';

class CustomCartCommunity extends StatelessWidget {
  final String image;
  final String subtitle;
  final String title;
  final VoidCallback onTap;
  final String history;
  final bool isEndOfList;

  const CustomCartCommunity({
    super.key,
    required this.image,
    required this.title,
    required this.subtitle,
    required this.history,
    required this.onTap, required this.isEndOfList,
  });

  @override
  Widget build(BuildContext context) {
    var theme = context.appTheme;

    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 25.r,
              child: CachedNetworkImage(
                imageUrl: image,
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
                errorWidget: (context, url, error) =>
                    const Icon(Icons.error),
              ),
            ),

            SizedBox(width: 10.w),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style: theme.semiBold16,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(width: 6.w),
                      CircleAvatar(
                        radius: 4.r,
                        backgroundColor: theme.subTitle,
                      ),
                      SizedBox(width: 4.w),
                      Text(history, style: theme.regular14),
                    ],
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    subtitle,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: theme.regular14.copyWith(color: theme.surface),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 15.h),
        ?isEndOfList?   CustomClick(title: 'Go to Community',onTap: onTap,):null,
      ],
    );
  }
}
