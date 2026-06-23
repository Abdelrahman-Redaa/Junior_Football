import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:junior_football/core/di/di.dart';
import 'package:junior_football/core/routes/routes_name.dart';
import 'package:junior_football/feature/community/presentation/view_model/community_state.dart';
import 'package:junior_football/feature/community/presentation/view_model/community_view_model.dart';
import 'package:junior_football/feature/community/presentation/widgets/create_post_card.dart';

import '../widgets/community_post_card.dart';

class CommunityView extends StatefulWidget {
  const CommunityView({super.key});

  @override
  State<CommunityView> createState() => _CommunityViewState();
}

class _CommunityViewState extends State<CommunityView> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<CommunityViewModel>()..doIntent(GetCommunityPostsIntent()),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Text('community.title'.tr()),
          actions: [
            _FollowSearchButton(),
            SizedBox(width: 8.w),
          ],
        ),
        body: BlocListener<CommunityViewModel, CommunityState>(
          listenWhen: (previous, current) =>
              previous.followUserState != current.followUserState ||
              previous.unfollowUserState != current.unfollowUserState ||
              previous.deletePostState != current.deletePostState ||
              previous.createPostState != current.createPostState,
          listener: (context, state) {
            if (state.followUserState.isError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    state.followUserState.errorMessage ?? 'Follow failed',
                  ),
                ),
              );
            }
            if (state.followUserState.isLoaded) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('community.followedSuccessfully'.tr())),
              );
            }
            if (state.unfollowUserState.isError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    state.unfollowUserState.errorMessage ?? 'Unfollow failed',
                  ),
                ),
              );
            }
            if (state.unfollowUserState.isLoaded) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('community.unfollowedSuccessfully'.tr()),
                ),
              );
            }
            if (state.deletePostState.isError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    state.deletePostState.errorMessage ?? 'Delete failed',
                  ),
                ),
              );
            }
            if (state.deletePostState.isLoaded) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('community.postDeleted'.tr())),
              );
            }
            if (state.createPostState.isLoaded) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('community.postCreated'.tr()),
                  backgroundColor: Colors.green.shade600,
                ),
              );
            }
            if (state.createPostState.isError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    state.createPostState.errorMessage ?? 'Post failed',
                  ),
                  backgroundColor: Colors.red.shade600,
                ),
              );
            }
          },
          child: BlocBuilder<CommunityViewModel, CommunityState>(
            buildWhen: (prev, curr) =>
                prev.communityFeedState != curr.communityFeedState,
            builder: (context, state) {
              final feedState = state.communityFeedState;

              if (feedState.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (feedState.isError) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(feedState.errorMessage ?? "An error occurred"),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () => context
                            .read<CommunityViewModel>()
                            .doIntent(GetCommunityPostsIntent()),
                        child: Text('community.retry'.tr()),
                      ),
                    ],
                  ),
                );
              }

              final posts = feedState.data ?? [];

              return RefreshIndicator(
                onRefresh: () async {
                  context.read<CommunityViewModel>().doIntent(
                    GetCommunityPostsIntent(),
                  );
                },
                child: ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 32.h),
                  itemCount: posts.length + 1, // +1 for the CreatePostCard
                  itemBuilder: (context, index) {
                    // First item is always the CreatePostCard
                    if (index == 0) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: 16.h),
                        child: const CreatePostCard(),
                      );
                    }

                    // Adjust index for actual posts
                    final post = posts[index - 1];

                    return Padding(
                      padding: EdgeInsets.only(bottom: 16.h),
                      child: CommunityPostCard(
                        name: post.userFullName ?? "Anonymous",
                        time: post.createdAt ?? "",
                        image: post.userProfilePicture ?? "",
                        content: post.content,
                        postImage: post.mediaUrl,
                        likes: post.likesCount,
                        comments: post.commentsCount,
                        isLiked: post.isLikedByCurrentUser ?? false,
                        onAuthorTap: post.userId == null || post.userId!.isEmpty
                            ? null
                            : () {
                                Navigator.pushNamed(
                                  context,
                                  AppRoutes.playerProfileView,
                                  arguments: post.userId,
                                );
                              },
                        onUnfollowTap:
                            post.userId == null || post.userId!.isEmpty
                            ? null
                            : () {
                                context.read<CommunityViewModel>().doIntent(
                                  UnfollowCommunityUserIntent(post.userId!),
                                );
                              },
                        onDeleteTap: post.id == null || post.id!.isEmpty
                            ? null
                            : () => _confirmDeletePost(context, post.id!),
                        onLikeTap: () {
                          context.read<CommunityViewModel>().doIntent(
                            LikePostIntent(post.id ?? ""),
                          );
                        },
                        onCommentTap: () {
                          Navigator.pushNamed(
                            context,
                            AppRoutes.postView,
                            arguments: post,
                          );
                        },
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Future<void> _confirmDeletePost(BuildContext context, String postId) async {
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text('community.deletePost'.tr()),
        content: Text('community.deletePostConfirm'.tr()),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: Text('community.cancel'.tr()),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: Text('community.delete'.tr()),
          ),
        ],
      ),
    );

    if (shouldDelete != true || !context.mounted) return;
    context.read<CommunityViewModel>().doIntent(DeletePostIntent(postId));
  }
}

/// Search icon button in AppBar — opens a dialog to follow by Player ID
class _FollowSearchButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommunityViewModel, CommunityState>(
      buildWhen: (prev, curr) => prev.followUserState != curr.followUserState,
      builder: (context, state) {
        return IconButton(
          tooltip: 'Follow player by ID',
          icon: state.followUserState.isLoading
              ? SizedBox(
                  width: 20.r,
                  height: 20.r,
                  child: const CircularProgressIndicator(strokeWidth: 2),
                )
              : const Icon(Icons.person_search_rounded),
          onPressed: state.followUserState.isLoading
              ? null
              : () => _showFollowDialog(context),
        );
      },
    );
  }

  void _showFollowDialog(BuildContext context) {
    final controller = TextEditingController();
    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text('community.followByID'.tr()),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: InputDecoration(
            hintText: 'community.enterPlayerID'.tr(),
            prefixIcon: const Icon(Icons.person_outline),
          ),
          textInputAction: TextInputAction.done,
          onSubmitted: (_) {
            Navigator.pop(dialogContext);
            _submitFollow(context, controller.text);
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text('community.cancel'.tr()),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              _submitFollow(context, controller.text);
            },
            child: Text('community.follow'.tr()),
          ),
        ],
      ),
    );
  }

  void _submitFollow(BuildContext context, String userId) {
    final trimmed = userId.trim();
    if (trimmed.isEmpty) return;
    context.read<CommunityViewModel>().doIntent(
      FollowCommunityUserIntent(trimmed),
    );
  }
}
