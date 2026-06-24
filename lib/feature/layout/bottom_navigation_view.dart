import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:junior_football/core/routes/routes_name.dart';
import 'package:junior_football/feature/community/presentation/views/community_view.dart';
import '../../core/constants/app_assets.dart';
import '../../core/utilities/theme_extension.dart';
import '../ai/presentation/view/ai_hub_view.dart';
import '../home/presentation/views/home_view.dart';
import '../profile/presentation/views/profile_view.dart';

class BottomNavigationView extends StatefulWidget {
  const BottomNavigationView({super.key});

  @override
  State<BottomNavigationView> createState() => _BottomNavigationViewState();
}

class _BottomNavigationViewState extends State<BottomNavigationView> {
  int selectedIndex = 0;

  final List<Widget> screens = const [
    HomeView(),
    CommunityView(),
    AiHubView(),
    ProfileView(),
  ];

  void changeTab(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return Scaffold(
      body: screens[selectedIndex],

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AppRoutes.recordVideoScreen);
        },
        backgroundColor: theme.primary,
        shape: const CircleBorder(),
        child: SvgPicture.asset(
          SVGAssets.cameraSVG,
          height: 24.h,
          color: theme.secondary,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,


      bottomNavigationBar: Container(

        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Color(0x14000000),
              blurRadius: 4,
              offset: Offset(0, -2),
              spreadRadius: 0,
            )
          ],
        ),
        child: MediaQuery.removePadding(
          context: context,
          removeTop: true,
          removeBottom: true,
          child: BottomAppBar(
            shape: const CircularNotchedRectangle(),
            notchMargin: 15.w,
            color: theme.backgroundColor,
            height: 95.h,
            child: SizedBox(
              height: 45,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildItem(SVGAssets.home, 0, theme),
                  _buildItem(SVGAssets.community, 1, theme),
                  const SizedBox(width: 40),
                  _buildItem(SVGAssets.ai, 2, theme),
                  _buildItem(SVGAssets.profile, 3, theme),
                ],
              ),
            ),
          ),
        ),
      ),

    );
  }


  Widget _buildItem(String icon, int index, dynamic theme) {
    final bool isSelected = selectedIndex == index;

    final List<String> labels = [
      'nav.home'.tr(),
      'nav.community'.tr(),
      'nav.ai'.tr(),
      'nav.profile'.tr(),
    ];

    return GestureDetector(
      onTap: () => changeTab(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            icon,
            height: 24.h,
            color: isSelected ? theme.primary : theme.subTitle,
          ),
          Text(
            labels[index],
            style: theme.regular14.copyWith(
              color: isSelected ? theme.primary : theme.subTitle,
            ),
          ),
        ],
      ),
    );
  }
}