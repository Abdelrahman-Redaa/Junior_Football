import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utilities/theme_extension.dart';

class CustomCard extends StatelessWidget {
  final String image;
  final String title;
  final void Function() onTap;
  const CustomCard({
    super.key,
    required this.image,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return Padding(
      padding: EdgeInsets.only(right: 12.0.w, top: 8.h),
      child: GestureDetector(
        onTap: onTap,
        child: Card(
          elevation: 3,
          color: theme.secondary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0.w, vertical: 10.h),
            child: Column(
              children: [
                Image.asset(image, width: 60.w, height: 60.h),
                SizedBox(height: 10.h),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: theme.regular14.copyWith(
                    color: theme.subTitle,
                    fontWeight: FontWeight(400),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
