import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/utilities/theme_extension.dart';

class CustomSpeedTraining extends StatelessWidget {
  final String title;
  final String subtitle;
  final String duration;
  final String rounds;
  final String level;
  final String category;
  final String imageUrl;

  const CustomSpeedTraining({
    super.key,
    required this.title,
    required this.subtitle,
    required this.duration,
    required this.rounds,
    required this.level,
    required this.category,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    var theme = context.appTheme;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
      decoration: BoxDecoration(
        color: const Color(0xFFE9F2EB),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Container(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                width: 35.w,
                height: 35.h,
                decoration: BoxDecoration(
                  color: const Color(0xFFB9D7C0),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child:SvgPicture.asset(
                    SVGAssets.football,
                ),
              ),

              SizedBox(width: 10.w),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.semiBold24.copyWith(
                        color: const Color(0xFF11461D),
                      ),
                    ),

                    Text(
                      subtitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.regular14.copyWith(
                        color: const Color(0xFF11461D),
                        fontSize: 10.sp,
                      )
                    ),
                  ],
                ),
              ),

              SizedBox(width: 10.w),

              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [

                  Text(
                    duration,
                    style:theme.semiBold16.copyWith(
                      color: const Color(0xFF11461D),
                      fontSize: 18.sp
                    )
                  ),


                   Text(
                      rounds,
                      textAlign: TextAlign.end,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style:theme.regular14.copyWith(
                        color: const Color(0xFF68A977),
                        fontSize: 10.sp,
                      ),
                  ),

                ],
              ),
            ],
          ),

          SizedBox(height: 15.h),


          Row(
            children: [
              _infoItem(
                icon:  SVGAssets.clock,
                text: duration,
                context: context,
              ),
              SizedBox(width: 15.w),
              _infoItem(
                icon:  SVGAssets.medium,
                text: level,
                context: context,
              ),
              SizedBox(width: 15.w),
              _infoItem(
                icon:  SVGAssets.legs,
                text: category,
                context: context,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _infoItem({
    required String icon,
    required String text,
    required BuildContext context,
  }) {
    var theme=context.appTheme;
    return Row(
      children: [
        SvgPicture.asset(
          icon,
          height: 16.h,
          fit: BoxFit.contain,
          color: const Color(0xFF68A977),
        ),
        SizedBox(width: 5.w),
        Text(
          text,
          style: theme.regular14.copyWith(
            color: const Color(0xFF68A977),
            fontSize: 12.sp,
    )
        ),
      ],
    );
  }
}