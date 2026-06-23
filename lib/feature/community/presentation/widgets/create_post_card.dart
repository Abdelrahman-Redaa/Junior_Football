import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:junior_football/core/utilities/theme_extension.dart';
import 'package:junior_football/feature/community/presentation/view_model/community_state.dart';
import 'package:junior_football/feature/community/presentation/view_model/community_view_model.dart';

class CreatePostCard extends StatefulWidget {
  const CreatePostCard({super.key});

  @override
  State<CreatePostCard> createState() => _CreatePostCardState();
}

class _CreatePostCardState extends State<CreatePostCard> {
  final TextEditingController _contentController = TextEditingController();
  File? _selectedFile;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null && mounted) {
      setState(() => _selectedFile = File(image.path));
    }
  }

  void _submitPost() {
    final text = _contentController.text.trim();
    if (text.isEmpty && _selectedFile == null) return;
    context.read<CommunityViewModel>().doIntent(
          CreatePostIntent(file: _selectedFile ?? File(''), content: text),
        );
  }

  void resetForm() {
    if (!mounted) return;
    _contentController.clear();
    setState(() => _selectedFile = null);
    FocusScope.of(context).unfocus();
  }

  @override
  void dispose() {
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;

    return BlocListener<CommunityViewModel, CommunityState>(
      listenWhen: (p, c) =>
          p.createPostState != c.createPostState &&
          c.createPostState.isLoaded,
      listener: (_, __) => resetForm(),
      child: Material(
        color: theme.secondary,
        borderRadius: BorderRadius.circular(16.r),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: theme.borderColor),
          ),
          padding: EdgeInsets.all(14.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Input row
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 20.r,
                    backgroundColor: theme.primary.withValues(alpha: 0.15),
                    child: Icon(Icons.person_rounded,
                        color: theme.primary, size: 22.r),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: TextField(
                      controller: _contentController,
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      style:
                          TextStyle(fontSize: 14.sp, color: theme.textColor),
                      decoration: InputDecoration(
                        hintText: 'createPost.whatsOnYourMind'.tr(),
                        hintStyle: TextStyle(
                          color: theme.subTitle.withValues(alpha: 0.6),
                          fontSize: 14.sp,
                        ),
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.only(top: 4.h),
                      ),
                    ),
                  ),
                ],
              ),

              // Image preview
              if (_selectedFile != null) ...[
                SizedBox(height: 10.h),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.r),
                  child: Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Image.file(
                        _selectedFile!,
                        height: 160.h,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                      Padding(
                        padding: EdgeInsets.all(6.r),
                        child: GestureDetector(
                          onTap: () =>
                              setState(() => _selectedFile = null),
                          child: CircleAvatar(
                            radius: 14.r,
                            backgroundColor: Colors.black54,
                            child: Icon(Icons.close,
                                color: Colors.white, size: 14.r),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],

              SizedBox(height: 10.h),
              Divider(color: theme.borderColor, height: 1),
              SizedBox(height: 6.h),

              // Action row
              Row(
                children: [
                  // Photo picker
                  GestureDetector(
                    onTap: _pickImage,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 4.w, vertical: 6.h),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.image_outlined,
                              color: Colors.green.shade500, size: 22.r),
                          SizedBox(width: 6.w),
                          Text(
                            _selectedFile == null
                                ? 'createPost.photo'.tr()
                                : 'createPost.change'.tr(),
                            style: TextStyle(
                              color: theme.subTitle,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const Spacer(),

                  // Post button
                  BlocBuilder<CommunityViewModel, CommunityState>(
                    buildWhen: (p, c) =>
                        p.createPostState.isLoading !=
                        c.createPostState.isLoading,
                    builder: (context, state) {
                      final isLoading = state.createPostState.isLoading;
                      return FilledButton(
                        onPressed: isLoading ? null : _submitPost,
                        style: FilledButton.styleFrom(
                          backgroundColor: theme.primary,
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.w, vertical: 10.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                        ),
                        child: isLoading
                            ? SizedBox(
                                width: 16.r,
                                height: 16.r,
                                child: const CircularProgressIndicator(
                                    strokeWidth: 2, color: Colors.white),
                              )
                            : Text(
                                'createPost.post'.tr(),
                                style: TextStyle(
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
