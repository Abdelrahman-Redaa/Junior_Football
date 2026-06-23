import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:junior_football/core/di/di.dart';
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
    if (image != null) {
      setState(() {
        _selectedFile = File(image.path);
      });
    }
  }

  @override
  void dispose() {
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return BlocProvider(
      create: (context) =>  getIt<CommunityViewModel>(),
      child: Card(
        elevation: 0,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
          side: BorderSide(color: Colors.grey.shade200, width: 1),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Section: Avatar & Input Field
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 20.r,
                    backgroundColor: theme.primary.withValues(alpha: 0.2),
                    child: Icon(
                      Icons.person_rounded,
                      color: theme.primary,
                      size: 22.r,
                    ),
                  ),
                  SizedBox(width: 24.w),
                  Expanded(
                    child: TextField(
                      controller: _contentController,
                      maxLines: null,
                      minLines: 1,
                      keyboardType: TextInputType.multiline,
                      textInputAction: TextInputAction.newline,
                      style: TextStyle(fontSize: 15.sp, color: Colors.black87),
                      decoration: InputDecoration(
                        hintText: "createPost.whatsOnYourMind".tr(),
                        hintStyle: TextStyle(
                          color: Colors.grey.shade400,
                          fontSize: 15.sp,
                        ),
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.only(top: 8.h),
                      ),
                    ),
                  ),
                ],
              ),

              // Middle Section: Optional Image Preview Window
              if (_selectedFile != null) ...[
                SizedBox(height: 16.h),
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12.r),
                      child: Image.file(
                        _selectedFile!,
                        height: 180.h,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      top: 8.h,
                      right: 8.w,
                      child: GestureDetector(
                        onTap: () => setState(() => _selectedFile = null),
                        child: Container(
                          padding: EdgeInsets.all(6.r),
                          decoration: BoxDecoration(
                            color: Colors.black,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.close_rounded,
                            color: Colors.white,
                            size: 16.r,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],

              SizedBox(height: 12.h),
              Divider(color: Colors.grey.shade100, thickness: 1.h),
              SizedBox(height: 8.h),

              // Bottom Section: Action Bars (Add Media & Post Button)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Media Picker Button
                  InkWell(
                    onTap: _pickImage,
                    borderRadius: BorderRadius.circular(8.r),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 6.h,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.image_rounded,
                            color: Colors.green.shade400,
                            size: 20.r,
                          ),
                          SizedBox(width: 6.w),
                          Text(
                            _selectedFile == null ? "createPost.photo".tr() : "createPost.change".tr(),
                            style: TextStyle(
                              color: Colors.grey.shade700,
                              fontWeight: FontWeight.w500,
                              fontSize: 14.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Submit Button
                  Expanded(
                    child: BlocBuilder<CommunityViewModel, CommunityState>(
                      builder: (context, state) {
                        return ElevatedButton(
                          onPressed: () {

                            final text = _contentController.text.trim();
                            if (text.isNotEmpty || _selectedFile != null) {
                              //widget.onCreatePost(_selectedFile, text);

  context.read<CommunityViewModel>().doIntent(
                  CreatePostIntent(file: _selectedFile!, content: text));

                            }
                            //   // Reset State after dispatching
                            //   _contentController.clear();
                            //   setState(() => _selectedFile = null);
                            //   FocusScope.of(
                            //     context,
                            //   ).unfocus(); // Close keyboard safely
                            // }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: theme.primary,
                            foregroundColor: Colors.white,
                            elevation: 0,
                            padding: EdgeInsets.symmetric(
                              horizontal: 20.w,
                              vertical: 10.h,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24.r),
                            ),
                          ),
                          child: state.commentPostState.isLoading
                              ? CircularProgressIndicator()
                              : Text(
                                  "createPost.post".tr(),
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        );
                      },
                    ),
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
