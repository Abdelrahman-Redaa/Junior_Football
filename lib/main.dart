import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:junior_football/core/base_bloc/my_bloc_observer.dart';
import 'package:junior_football/core/constants/keys.dart';
import 'package:junior_football/core/routes/routes_name.dart';
import 'package:junior_football/core/theme/theme_cubit.dart';
import 'package:junior_football/core/utilities/app_local_storage.dart';
import 'package:junior_football/junior_football_app.dart';
import 'package:media_kit/media_kit.dart';
import 'core/di/di.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MediaKit.ensureInitialized();
  String initRoute = await _checkInitRoute();
  await configureDependencies();
  await EasyLocalization.ensureInitialized();

  final themeCubit = ThemeCubit();
  await themeCubit.loadTheme();

  Bloc.observer = MyBlocObserver();

  runApp(
    BlocProvider(
      create: (_) => themeCubit,
      child: EasyLocalization(
        saveLocale: true,
        supportedLocales: const [Locale('en'), Locale('ar')],
        path: 'assets/translations',
        fallbackLocale: const Locale('en'),
        child: JuniorFootballApp(initRoute: initRoute),
      ),
    ),
  );
}

Future<String> _checkInitRoute() async {
  final token = await AppLocalStorage.getSecuredString(key: AppKeys.token);
  if (token.isNotEmpty) {
    return AppRoutes.bottomNavigationView;
  } else {
    return AppRoutes.welcomeView;
  }
}
