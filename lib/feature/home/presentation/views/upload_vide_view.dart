import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:junior_football/core/constants/app_assets.dart';
import 'package:junior_football/core/routes/routes_name.dart';
import 'package:junior_football/core/utilities/show_toast_message.dart';
import 'package:junior_football/core/utilities/spaces.dart';
import 'package:junior_football/feature/home/presentation/view_model/home_state.dart';
import 'package:junior_football/feature/home/presentation/view_model/home_view_model.dart';
import '../../../../core/utilities/theme_extension.dart';
import '../widgets/custom_click.dart';

class UploadVideView extends StatefulWidget {
  const UploadVideView({super.key});

  @override
  State<UploadVideView> createState() => _UploadVideViewState();
}

class _UploadVideViewState extends State<UploadVideView> {
  StreamSubscription? _streamSubscription;
  @override
  void initState() {
    _streamSubscription = context.read<HomeViewModel>().eventStream.listen((
      event,
    ) {
      switch (event) {
        case UploadVideoEvent():
          if (mounted) {
            Navigator.of(context).pushNamed(AppRoutes.analyzeWithVideoView,arguments:event.videoUrl);
          }
        case SendToast():
          if (mounted) {
            ShowToastMessage.show(context: context, message: event.message);
          }
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _streamSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: Text("uploadVideo.videoInput".tr()),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.0.w, vertical: 15.h),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                "uploadVideo.chooseHow".tr(),
                textAlign: TextAlign.center,
                style: theme.regular16.copyWith(color: theme.surface),
              ),
              SizedBox(height: 24.h),
              _CustomActionCard(
                image: AppAssets.recordVideo,
                title: "uploadVideo.recordVideo".tr(),
                subtitle: "uploadVideo.captureLive".tr(),
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.recordVideoScreen);
                },
              ),
              SizedBox(height: 15.h),
              BlocBuilder<HomeViewModel, HomeState>(
                builder: (context, state) {
                  if (state.uploadVideo!.isLoading) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "${state.progress!.floor().toString()}%",
                          style: theme.semiBold24,
                        ),
                        VerticalSpace(20),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: LinearProgressIndicator(
                            minHeight: 12,
                            backgroundColor: Colors.grey.shade300,
                            valueColor: AlwaysStoppedAnimation(theme.primary),
                          ),
                        ),
                      ],
                    );
                  }
                  return _CustomActionCard(
                    image: AppAssets.uploadVideo,
                    title: "uploadVideo.uploadVideoTitle".tr(),
                    subtitle: "uploadVideo.uploadFromDevice".tr(),
                    onTap: () {
                      context.read<HomeViewModel>().doIntent(
                        UploadVideoIntent(),
                      );
                    },
                  );
                },
              ),

              SizedBox(height: 50.h),

              CustomClick(
                title: "uploadVideo.viewAiReport".tr(),
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.recentAiReport);
                },
                backgroundColor: theme.primary,
                textColor: theme.secondary,
              ),

              SizedBox(height: 12.h),

              CustomClick(
                title: "uploadVideo.cancel".tr(),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              SizedBox(height: 50.h),
            ],
          ),
        ),
      ),
    );
  }
}

class _CustomActionCard extends StatelessWidget {
  const _CustomActionCard({
    required this.image,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final String image;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: theme.primary.withOpacity(0.5), width: 2),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 25.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Image.asset(image, width: 65.w, height: 65.h),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: theme.semiBold24.copyWith(
                      color: theme.surface,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    subtitle,
                    style: theme.regular18.copyWith(color: theme.subTitle),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
