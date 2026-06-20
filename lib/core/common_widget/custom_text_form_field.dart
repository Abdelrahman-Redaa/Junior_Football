import 'package:flutter/material.dart';
import 'package:junior_football/core/utilities/theme_extension.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    super.key,
    this.hintText,
    this.hintStyle,
    this.keyboardType,
    this.isPassword = false,
    this.obscuringCharacter = '*',
    this.validator,
    this.readOnly = false,
    this.onTap,
    this.controller,
    this.initialValue,
  });

  final String? hintText;
  final TextStyle? hintStyle;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final String obscuringCharacter;
  final bool isPassword;
  final bool readOnly;
  final String? initialValue;
  final void Function()? onTap;
  final TextEditingController? controller;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  final ValueNotifier<bool> visible = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return ValueListenableBuilder(
      valueListenable: visible,
      builder: (context, value, child) {
        return TextFormField(
          initialValue: widget.initialValue,
          readOnly: widget.readOnly,
          onTap: widget.onTap,
          controller: widget.controller,
          validator: widget.validator,
          obscureText: widget.isPassword ? !value : false,
          onTapUpOutside: (event) => FocusScope.of(context).unfocus(),
          style: theme.regular14,
          obscuringCharacter: widget.obscuringCharacter,
          keyboardType: widget.keyboardType,
          decoration: InputDecoration(
            suffixIcon: widget.isPassword
                ? IconButton(
                    onPressed: () {
                      visible.value = !visible.value;
                    },
                    icon: Icon(
                      value ? Icons.visibility : Icons.visibility_off,
                      color: theme.grey,
                    ),
                  )
                : null,
            hintText: widget.hintText,
            hintStyle:
                widget.hintStyle ??
                theme.medium14.copyWith(color: theme.neutral),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    visible.dispose();
    super.dispose();
  }
}
