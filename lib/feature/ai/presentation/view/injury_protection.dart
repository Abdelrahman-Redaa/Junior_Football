
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:junior_football/core/constants/app_assets.dart';
import 'package:junior_football/core/utilities/spaces.dart';
import 'package:junior_football/core/utilities/theme_extension.dart';

class InjuryProtectionView extends StatefulWidget {
  const InjuryProtectionView({super.key});

  @override
  State<InjuryProtectionView> createState() => _InjuryProtectionViewState();
}

class _InjuryProtectionViewState extends State<InjuryProtectionView> {
  final _protectedModel = InjuryProtectionModel.protectionModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("injury Protection")),
      body: Padding(
        padding: EdgeInsets.only(top: 81, right: 24, left: 24),
        child: ListView.separated(
          itemCount: _protectedModel.length,
          itemBuilder: (context, index) => _buildCard(context, index),
          separatorBuilder: (context, index) => VerticalSpace(24),
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context, int index) {
    final theme = context.appTheme;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Color(0xffEAF6EC),
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        title: Text(_protectedModel[index].title, style: theme.regular18),
        subtitle: Text(
          _protectedModel[index].description,
          style: theme.medium14.copyWith(color: theme.subTitle),
        ),
        leading: CircleAvatar(
          backgroundColor: theme.primary,
          child: SvgPicture.asset(_protectedModel[index].icon),
        ),
      ),
    );
  }
}

final class InjuryProtectionModel {
  final String icon;
  final String title;
  final String description;

  InjuryProtectionModel({
    required this.icon,
    required this.title,
    required this.description,
  });

  static List<InjuryProtectionModel> get protectionModel => [
    InjuryProtectionModel(
      icon: SVGAssets.warmSvg,
      title: "Warm Up Properly",
      description: "Always warm up for 5–10 minutes before training",
    ),
    InjuryProtectionModel(
      icon: SVGAssets.hydrationSvg,
      title: "Stay Hydrated",
      description:
      "Drink enough water during training to avoid fatigue and injury",
    ),
    InjuryProtectionModel(
      icon: SVGAssets.strengthSvg,
      title: "Strength & Stability",
      description: "Build core strength to protect your muscles.",
    ),
    InjuryProtectionModel(
      icon: SVGAssets.overtrainSvg,
      title: "Don't Overtrain",
      description: "Avoid pushing your body beyond its limits.",
    ),
  ];
}