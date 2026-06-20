import 'package:flutter/material.dart';

class PasswordRecoveryController {
  PageController pageController;
  TextEditingController emailController;
  TextEditingController newPasswordController;
  TextEditingController confirmPasswordController;
  GlobalKey<FormState> emailFormKey;
  GlobalKey<FormState> confirmPasswordFormKey;

  PasswordRecoveryController()
    : pageController = PageController(initialPage: 0),
      emailController = TextEditingController(),
      newPasswordController = TextEditingController(),
      emailFormKey = GlobalKey<FormState>(),
      confirmPasswordController = TextEditingController(),
      confirmPasswordFormKey = GlobalKey<FormState>();

  void dispose() {
    pageController.dispose();
    emailController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
  }

  void nextPage() {
    pageController.nextPage(
      duration: const Duration(milliseconds: 100),
      curve: Curves.easeInOut,
    );
  }

  void goToInitialPage() {
    pageController.jumpToPage(0);
  }

  void previousPage() {
    pageController.previousPage(
      duration: const Duration(milliseconds: 100),
      curve: Curves.easeInOut,
    );
  }
}
