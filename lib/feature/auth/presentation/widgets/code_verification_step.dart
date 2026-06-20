import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:junior_football/core/utilities/spaces.dart';
import 'package:junior_football/core/utilities/theme_extension.dart';
import 'package:junior_football/feature/auth/presentation/view_model/auth_state.dart';
import 'package:junior_football/feature/auth/presentation/view_model/auth_view_model.dart';
import 'package:junior_football/feature/auth/presentation/widgets/custom_rich_text.dart';
import 'package:junior_football/feature/auth/presentation/widgets/password_recovery_controller.dart';

import '../../data/models/request_models/verify-otp_request.dart';
import 'otp_widget.dart';

class CodeVerificationStep extends StatefulWidget {
  const CodeVerificationStep({
    super.key,
    required this.passwordRecoveryController,
  });

  final PasswordRecoveryController passwordRecoveryController;

  @override
  State<CodeVerificationStep> createState() => _CodeVerificationStepState();
}

class _CodeVerificationStepState extends State<CodeVerificationStep> {
  @override
  Widget build(BuildContext context) {
    var theme = context.appTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text("OTP Verification", style: theme.semiBold28),
        VerticalSpace(8),
        Text(
          "Enter the verification code we just sent on your email address.",
          textAlign: TextAlign.center,
          style: theme.regular16.copyWith(color: theme.subTitle),
        ),
        VerticalSpace(48),
        _otp(),
        VerticalSpace(24),
        CustomRichText(
          text1: "Having Trouble? ",
          text2: " Resend Code",
          onTap: () {
            context.read<AuthViewModel>().doIntent(
              ReSendCodeIntent(user: context.read<AuthViewModel>().state.user!),
            );
          },
        ),
      ],
    );
  }

  Widget _otp() => BlocBuilder<AuthViewModel, AuthState>(
    builder: (context, state) {
      return OTPWidget(
        onCompleted: (pin) {
          final user = context.read<AuthViewModel>().state.user!;

          context.read<AuthViewModel>().doIntent(
            CodeVerificationIntent(
              user: VerifyOtpRequest(
                email: user.email,
                otp: pin,
              ),
            ),
          );
        },
        hasError: state.codeVerificationState!.isError,
        isLoading: state.codeVerificationState!.isLoading,
      );
    },
  );
}
