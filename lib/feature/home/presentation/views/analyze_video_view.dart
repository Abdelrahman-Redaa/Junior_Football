import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:junior_football/core/routes/routes_name.dart';
import 'package:junior_football/core/utilities/loading_indicator.dart';
import 'package:junior_football/core/utilities/show_toast_message.dart';
import 'package:junior_football/feature/home/presentation/view_model/analysis_state.dart';
import 'package:junior_football/feature/home/presentation/view_model/analysis_view_model.dart';
import '../../../../core/utilities/theme_extension.dart';
import '../widgets/custom_click.dart';

class AnalyzeVideoView extends StatefulWidget {
  const AnalyzeVideoView({super.key});

  @override
  State<AnalyzeVideoView> createState() => _AnalyzeVideoViewState();
}

class _AnalyzeVideoViewState extends State<AnalyzeVideoView> {
  StreamSubscription? _streamSubscription;
  @override
  void initState() {
    _streamSubscription = context.read<AnalysisViewModel>().eventStream.listen((
      event,
    ) {
      switch (event) {
        case AnalysisVideoEvent():
          if (mounted) {
            Navigator.of(context).pushReplacementNamed(
              AppRoutes.aiReportView,
              arguments: event.analysisEntity,
            );
          }
        case SendToast():
          if (mounted) {
            ShowToastMessage.show(context: context, message: event.message,isError: true);
            Navigator.of(context).pushReplacementNamed(
              AppRoutes.bottomNavigationView,

            );
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
    var theme = context.appTheme;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        title: Text(
          "analyzeVideo.title".tr(),
          style: theme.semiBold24,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.0.w, vertical: 20.h),
        child: Column(
          children: [
            Text(
              "analyzeVideo.analyzing".tr(),
              style: theme.semiBold24.copyWith(
                color: theme.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 8.h),
            Text("analyzeVideo.takeFewSeconds".tr(), style: theme.regular18),
            Spacer(),

            LoadingIndicator(),
            SizedBox(height: 60.h),
            Text(
              "analyzeVideo.analyzingShort".tr(),
              style: theme.semiBold24.copyWith(
                color: theme.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
            Spacer(),
            CustomClick(
              title: "uploadVideo.cancel".tr(),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}
