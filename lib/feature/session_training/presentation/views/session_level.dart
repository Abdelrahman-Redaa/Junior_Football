import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:junior_football/core/constants/app_assets.dart';
import 'package:junior_football/core/utilities/spaces.dart';
import 'package:junior_football/core/utilities/theme_extension.dart';

class SessionLevelView extends StatefulWidget {
  const SessionLevelView({super.key});

  @override
  State<SessionLevelView> createState() => _SessionLevelViewState();
}

class _SessionLevelViewState extends State<SessionLevelView> {
  final _sessionLevelModel = _SessionLevelModel.sessionLevelModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: PageView.builder(
        itemCount: _sessionLevelModel.length,
        itemBuilder: (context, index) {
          return PageViewBody(model: _sessionLevelModel[index]);
        },
      ),
    );
  }
}

class PageViewBody extends StatelessWidget {
  const PageViewBody({super.key, required this.model});
  final _SessionLevelModel model;
  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            Image.asset(model.image, height: 240),
            Text(model.title, style: theme.semiBold28),
            Text(
              textAlign: TextAlign.center,
              model.subTitle,
              style: theme.regular16.copyWith(color: theme.neutral),
            ),
            VerticalSpace(70),
            _buildSessionSummery(context),
            VerticalSpace(70),
            ElevatedButton.icon(
              onPressed: () {},
              icon: Icon(Icons.file_download_done_rounded),
              label: Text("sessionLevel.backToDaily".tr()),
            ),
            VerticalSpace(16),
            OutlinedButton.icon(
              onPressed: () {},
              icon: Icon(Icons.calendar_month_outlined),
              label: Text("sessionLevel.viewWeeklyPlan".tr()),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSessionSummery(BuildContext context) {
    final theme = context.appTheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final fillColor = isDark
        ? model.sessionSummery.iconColor.withValues(alpha: 0.2)
        : model.sessionSummery.bgColor;
    final borderColor = isDark
        ? model.sessionSummery.iconColor.withValues(alpha: 0.35)
        : model.sessionSummery.bgColor;
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: borderColor),
        boxShadow: [BoxShadow(blurRadius: 1, color: theme.borderColor)],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        spacing: 30,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            spacing: 8,
            children: [
              SvgPicture.asset(model.sessionSummery.mainImage),
              Text(model.sessionSummery.title, style: theme.semiBold16),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            spacing: 8,
            children: [
              Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: fillColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: SvgPicture.asset(
                  model.sessionSummery.trainingDurationImage,
                ),
              ),
              Text(model.sessionSummery.subTitle, style: theme.semiBold16),
            ],
          ),
          Divider(height: 0, color: model.sessionSummery.iconColor),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            spacing: 8,
            children: [
              Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: fillColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: SvgPicture.asset(model.sessionSummery.trainingImage),
              ),
              Text(model.sessionSummery.thirdTitle, style: theme.semiBold16),
            ],
          ),
        ],
      ),
    );
  }
}

class _SessionLevelModel {
  final String image;
  final String title;
  final String subTitle;
  final _SessionSummery sessionSummery;

  _SessionLevelModel({
    required this.image,
    required this.title,
    required this.subTitle,
    required this.sessionSummery,
  });

  static List<_SessionLevelModel> get sessionLevelModel => [
    _SessionLevelModel(
      image: AppAssets.target,
      title: "sessionLevel.sessionCompleted".tr(),
      subTitle: 'sessionLevel.completedSub'.tr(),
      sessionSummery: _SessionSummery(
        iconColor: Color(0xff1C7731),
        bgColor: Color(0xffB9D7C0),
        mainImage: SVGAssets.greenChart,
        trainingImage: SVGAssets.greenKathi,
        trainingDurationImage: SVGAssets.greenClock,
      ),
    ),
    _SessionLevelModel(
      image: AppAssets.flash,
      title: "sessionLevel.goodJob".tr(),
      subTitle: 'sessionLevel.goodJobSub'.tr(),
      sessionSummery: _SessionSummery(
        iconColor: Color(0xffFFCC00),
        bgColor: Color(0xffFFFAE6),
        mainImage: SVGAssets.yellowChart,
        trainingImage: SVGAssets.yellowKathi,
        trainingDurationImage: SVGAssets.yellowClock,
      ),
    ),
    _SessionLevelModel(
      image: AppAssets.complete,
      title: "sessionLevel.workHard".tr(),
      subTitle: 'sessionLevel.workHardSub'.tr(),
      sessionSummery: _SessionSummery(
        iconColor: Color(0xffFF3B30),
        bgColor: Color(0xffFFECEB),
        mainImage: SVGAssets.redChart,
        trainingImage: SVGAssets.redKathi,
        trainingDurationImage: SVGAssets.redClock,
      ),
    ),
  ];
}

class _SessionSummery {
  final String title = "sessionLevel.sessionSummery".tr();
  final String subTitle = "sessionLevel.trainingCompleted".tr();
  final String thirdTitle = "sessionLevel.totalDuration".tr();
  final Color iconColor;
  final Color bgColor;
  final String mainImage;
  final String trainingImage;
  final String trainingDurationImage;

  _SessionSummery({
    required this.iconColor,
    required this.bgColor,
    required this.mainImage,
    required this.trainingImage,
    required this.trainingDurationImage,
  });
}
