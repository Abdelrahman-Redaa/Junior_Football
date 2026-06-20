import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:junior_football/core/routes/routes_name.dart';
import 'package:junior_football/feature/home/presentation/view_model/home_state.dart';
import 'package:junior_football/feature/home/presentation/view_model/home_view_model.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/utilities/theme_extension.dart';

class HeaderCustom extends StatelessWidget {
  const HeaderCustom({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return Row(
      children: [
        Image.asset(
          AppAssets.ball,
          width: 45.w,
          height: 40.h,
          fit: BoxFit.contain,
        ),
        SizedBox(width: 12.w),
        Text(
          "Junior Football",
          style: theme.regular16.copyWith(
            color: theme.subTitle,
            fontWeight: FontWeight.bold,
          ),
        ),
        Spacer(),
        GestureDetector(
          onTap: () =>
              Navigator.of(context).pushNamed(AppRoutes.playerProfileView),
          child: BlocBuilder<HomeViewModel, HomeState>(
            builder: (context, state) {
              if (state.trainingDashboard.isLoaded) {
                return CircleAvatar(
                  radius: 20.r,
                  child: CachedNetworkImage(
                    imageUrl: state.trainingDashboard.data!.userAvatarUrl,
                    errorWidget: (context, url, error) => Icon(Icons.error),
                    imageBuilder: (context, imageProvider) => CircleAvatar(
                      radius: 20.r,
                      backgroundImage: imageProvider,
                    ),
                  ),
                );
              } else {
                return CircleAvatar(
                  radius: 20.r,
                  backgroundColor: theme.primary,
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
