import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:junior_football/core/common_widget/custom_text_form_field.dart';
import 'package:junior_football/core/constants/app_assets.dart';
import 'package:junior_football/core/utilities/show_toast_message.dart';
import 'package:junior_football/core/utilities/spaces.dart';
import 'package:junior_football/core/utilities/theme_extension.dart';
import 'package:junior_football/feature/profile/domain/entities/user_profile_entity.dart';
import 'package:junior_football/feature/profile/presentation/view_model/profile_state.dart';
import 'package:junior_football/feature/profile/presentation/view_model/profile_view_model.dart';

class EditProfileView extends StatefulWidget {
  final UserProfileEntity? initialProfile;
  const EditProfileView({super.key, this.initialProfile});

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  late final TextEditingController _bioController;
  late final TextEditingController _phoneController;
  late final TextEditingController _heightController;
  late final TextEditingController _weightController;
  late final TextEditingController _teamController;

  String? _preferredFoot;
  UserProfileEntity? _profile;
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _bioController = TextEditingController();
    _phoneController = TextEditingController();
    _heightController = TextEditingController();
    _weightController = TextEditingController();
    _teamController = TextEditingController();

    // Load profile data from constructor argument
    final profile = widget.initialProfile;
    if (profile != null) {
      _profile = profile;
      _bioController.text = profile.bio ?? '';
      _phoneController.text = profile.phoneNumber ?? '';
      _heightController.text = profile.height?.toString() ?? '';
      _weightController.text = profile.weight?.toString() ?? '';
      _teamController.text = profile.team ?? '';

      final rawFoot = profile.preferredFoot;
      if (rawFoot != null && rawFoot.isNotEmpty) {
        final formattedFoot =
            rawFoot[0].toUpperCase() + rawFoot.substring(1).toLowerCase();
        if (['Right', 'Left', 'Both'].contains(formattedFoot)) {
          _preferredFoot = formattedFoot;
        } else {
          _preferredFoot = null;
        }
      } else {
        _preferredFoot = null;
      }
    }
  }

  @override
  void dispose() {
    _bioController.dispose();
    _phoneController.dispose();
    _heightController.dispose();
    _weightController.dispose();
    _teamController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('editProfile.title'.tr())),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.center,
                child: _buildProfileImage(context),
              ),
              VerticalSpace(16),
              _buildTextTitle("Bio"),
              CustomTextFormField(
                controller: _bioController,
                hintText: "Enter Your Bio",
              ),
              VerticalSpace(16),
              _buildTextTitle("Phone Number"),
              CustomTextFormField(
                controller: _phoneController,
                hintText: "Enter Your Phone Number",
                keyboardType: TextInputType.phone,
              ),
              VerticalSpace(16),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildTextTitle("Height (cm)"),
                        CustomTextFormField(
                          controller: _heightController,
                          hintText: "E.g. 180",
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildTextTitle("Weight (kg)"),
                        CustomTextFormField(
                          controller: _weightController,
                          hintText: "E.g. 75",
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              VerticalSpace(16),
              _buildTextTitle("Preferred Foot"),
              DropdownButtonFormField<String>(
                value: _preferredFoot,
                decoration: const InputDecoration(
                  hintText: 'Select Preferred Foot',
                ),
                items: const ['Right', 'Left', 'Both']
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (value) {
                  setState(() => _preferredFoot = value);
                },
              ),
              VerticalSpace(16),
              _buildTextTitle("Team"),
              CustomTextFormField(
                controller: _teamController,
                hintText: "Enter Your Team Name",
              ),
              VerticalSpace(65),
              SizedBox(
                width: double.infinity,
                child: BlocConsumer<ProfileViewModel, ProfileState>(
                  listenWhen: (prev, curr) =>
                      prev.updateProfileState != curr.updateProfileState,
                  listener: (context, state) {
                    if (state.updateProfileState.isLoaded) {
                      ShowToastMessage.show(
                        context: context,
                        message: 'Profile Updated Successfully',
                        isError: false,
                      );
                      Navigator.pop(context);
                    }
                    if (state.updateProfileState.isError) {
                      ShowToastMessage.show(
                        context: context,
                        message:
                            state.updateProfileState.errorMessage ??
                            'Update failed',
                        isError: true,
                      );
                    }
                  },
                  builder: (context, state) {
                    final isLoading = state.updateProfileState.isLoading;
                    return ElevatedButton(
                      onPressed: isLoading
                          ? null
                          : () {
                              if (_profile != null) {
                                final updatedProfile = _profile!.copyWith(
                                  bio: _bioController.text.isEmpty
                                      ? null
                                      : _bioController.text,
                                  height: double.tryParse(
                                    _heightController.text,
                                  ),
                                  weight: double.tryParse(
                                    _weightController.text,
                                  ),
                                  preferredFoot: _preferredFoot,
                                  team: _teamController.text.isEmpty
                                      ? null
                                      : _teamController.text,
                                );
                                context.read<ProfileViewModel>().doIntent(
                                  UpdateProfileIntent(
                                    updatedProfile: updatedProfile,
                                    profileImageFile: _selectedImage,
                                  ),
                                );
                              }
                            },
                      child: isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : Text('editProfile.updateProfile'.tr()),
                    );
                  },
                ),
              ),
              VerticalSpace(32),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
      });
    }
  }

  Widget _buildTextTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(title, style: context.appTheme.semiBold24),
    );
  }

  Widget _buildProfileImage(BuildContext context) {
    final theme = context.appTheme;
    Widget imageWidget;
    if (_selectedImage != null) {
      imageWidget = Image.file(_selectedImage!, fit: BoxFit.cover);
    } else if (_profile?.profileImageUrl != null &&
        _profile!.profileImageUrl!.isNotEmpty) {
      imageWidget = Image.network(
        _profile!.profileImageUrl!,
        fit: BoxFit.cover,
      );
    } else {
      imageWidget = Image.asset(AppAssets.profile, fit: BoxFit.cover);
    }

    return GestureDetector(
      onTap: _pickImage,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: theme.primary.withValues(alpha: 0.12),
            ),
            clipBehavior: Clip.antiAlias,
            child: imageWidget,
          ),
          Positioned(
            bottom: -5,
            right: -15,
            child: CircleAvatar(
              radius: 20,
              backgroundColor: theme.secondary,
              child: Icon(Icons.edit_outlined, color: theme.surface),
            ),
          ),
        ],
      ),
    );
  }
}
