import 'package:flutter/material.dart';
import 'package:junior_football/core/common_widget/custom_text_form_field.dart';
import 'package:junior_football/core/constants/app_assets.dart';
import 'package:junior_football/core/utilities/custom_menu.dart';
import 'package:junior_football/core/utilities/data_time_extension.dart';
import 'package:junior_football/core/utilities/spaces.dart';
import 'package:junior_football/core/utilities/theme_extension.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key});

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  late final TextEditingController _yearOfBirthController;
  late final ValueNotifier _selectedDataTime = ValueNotifier<String>(
    DateTime.now().formatDataTime(),
  );

  @override
  void initState() {
    _yearOfBirthController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _yearOfBirthController
      ..clear()
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Your Profile"),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.settings_outlined)),
        ],
      ),
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
              _buildTextTitle("Name"),
              CustomTextFormField(hintText: "Enter Your Name"),
              VerticalSpace(16),
              _buildTextTitle("Phone Number"),
              CustomTextFormField(hintText: "Enter Your Phone Number"),
              VerticalSpace(16),
              _buildTextTitle("Email"),
              CustomTextFormField(hintText: "Enter Your Email"),
              VerticalSpace(16),
              _buildTextTitle("Date Of Birth"),
              _buildBirthDay(context),
              VerticalSpace(16),
              _buildTextTitle("Select Your Strength"),
              CustomMenu(
                hintText: "All",
                onChange: (value) {},
                items: ["Arb", "Eng"],
              ),
              VerticalSpace(16),
              _buildTextTitle("Select Your Weakness"),
              CustomMenu(
                hintText: "All",
                onChange: (value) {},
                items: ["Arb", "Eng"],
              ),
              VerticalSpace(65),
              ElevatedButton(onPressed: () {}, child: Text("Update Profile")),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextTitle(String title) {
    return Text(title, style: context.appTheme.semiBold24);
  }

  Widget _buildBirthDay(BuildContext context) {
    return CustomTextFormField(
      hintText: 'year of birth',
      controller: _yearOfBirthController,
      readOnly: true,
      onTap: () {
        showDatePicker(
          context: context,
          firstDate: DateTime(1960),
          lastDate: DateTime.now(),
        ).then(
          (dataTime) => {
            _selectedDataTime.value = dataTime?.formatDataTime(),
            _yearOfBirthController.text = _selectedDataTime.value,
          },
        );
      },
    );
  }

  Widget _buildProfileImage(BuildContext context) {
    final theme = context.appTheme;
    return Stack(
      clipBehavior: Clip.none,
      children: [
        CircleAvatar(
          backgroundImage: AssetImage(AppAssets.profile),
          radius: 50,
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
    );
  }
}
