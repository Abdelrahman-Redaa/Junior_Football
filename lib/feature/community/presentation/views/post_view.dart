import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:junior_football/core/di/di.dart';
import 'package:junior_football/feature/community/presentation/view_model/community_state.dart';
import 'package:junior_football/feature/community/presentation/view_model/community_view_model.dart';
import 'package:junior_football/feature/home/domain/entity/community_feed_entity.dart';
import '../../../../core/utilities/theme_extension.dart';
import '../widgets/comment_item.dart';
import '../widgets/community_post_card.dart';

class PostView extends StatefulWidget {
  final CommunityFeedEntity post;
  const PostView({super.key, required this.post});

  @override
  State<PostView> createState() => _PostViewState();
}

class _PostViewState extends State<PostView> {
  final TextEditingController _commentController = TextEditingController();
  late CommunityViewModel _viewModel;
  StreamSubscription? _eventSubscription;

  @override
  void initState() {
    super.initState();
    _viewModel = getIt<CommunityViewModel>();

    _eventSubscription = _viewModel.eventStream.listen((event) {
      if (event is CommunitySuccessEvent) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(event.message)),
        );
      } else if (event is CommunityErrorEvent) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(event.message),
            backgroundColor: Colors.red,
          ),
        );
      }
    });

    _viewModel.doIntent(GetCommunityPostsIntent());
  }

  @override
  void dispose() {
    _commentController.dispose();
    _eventSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var theme = context.appTheme;
    return BlocProvider.value(
      value: _viewModel,
      child: Scaffold(
        appBar: AppBar(title: Text('postView.title'.tr())),
        body: BlocBuilder<CommunityViewModel, CommunityState>(
          builder: (context, state) {
            // Find the updated post in the list if it exists, otherwise use the widget.post
            final currentPost = state.communityFeedState.data?.firstWhere(
                  (p) => p.id == widget.post.id,
                  orElse: () => widget.post,
                ) ??
                widget.post;

            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(16.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.all(12.h),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border.all(color: theme.borderColor, width: 1.w),
                          ),
                          child: CommunityPostCard(
                            name: currentPost.userFullName ?? "postView.anonymous".tr(),
                            time: currentPost.createdAt ?? "",
                            image: currentPost.userProfilePicture ?? "",
                            content: currentPost.content,
                            postImage: currentPost.mediaUrl,
                            likes: currentPost.likesCount,
                            comments: currentPost.commentsCount,
                            isLiked: currentPost.isLikedByCurrentUser ?? false,
                          ),
                        ),
                        SizedBox(height: 24.h),
                        Text(
                          "${"postView.comments".tr()} (${currentPost.commentsCount ?? 0})",
                          style: theme.semiBold24,
                        ),
                        SizedBox(height: 16.h),
                        if (currentPost.comments != null && currentPost.comments!.isNotEmpty)
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: currentPost.comments?.length,
                            itemBuilder: (context, index) {
                              final comments= currentPost.comments??[];
                              if(comments.isEmpty){
                                return Center(child: Text("postView.noComments".tr()));
                              }
                              return CommentItem(comment: currentPost.comments![index],);
                            },
                          )
                        else
                          Center(child: Text("postView.noComments".tr())),
                      ],
                    ),
                  ),
                ),
                _buildCommentInput(context),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildCommentInput(BuildContext context) {
    var theme = context.appTheme;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: theme.backgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _commentController,
                decoration: InputDecoration(
                  hintText: "postView.addComment".tr(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.r),
                    borderSide: BorderSide(color: theme.borderColor),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.r),
                    borderSide: BorderSide(color: theme.borderColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.r),
                    borderSide: BorderSide(color: theme.primary),
                  ),
                ),
              ),
            ),
            SizedBox(width: 8.w),
            IconButton(
              onPressed: () {
                if (_commentController.text.isNotEmpty) {
                  _viewModel.doIntent(
                    CommentPostIntent(widget.post.id ?? "", _commentController.text),
                  );
                  _commentController.clear();
                  FocusScope.of(context).unfocus();
                }
              },
              icon: Icon(Icons.send, color: theme.primary),
            ),
          ],
        ),
      ),
    );
  }
}
