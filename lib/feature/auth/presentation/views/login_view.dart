import 'dart:async';

import 'package:flutter/material.dart';
import 'package:junior_football/core/common_widget/custom_text_form_field.dart';
import 'package:junior_football/core/di/di.dart';
import 'package:junior_football/core/routes/routes_name.dart';
import 'package:junior_football/core/utilities/show_toast_message.dart';
import 'package:junior_football/core/utilities/spaces.dart';
import 'package:junior_football/core/utilities/theme_extension.dart';
import 'package:junior_football/feature/auth/presentation/view_model/auth_state.dart';
import 'package:junior_football/feature/auth/presentation/view_model/auth_view_model.dart';
import 'package:junior_football/feature/auth/presentation/widgets/custom_rich_text.dart';
import 'package:junior_football/feature/auth/presentation/widgets/login_with_google.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final GlobalKey<FormState> _formKey;
  late StreamSubscription _eventStream;
  late AuthViewModel _viewModel;

  @override
  void initState() {
    initView();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Login", style: theme.semiBold28),
                VerticalSpace(8),
                Text(
                  "Enter your credentials to start journey!",
                  style: theme.regular16.copyWith(color: theme.subTitle),
                ),
                VerticalSpace(47),
                CustomTextFormField(
                  controller: _emailController,
                  hintText: "Enter your email",
                ),
                VerticalSpace(16),
                CustomTextFormField(
                  controller: _passwordController,
                  hintText: "Enter your password",
                  isPassword: true,
                ),
                VerticalSpace(12),
                Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    child: Text(
                      "Forget password?",
                      style: theme.regular14.copyWith(color: theme.subTitle),
                    ),
                    onTap: () {
                      _viewModel.doIntent(NavigateToForgetPasswordIntent());
                    },
                  ),
                ),
                VerticalSpace(22),
                ElevatedButton(
                  onPressed: _loginBtnPressed,
                  child: Text("Login"),
                ),
                VerticalSpace(16),
                OrDivider(),
                VerticalSpace(16),
                LoginWithGoogleButton(
                  onTap: () {
                    _viewModel.doIntent(GoogleIntent());
                  },
                ),
                VerticalSpace(171),
                Center(
                  child: CustomRichText(
                    onTap: () => _viewModel.doIntent(NavigateToSignupIntent()),
                    text1: 'Don’t have an account?',
                    text2: 'Register Now',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _loginBtnPressed() {
    if (_formKey.currentState!.validate()) {
      final email = _emailController.text.trim();
      final password = _passwordController.text.trim();
      _viewModel.doIntent(LoginIntent(email, password));
    }
  }

  void initView() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _formKey = GlobalKey<FormState>();
    _viewModel = getIt.get<AuthViewModel>();
    _eventStream = _viewModel.eventStream.listen((event) {
      if (event is ShowToast && mounted) {
        ShowToastMessage.show(
          context: context,
          message: event.message,
          isError: true,
        );
      }
      if (event is NavigateToHome && mounted) {
        Navigator.of(
          context,
        ).pushNamedAndRemoveUntil(AppRoutes.bottomNavigationView, (route) => false);
      }
      if (event is NavigateToSignup && mounted) {
        Navigator.of(context).pushNamed(AppRoutes.signupView);
      }
      if (event is NavigateToForgetPassword && mounted) {
        Navigator.of(context).pushNamed(AppRoutes.forgetPasswordView);
      }
    });
  }

  @override
  void dispose() {
    _emailController
      ..clear()
      ..dispose();
    _passwordController
      ..clear()
      ..dispose();
    _eventStream.cancel();
    super.dispose();
  }
}

class OrDivider extends StatelessWidget {
  const OrDivider({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return Row(
      spacing: 16,
      children: [
        _dividerLine(theme),
        Text(
          "or",
          style: theme.regular14.copyWith(fontSize: 12, color: theme.subTitle),
        ),
        _dividerLine(theme),
      ],
    );
  }

  Widget _dividerLine(dynamic theme) {
    return Expanded(
      child: Divider(color: theme.borderColor, thickness: 2),
    );
  }
}
