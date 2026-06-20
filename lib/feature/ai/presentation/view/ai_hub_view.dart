import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:junior_football/core/constants/app_assets.dart';
import 'package:junior_football/core/routes/routes_name.dart';
import 'package:junior_football/core/utilities/spaces.dart';
import 'package:junior_football/core/utilities/theme_extension.dart';

class AiHubView extends StatefulWidget {
  const AiHubView({super.key});

  @override
  State<AiHubView> createState() => _AiHubViewState();
}

class _AiHubViewState extends State<AiHubView> {
  final List<_CardModel> _cardModel = _CardModel.cardModel;

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return Scaffold(
      appBar: AppBar(title: Text("Ai Hub")),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 37),
        child: GridView.builder(
          itemCount: _cardModel.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 164 / 152,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () =>
                  Navigator.pushNamed(context, _cardModel[index].routeName),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xff6FC482)),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    VerticalSpace(8),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: _cardModel[index].bgColor,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: SvgPicture.asset(_cardModel[index].assetName),
                    ),
                    VerticalSpace(16),
                    Text(_cardModel[index].title, style: theme.regular16),
                    Flexible(
                      child: Text(
                        _cardModel[index].description,
                        style: theme.regular14.copyWith(
                          fontSize: 12,
                          color: theme.subTitle,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _CardModel {
  final String assetName;
  final Color bgColor;
  final String title;
  final String description;
  final String routeName;

  _CardModel({
    required this.assetName,
    required this.bgColor,
    required this.title,
    required this.description,
    required this.routeName,
  });
  static List<_CardModel> get cardModel => [
    _CardModel(
      routeName: AppRoutes.recordVideoScreen,
      assetName: SVGAssets.camera,
      bgColor: Color(0xff28A745),
      title: "Record video",
      description: "Capture live footage",
    ),
    _CardModel(
      routeName: AppRoutes.uploadVideView,
      assetName: SVGAssets.upload,
      bgColor: Color(0xffFF8C42),
      title: "Upload Video",
      description: "Import your game footage",
    ),
    _CardModel(
      routeName: AppRoutes.recentAiReport,
      assetName: SVGAssets.report,
      bgColor: Color(0xffFFD700),
      title: "Recent Ai report",
      description: "View latest analysis",
    ),
    _CardModel(
      routeName: AppRoutes.skillTwinView,
      assetName: SVGAssets.twin,
      bgColor: Color(0xff9495AB),
      title: "skill twin",
      description: "Ai player comparison",
    ),
    _CardModel(
      routeName: AppRoutes.injuryProtectionView,
      assetName: SVGAssets.analysis,
      bgColor: Color(0xff3CB371),
      title: "Injury Prediction",
      description: "Risk assessment insight",
    ),
    _CardModel(
      routeName: AppRoutes.chatBotView,
      assetName: SVGAssets.chat,
      bgColor: Color(0xff6A5ACD),
      title: "Chat with Ai",
      description: "Ask Ai any question",
    ),
  ];
}
