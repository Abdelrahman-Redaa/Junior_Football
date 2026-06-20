import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:junior_football/core/common_widget/custom_text_form_field.dart';
import 'package:junior_football/core/utilities/spaces.dart';
import 'package:junior_football/core/utilities/theme_extension.dart';
import 'package:junior_football/feature/auth/domain/entities/forget_password_entity.dart';
import 'package:junior_football/feature/auth/presentation/view_model/auth_state.dart';
import 'package:junior_football/feature/auth/presentation/view_model/auth_view_model.dart';
import 'package:junior_football/feature/auth/presentation/widgets/password_recovery_controller.dart';

class EmailVerificationStep extends StatefulWidget {
  const EmailVerificationStep({
    super.key,
    required this.passwordRecoveryController,
  });

  final PasswordRecoveryController passwordRecoveryController;

  @override
  State<EmailVerificationStep> createState() => _EmailVerificationStepState();
}

class _EmailVerificationStepState extends State<EmailVerificationStep> {
  @override
  Widget build(BuildContext context) {
    var theme = context.appTheme;
    return Form(
      key: widget.passwordRecoveryController.emailFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Forget password", style: theme.semiBold28),
          VerticalSpace(8),
          Text(
            "Enter your email address to continue",
            style: theme.regular16.copyWith(color: theme.subTitle),
          ),
          VerticalSpace(32),
          _emailField(),
          VerticalSpace(48),
          _confirmButton(),
        ],
      ),
    );
  }

  Widget _emailField() => CustomTextFormField(
    controller: widget.passwordRecoveryController.emailController,
    hintText: "Enter your Email",
  );

  Widget _confirmButton() =>
      ElevatedButton(onPressed: _confirmClicked, child: Text("Reset Password"));

  void _confirmClicked() {
    if (widget.passwordRecoveryController.emailFormKey.currentState!
        .validate()) {
      String email = widget.passwordRecoveryController.emailController.text
          .trim();
      UserOTPEntity user = context.read<AuthViewModel>().state.user!.copyWith(
        email: email,
      );
      context.read<AuthViewModel>().doIntent(
        EmailVerificationIntent(user: user),
      );
    }
  }
}
