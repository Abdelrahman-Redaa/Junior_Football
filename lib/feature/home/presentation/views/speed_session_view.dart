import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/utilities/theme_extension.dart';

class SpeedSessionView extends StatelessWidget {
  const SpeedSessionView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text("speed session"),
      ),

      body: Padding(
        padding: EdgeInsets.all(8.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  "Speed training",
                  style: theme.semiBold28.copyWith(color: theme.surface,fontWeight: FontWeight.bold),
                ),
                Spacer(),
                SvgPicture.asset(SVGAssets.clock,color: theme.neutral,width: 20.w,),
                SizedBox(width: 5.w,),
                Text("45mins/ 3rounds",style: theme.regular18.copyWith(color: theme.neutral),)
              ],
            ),
            SizedBox(height: 20.h,),
            Text("Instructions",style: theme.semiBold24.copyWith(color: theme.surface,fontWeight: FontWeight.bold),)
          ],
        ),
      ),

    );
  }
}
