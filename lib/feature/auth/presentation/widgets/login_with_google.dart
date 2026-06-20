import 'package:flutter/material.dart';
import 'package:junior_football/core/constants/app_assets.dart';

class LoginWithGoogleButton extends StatelessWidget {
  const LoginWithGoogleButton({super.key, this.onTap});

  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 10,
        children: [
          Image.asset(AppAssets.googleLogo),
          Text("Continue with Google"),
        ],
      ),
    );
  }
}
