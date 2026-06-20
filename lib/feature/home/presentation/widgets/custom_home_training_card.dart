import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utilities/theme_extension.dart';

class CustomHomeTrainingCard extends StatelessWidget {


  const CustomHomeTrainingCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var theme = context.appTheme;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            theme.primary,
            const Color(0xff1E7E34),
          ],
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 25.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [


            Row(
              children: [
                Expanded(
                  child: Text(
                    "Home Training",
                    style: theme.semiBold24.copyWith(
                      color: Colors.white,
                      fontSize: 24.sp,
                    ),
                  ),
                ),
                Icon(
                  Icons.home,
                  color: Colors.white,
                  size: 35.sp,
                ),
              ],
            ),

            SizedBox(height: 6.h),

            /// Subtitle
            Text(
              "Improve your training day by day from home",
              style: theme.regular14.copyWith(
                color: Colors.white,
              ),
            ),

            SizedBox(height: 12.h),

            /// Stats Row
            Row(
              children: [
                _buildBox(
                  label: "Total Sessions",
                  value: "24",
                  context: context,
                ),
                SizedBox(width: 10.w),
                _buildBox(
                  label: "This Week",
                  context: context,
                  value: "25",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBox({
    required String label,
    required String value,
    required BuildContext context,
  }) {
    var theme = context.appTheme;
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: const Color(0xFF53B96A).withOpacity(0.5),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: theme.regular16.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),),
            SizedBox(height: 6.h),
            Text(value, style:  theme.semiBold28.copyWith(
              color: Colors.white,
            ),),
          ],
        ),
      ),
    );
  }
}