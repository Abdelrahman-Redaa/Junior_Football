import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:junior_football/core/routes/app_routes.dart';
import 'package:junior_football/core/theme/dark_theme.dart';
import 'package:junior_football/core/theme/light_theme.dart';
import 'package:junior_football/core/theme/theme_cubit.dart';
import 'package:junior_football/core/utilities/navigation_service.dart';

class JuniorFootballApp extends StatelessWidget {
  final String initRoute;
  const JuniorFootballApp({super.key, required this.initRoute});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, _) {
        return BlocBuilder<ThemeCubit, ThemeMode>(
          builder: (context, themeMode) {
            return MaterialApp(
              navigatorKey: NavigationService.navigatorKey,
              title: 'Junior Football',
              debugShowCheckedModeBanner: false,
              theme: LightTheme().themeData,
              darkTheme: DarkTheme().themeData,
              themeMode: themeMode,
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              locale: context.locale,
              initialRoute: initRoute,
              onGenerateRoute: Routes.onGenerateRoute,
            );
          },
        );
      },
    );
  }
}
