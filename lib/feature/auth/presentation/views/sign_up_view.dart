import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:junior_football/core/common_widget/custom_text_form_field.dart';
import 'package:junior_football/core/di/di.dart';
import 'package:junior_football/core/routes/routes_name.dart';
import 'package:junior_football/core/utilities/data_time_extension.dart';
import 'package:junior_football/core/utilities/show_toast_message.dart';
import 'package:junior_football/core/utilities/spaces.dart';
import 'package:junior_football/core/utilities/theme_extension.dart';
import 'package:junior_football/feature/auth/data/models/request_models/sign_up_request_dto.dart';
import 'package:junior_football/feature/auth/presentation/view_model/auth_state.dart';
import 'package:junior_football/feature/auth/presentation/view_model/auth_view_model.dart';
import 'package:junior_football/core/utilities/custom_menu.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  late final TextEditingController _fullNameController;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _yearOfBirthController;
  late final GlobalKey<FormState> _formKey;
  late final ValueNotifier<String> _selectedCountry = ValueNotifier<String>(
    'Egypt',
  );
  late final ValueNotifier<int> _selectedPosition = ValueNotifier<int>(0);
  late final ValueNotifier _selectedDataTime = ValueNotifier<String>(
    DateTime.now().formatDataTime(),
  );

  late StreamSubscription _eventStream;
  late AuthViewModel _viewModel;
  final List<String> positions = [
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
    "10",
    "11",
  ];
  @override
  void initState() {
    _passwordController = TextEditingController();
    _fullNameController = TextEditingController();
    _yearOfBirthController = TextEditingController();
    _emailController = TextEditingController();
    _formKey = GlobalKey<FormState>();
    _viewModel = getIt.get<AuthViewModel>();
    _eventStream = _viewModel.eventStream.listen((event) {
      if (event is NavigateToLogin && mounted) {
        Navigator.of(
          context,
        ).pushNamedAndRemoveUntil(AppRoutes.loginView, (route) => false);
      }
      if (event is NavigateToPermission && mounted) {
        Navigator.of(
          context,
        ).pushNamed(AppRoutes.permissionView);
      }
      if (event is ShowToast && mounted) {
        ShowToastMessage.show(
          context: context,
          message: event.message,
          isError: true,
        );
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _eventStream.cancel();
    _selectedCountry.dispose();
    _selectedPosition.dispose();
    _emailController.dispose();
    _passwordController
      ..clear()
      ..dispose();
    _fullNameController
      ..clear()
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;

    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent),
      bottomNavigationBar: _termsAndConditions(context),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('auth.signup'.tr(), style: theme.semiBold28),
                VerticalSpace(8),
                Text(
                  'auth.fillDetails'.tr(),
                  style: theme.regular16.copyWith(color: theme.subTitle),
                ),
                VerticalSpace(47),
                CustomTextFormField(
                  controller: _fullNameController,
                  hintText: 'auth.fullName'.tr(),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'auth.enterFullName'.tr();
                    }
                    return null;
                  },
                ),
                VerticalSpace(16),
                CustomTextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'auth.enterEmail'.tr();
                    }
                    return null;
                  },
                  controller: _emailController,
                  hintText: 'auth.email'.tr(),
                ),
                VerticalSpace(16),
                CustomTextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'auth.enterYearOfBirth'.tr();
                    }
                    return null;
                  },
                  hintText: 'auth.yearOfBirth'.tr(),
                  controller: _yearOfBirthController,
                  readOnly: true,
                  onTap: () {
                    showDatePicker(
                      context: context,
                      firstDate: DateTime(1960),
                      lastDate: DateTime.now(),
                    ).then(
                      (dataTime) => {
                        _selectedDataTime.value = dataTime
                            ?.toUtc()
                            .toIso8601String(),
                        _yearOfBirthController.text = _selectedDataTime.value,
                      },
                    );
                  },
                ),
                VerticalSpace(16),
                CustomMenu(
                  onChange: (selectCountry) {
                    _selectedCountry.value = selectCountry!;
                  },
                  hintText: 'auth.country'.tr(),
                  items: ["Egypt", "Syria", "Palestine"],
                ),

                VerticalSpace(16),

                CustomMenu<String>(
                  onChange: (selectedPosition) {
                    _selectedPosition.value = int.parse(selectedPosition!);
                  },
                  items: positions,
                  itemBuilder: (value) => value,
                  hintText: 'auth.playingPosition'.tr(),
                ),
                VerticalSpace(16),
                CustomTextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'auth.enterPassword'.tr();
                    }
                    return null;
                  },
                  controller: _passwordController,
                  hintText: 'auth.password'.tr(),
                  isPassword: true,
                ),
                VerticalSpace(44),
                BlocBuilder<AuthViewModel, AuthState>(
                  bloc: 
                  _viewModel,
                  builder: (context, state) {
                    if(state.signupState?.isLoading == true){
                      return const Center(child: CircularProgressIndicator());
                    }
                    return ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          final country = _selectedCountry.value;
                          final position = _selectedPosition.value;
                          final email = _emailController.text.trim();
                          final fullName = _fullNameController.text.trim();
                          final yearOfBirth = _yearOfBirthController.text
                              .trim();
                          final password = _passwordController.text.trim();
                          final SignupRequestDto signupModel = SignupRequestDto(
                            country: country,
                            email: email,
                            playingPosition: position,
                            fullName: fullName,
                            dateOfBirth: yearOfBirth,
                            password: password,
                          );
                          _viewModel.doIntent(SignupIntent(signupModel));
                        }
                      },
                      child: Text('auth.signupBtn'.tr()),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _termsAndConditions(BuildContext context) {
    final theme = context.appTheme;
    return Padding(
      padding: EdgeInsets.only(bottom: 25.h),
      child: RichText(
        maxLines: 3,
        textAlign: TextAlign.center,
        text: TextSpan(
          children: [
            TextSpan(
              text: 'auth.termsPrefix'.tr(),
              style: theme.regular14.copyWith(color: theme.subTitle),
            ),
            TextSpan(
              text: 'auth.termsLink'.tr(),
              style: theme.medium14.copyWith(color: theme.primary),
            ),
            TextSpan(
              text: 'auth.policy'.tr(),
              style: theme.medium14.copyWith(color: theme.primary),
            ),
            TextSpan(
              text: 'auth.and'.tr(),
              style: theme.regular14.copyWith(color: theme.subTitle),
            ),
            TextSpan(
              text: 'auth.cookieUse'.tr(),
              style: theme.medium14.copyWith(color: theme.primary),
            ),
          ],
        ),
      ),
    );
  }
}
