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
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<CommunityViewModel>()..doIntent(GetCommunityPostsIntent()),
      child: Scaffold(
        appBar: AppBar(title: Text('community.title'.tr()), centerTitle: false),
        body: BlocListener<CommunityViewModel, CommunityState>(
          listenWhen: (previous, current) =>
              previous.followUserState != current.followUserState ||
              previous.unfollowUserState != current.unfollowUserState ||
              previous.deletePostState != current.deletePostState,
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
                SnackBar(content: Text('community.unfollowedSuccessfully'.tr())),
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
          },
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 8.h),
                child: _CommunitySearch(controller: _searchController),
              ),
              CreatePostCard(),
              Expanded(
                child: BlocBuilder<CommunityViewModel, CommunityState>(
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

                    if (posts.isEmpty && feedState.isLoaded) {
                      return const Center(child: Text("No posts available"));
                    }

                    return RefreshIndicator(
                      onRefresh: () async {
                        context.read<CommunityViewModel>().doIntent(
                          GetCommunityPostsIntent(),
                        );
                      },
                      child: ListView.builder(
                        padding: EdgeInsets.all(16.w),
                        itemCount: posts.length,
                        itemBuilder: (context, index) {
                          final post = posts[index];

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
                              onAuthorTap:
                                  post.userId == null || post.userId!.isEmpty
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
                                      context
                                          .read<CommunityViewModel>()
                                          .doIntent(
                                            UnfollowCommunityUserIntent(
                                              post.userId!,
                                            ),
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
            ],
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

class _CommunitySearch extends StatelessWidget {
  const _CommunitySearch({required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      textInputAction: TextInputAction.search,
      decoration: InputDecoration(
        hintText: 'Follow player by ID',
        prefixIcon: const Icon(Icons.search),
        suffixIcon: IconButton(
          icon: const Icon(Icons.arrow_forward),
          onPressed: () => _search(context),
        ),
      ),
      onSubmitted: (_) => _search(context),
    );
  }

  void _search(BuildContext context) {
    FocusScope.of(context).unfocus();
    context.read<CommunityViewModel>().doIntent(
      FollowCommunityUserIntent(controller.text),
    );
    controller.clear();
  }
}
