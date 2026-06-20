import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:junior_football/core/routes/routes_name.dart';
import 'package:junior_football/core/utilities/show_toast_message.dart';
import 'package:junior_football/feature/auth/presentation/view_model/auth_state.dart';
import 'package:junior_football/feature/auth/presentation/view_model/auth_view_model.dart';
import 'package:junior_football/feature/auth/presentation/widgets/code_verification_step.dart';
import 'package:junior_football/feature/auth/presentation/widgets/email_verification_step.dart';
import 'package:junior_football/feature/auth/presentation/widgets/password_recovery_controller.dart';
import 'package:junior_football/feature/auth/presentation/widgets/password_reset_step.dart';

class ForgetPasswordView extends StatefulWidget {
  const ForgetPasswordView({super.key});

  @override
  State<ForgetPasswordView> createState() => _ForgetPasswordViewState();
}

class _ForgetPasswordViewState extends State<ForgetPasswordView> {
  late final PasswordRecoveryController passwordRecoveryController;

  List<Widget> get pages => [
    EmailVerificationStep(
      passwordRecoveryController: passwordRecoveryController,
    ),
    CodeVerificationStep(
      passwordRecoveryController: passwordRecoveryController,
    ),
    PasswordResetStep(passwordRecoveryController: passwordRecoveryController),
  ];

  late final StreamSubscription _streamEvent;

  @override
  void initState() {
    super.initState();
    passwordRecoveryController = PasswordRecoveryController();
    _streamEvent = context.read<AuthViewModel>().eventStream.listen((event) {
      if (event is SendCodeEvent) {
        passwordRecoveryController.pageController.nextPage(
          duration: Duration(milliseconds: 300),
          curve: Curves.ease,
        );
      }
      if (event is ReSendCodeEvent && mounted) {
        ShowToastMessage.show(
          context: context,
          message: "Code sent successfully",
        );
      }
      if (event is ConfirmEmailEvent) {
        passwordRecoveryController.pageController.nextPage(
          duration: Duration(milliseconds: 300),
          curve: Curves.ease,
        );
      }
      if (event is ShowToastInForgetPassword && mounted) {
        ShowToastMessage.show(
          context: context,
          message: event.message,
          isError: true,
        );
      }
      if (event is ConfirmPasswordEvent && mounted) {
        Navigator.of(context).pushReplacementNamed(AppRoutes.loginView);
      }
    });
  }

  @override
  void dispose() {
    _streamEvent.cancel();
    passwordRecoveryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            if (passwordRecoveryController.pageController.page != 0) {
              passwordRecoveryController.goToInitialPage();
              return;
            }
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 31),
          child: PopScope(
            canPop: false,
            onPopInvokedWithResult: (didPop, result) {
              // final controller = passwordRecoveryController.pageController;
              //
              // if (!controller.hasClients) return;
              //
              // final currentPage = controller.page?.round() ?? 0;
              //
              // if (currentPage == 0 || currentPage == 2) {
              //   Navigator.of(context).pop();
              // }
              // if (currentPage == 1) {
              //   passwordRecoveryController.previousPage();
              // }
            },
            child: PageView(
              controller: passwordRecoveryController.pageController,
              // physics: NeverScrollableScrollPhysics(),
              children: pages,
            ),
          ),
        ),
      ),
    );
  }
}
