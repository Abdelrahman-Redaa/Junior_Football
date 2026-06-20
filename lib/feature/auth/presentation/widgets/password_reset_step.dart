import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:junior_football/core/common_widget/custom_text_form_field.dart';
import 'package:junior_football/core/utilities/spaces.dart';
import 'package:junior_football/core/utilities/theme_extension.dart';
import 'package:junior_football/feature/auth/presentation/view_model/auth_state.dart';
import 'package:junior_football/feature/auth/presentation/view_model/auth_view_model.dart';
import 'package:junior_football/feature/auth/presentation/widgets/password_recovery_controller.dart';

class PasswordResetStep extends StatefulWidget {
  const PasswordResetStep({
    super.key,
    required this.passwordRecoveryController,
  });

  final PasswordRecoveryController passwordRecoveryController;

  @override
  State<PasswordResetStep> createState() => _PasswordResetStepState();
}

class _PasswordResetStepState extends State<PasswordResetStep> {
  @override
  Widget build(BuildContext context) {
    var theme = context.appTheme;
    return Form(
      key: widget.passwordRecoveryController.confirmPasswordFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Create new password", style: theme.semiBold28),
          VerticalSpace(8),
          Text(
            "Your new password must be unique from those previously used.",
            textAlign: TextAlign.start,
            style: theme.regular16.copyWith(color: theme.subTitle),
          ),
          VerticalSpace(30),
          _confirmPasswordField(),
          VerticalSpace(22),
          _confirmButton(),
        ],
      ),
    );
  }

  Widget _confirmPasswordField() => CustomTextFormField(
    controller: widget.passwordRecoveryController.newPasswordController,
    hintText: "Confirm Password",
  );

  Widget _confirmButton() => BlocBuilder<AuthViewModel, AuthState>(
    builder: (context, state) {
      return ElevatedButton(
        onPressed: _resetPasswordClicked,
        child: Text("Reset Password"),
      );
    },
  );

  void _resetPasswordClicked() {
    if (widget.passwordRecoveryController.confirmPasswordFormKey.currentState!
        .validate()) {
      String newPassword = widget.passwordRecoveryController
          .newPasswordController
          .text
          .trim();
      var user = context.read<AuthViewModel>().state.user!.copyWith(
        password: newPassword,
      );
      context.read<AuthViewModel>().doIntent(ConfirmPasswordIntent(user: user));
    }
  }
}
