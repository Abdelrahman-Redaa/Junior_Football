import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:junior_football/core/common_widget/custom_text_form_field.dart';
import 'package:junior_football/core/utilities/show_toast_message.dart';
import 'package:junior_football/core/utilities/spaces.dart';
import 'package:junior_football/core/utilities/theme_extension.dart';
import 'package:junior_football/feature/profile/presentation/view_model/profile_state.dart';
import 'package:junior_football/feature/profile/presentation/view_model/profile_view_model.dart';

class ChangePasswordView extends StatefulWidget {
  const ChangePasswordView({super.key});

  @override
  State<ChangePasswordView> createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends State<ChangePasswordView> {
  final _formKey = GlobalKey<FormState>();
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      context.read<ProfileViewModel>().doIntent(
        ChangePasswordIntent(
          currentPassword: _currentPasswordController.text,
          newPassword: _newPasswordController.text,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('changePassword.title'.tr())),
      body: BlocConsumer<ProfileViewModel, ProfileState>(
        listenWhen: (prev, curr) =>
            prev.changePasswordState != curr.changePasswordState,
        listener: (context, state) {
          if (state.changePasswordState.isLoaded) {
            ShowToastMessage.show(
              context: context,
              message: 'changePassword.successMessage'.tr(),
              isError: false,
            );
            Navigator.pop(context);
          } else if (state.changePasswordState.isError) {
            ShowToastMessage.show(
              context: context,
              message:
                  state.changePasswordState.errorMessage ??
                  'changePassword.failureMessage'.tr(),
              isError: true,
            );
          }
        },
        builder: (context, state) {
          final isLoading = state.changePasswordState.isLoading;

          return Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Text(
                  'changePassword.subtitle'.tr(),
                  style: context.appTheme.semiBold24,
                ),
                VerticalSpace(8),
                Text(
                  'changePassword.description'.tr(),
                  style: context.appTheme.regular14.copyWith(
                    color: context.appTheme.subTitle,
                  ),
                ),
                VerticalSpace(24),
                CustomTextFormField(
                  controller: _currentPasswordController,
                  hintText: 'changePassword.currentPassword'.tr(),
                  isPassword: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'changePassword.enterCurrentPassword'.tr();
                    }
                    return null;
                  },
                ),
                VerticalSpace(16),
                CustomTextFormField(
                  controller: _newPasswordController,
                  hintText: 'changePassword.newPassword'.tr(),
                  isPassword: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'changePassword.enterNewPassword'.tr();
                    }
                    if (value.length < 6) {
                      return 'changePassword.minLength'.tr();
                    }
                    return null;
                  },
                ),
                VerticalSpace(16),
                CustomTextFormField(
                  controller: _confirmPasswordController,
                  hintText: 'changePassword.confirmPassword'.tr(),
                  isPassword: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'changePassword.confirmNewPassword'.tr();
                    }
                    if (value != _newPasswordController.text) {
                      return 'changePassword.passwordsNotMatch'.tr();
                    }
                    return null;
                  },
                ),
                VerticalSpace(32),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: isLoading ? null : _submit,
                    child: isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : Text('changePassword.savePassword'.tr()),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
