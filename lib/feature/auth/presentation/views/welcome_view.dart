import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:junior_football/core/constants/app_assets.dart';
import 'package:junior_football/core/routes/routes_name.dart';
import 'package:junior_football/core/utilities//theme_extension.dart';
import 'package:junior_football/core/utilities/show_toast_message.dart';
import 'package:junior_football/core/utilities/spaces.dart';
import 'package:junior_football/feature/auth/presentation/view_model/auth_state.dart';
import 'package:junior_football/feature/auth/presentation/view_model/auth_view_model.dart';
import 'package:junior_football/feature/auth/presentation/widgets/custom_rich_text.dart';
import 'package:junior_football/feature/auth/presentation/widgets/login_with_google.dart';

class WelcomeView extends StatefulWidget {
  const WelcomeView({super.key});

  @override
  State<WelcomeView> createState() => _WelcomeViewState();
}

class _WelcomeViewState extends State<WelcomeView> {
  late StreamSubscription _eventSubscription;

  @override
  void initState() {
    _eventSubscription = context
        .read<AuthViewModel>()
        .eventStream
        .listen((event,) {
      if (event is NavigateToLogin && mounted) {
        Navigator.of(context).pushNamed(AppRoutes.loginView);
      }
      if (event is NavigateToSignup && mounted) {
        Navigator.of(context).pushNamed(AppRoutes.signupView);
      }
      if (event is ShowToast && mounted) {
        ShowToastMessage.show(context: context, message: event.message, isError: true);

      }
      if (event is NavigateToHome && mounted) {
        Navigator.of(context).pushNamed(AppRoutes.bottomNavigationView);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _eventSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: _contentBody(context),
      ),
    );
  }

  Widget _contentBody(BuildContext context) {
    final theme = context.appTheme;
    return SingleChildScrollView(
      child: Column(
        children: [
          VerticalSpace(107),
          Image.asset(AppAssets.ball),
          VerticalSpace(16),
          Text(
            "Welcome to",
            style: theme.regular18.copyWith(color: Color(0xFF5F5F5F)),
          ),
          VerticalSpace(16),
          Text(
            "Junior Football",
            style: theme.regular24.copyWith(fontSize: 32),
          ),
          SizedBox(child: Image.asset(AppAssets.player)),
          VerticalSpace(16),
          ElevatedButton(
            onPressed: () {
              context.read<AuthViewModel>().doIntent(NavigateToSignupIntent());
            },
            child: Text("Create New Account"),
          ),
          VerticalSpace(16),
          BlocBuilder<AuthViewModel, AuthState>(

            builder: (context, state) {
              if(state.googleState?.isLoading??false){
                return const Center(child: CircularProgressIndicator());
              }
              return LoginWithGoogleButton(
                onTap: () {
                  context.read<AuthViewModel>().doIntent(GoogleIntent());
                },
              );
            },
          ),
          VerticalSpace(16),
          CustomRichText(
            text1: "Already have an account? ",
            text2: "Login",
            onTap: () {
              context.read<AuthViewModel>().doIntent(NavigateToLoginIntent());
            },
          ),
          VerticalSpace(74),
        ],
      ),
    );
  }
}
