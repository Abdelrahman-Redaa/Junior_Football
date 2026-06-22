import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:junior_football/core/di/di.dart';
import 'package:junior_football/feature/home/presentation/view_model/community_feed_state.dart';
import 'package:junior_football/feature/home/presentation/view_model/community_feed_view_model.dart';
import 'package:junior_football/feature/home/presentation/view_model/home_state.dart';
import 'package:junior_football/feature/home/presentation/view_model/home_view_model.dart';
import 'package:junior_football/feature/home/presentation/widgets/custom_home_training_card.dart';
import 'package:junior_football/feature/home/presentation/widgets/custom_speed_training.dart';
import 'package:junior_football/feature/home/presentation/widgets/weekly_planing_widget.dart';
import 'package:junior_football/feature/session_training/presentation/views/session_view.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/routes/routes_name.dart';
import '../../../../core/utilities/theme_extension.dart';
import 'training_hub_view.dart';
import '../widgets/custom__training_card.dart';
import '../widgets/custom_ai_summary_card.dart';
import '../widgets/custom_card.dart';
import '../widgets/custom_cart_community.dart';
import '../widgets/custom_header.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late HomeViewModel _homeViewModel;

  @override
  void initState() {
    super.initState();
    _homeViewModel = getIt.get<HomeViewModel>();
    _homeViewModel.doIntent(GetTrainingDashboardIntent());
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return Scaffold(
      body: BlocProvider.value(
        value: _homeViewModel,
        child: BlocBuilder<HomeViewModel, HomeState>(
          builder: (context, state) {
            return Padding(
              padding: EdgeInsets.all(20.0.w),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 30.h),
                    HeaderCustom(),

                    SizedBox(height: 20.h),
                    Text(
                      "Quick Actions",
                      style: theme.semiBold24.copyWith(color: theme.surface),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          CustomCard(
                            image: AppAssets.uploadVideo,
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                AppRoutes.uploadVideView,
                              );
                            },
                            title: "Upload \nVideo",
                          ),
                          CustomCard(
                            image: AppAssets.recordVideo,
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                AppRoutes.recordVideoScreen,
                              );
                            },
                            title: "Record \nVideo",
                          ),
                          CustomCard(
                            image: AppAssets.analyzeWithAI,
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                AppRoutes.recordVideoScreen,
                              );
                            },
                            title: "Analyze \nwith AI",
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 25.h),
                    Text(
                      "Today's Training",
                      style: theme.semiBold24.copyWith(color: theme.surface),
                    ),

                    // Today's Training from Dashboard
                    if (state.trainingDashboard.isLoading)
                      const Center(child: CircularProgressIndicator())
                    else if (state.trainingDashboard.isError)
                      Center(
                        child: Text(
                          state.trainingDashboard.errorMessage ??
                              "Error loading dashboard",
                        ),
                      )
                    else if (state.trainingDashboard.data?.todaySession != null)
                      TrainingCard(
                        title:
                            state.trainingDashboard.data!.todaySession!.title,
                        duration:
                            "${state.trainingDashboard.data!.todaySession!.durationMinutes} min",
                        level: state
                            .trainingDashboard
                            .data!
                            .todaySession!
                            .difficulty,
                        progress:
                            (state.trainingDashboard.data!.xpProgress /
                                    state.trainingDashboard.data!.nextLevelXp)
                                .clamp(0.0, 1.0),
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            AppRoutes.trainingHubView,
                          );
                        },
                      )
                    else
                      const SizedBox.shrink(),

                    SizedBox(height: 25.h),
                    Text(
                      "AI Insights",
                      style: theme.semiBold24.copyWith(color: theme.surface),
                    ),
                    SizedBox(height: 8.h),

                    ///// ai card ////////
                    if (state.trainingDashboard.data != null)
                      AiSummaryCard(
                        aiScore:
                            "${state.trainingDashboard.data!.xpProgress}/${state.trainingDashboard.data!.nextLevelXp}",
                        skillLevel: state.trainingDashboard.data!.userLevel,
                        injuryRisk: "Low",
                        onViewReport: () {
                          Navigator.pushNamed(
                            context,
                            AppRoutes.recentAiReport,
                          );
                        },
                      )
                    else
                      AiSummaryCard(
                        aiScore: "87/100",
                        skillLevel: "Elite",
                        injuryRisk: "Low",
                        onViewReport: () {
                          Navigator.pushNamed(
                            context,
                            AppRoutes.recentAiReport,
                          );
                        },
                      ),

                    SizedBox(height: 40.h),
                    Text(
                      "Community",
                      style: theme.semiBold24.copyWith(
                        color: theme.surface,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    SizedBox(height: 8.h),

                    BlocBuilder<CommunityFeedViewModel, CommunityFeedState>(
                      builder: (context, state) {
                        if (state.communityFeed.isLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (state.communityFeed.isError) {
                          return Center(
                            child: Text(
                              state.communityFeed.errorMessage ?? "Error",
                            ),
                          );
                        }
                        final communityFeed = state.communityFeed.data;
                        if (communityFeed == null || communityFeed.isEmpty) {
                          return const Center(child: Text("No Data"));
                        }

                        return Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: Color((0xffD9D9D9))),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.05),
                                blurRadius: 10,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: ListView.separated(
                            separatorBuilder: (context, index) => Divider(),
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: communityFeed.length,
                            itemBuilder: (context, index) {
                              return CustomCartCommunity(
                                title:
                                    communityFeed[index].userFullName ?? "User",
                                subtitle: communityFeed[index].content ?? "",
                                history: communityFeed[index].createdAt ?? "",
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    AppRoutes.communityView,
                                  );
                                },
                                image:
                                    communityFeed[index].userProfilePicture ??
                                    "",
                                isEndOfList: index == communityFeed.length - 1,
                              );
                            },
                          ),
                        );
                      },
                    ),

                    SizedBox(height: 25.h),

                    CustomHomeTrainingCard(),
                    WeeklyPlanCard(),
                    SizedBox(height: 25.h),

                    // Today's Session from Dashboard
                    if (state.trainingDashboard.data?.todaySession != null)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Today's Session",
                                style: theme.semiBold24.copyWith(
                                  color: theme.surface,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    AppRoutes.speedSessionView,
                                  );
                                },
                                child: Text(
                                  "View more",
                                  style: theme.regular14.copyWith(
                                    color: theme.primary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8.h),
                          CustomSpeedTraining(
                            title: state
                                .trainingDashboard
                                .data!
                                .todaySession!
                                .title,
                            subtitle: state
                                .trainingDashboard
                                .data!
                                .todaySession!
                                .description,
                            duration:
                                "${state.trainingDashboard.data!.todaySession!.durationMinutes} mins",
                            rounds:
                                "${state.trainingDashboard.data!.todaySession!.drillsCount} drills",
                            level: state
                                .trainingDashboard
                                .data!
                                .todaySession!
                                .difficulty,
                            category: state
                                .trainingDashboard
                                .data!
                                .todaySession!
                                .sessionType,
                            imageUrl: state
                                .trainingDashboard
                                .data!
                                .todaySession!
                                .thumbnailUrl,
                          ),
                        ],
                      )
                    else
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Today's Session",
                                style: theme.semiBold24.copyWith(
                                  color: theme.surface,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    AppRoutes.speedSessionView,
                                  );
                                },
                                child: Text(
                                  "View more",
                                  style: theme.regular14.copyWith(
                                    color: theme.primary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8.h),
                          CustomSpeedTraining(
                            title: "Speed Training",
                            subtitle: "Practice and improve your speed level",
                            duration: "45 mins",
                            rounds: "3 rounds/15 min",
                            level: "Medium",
                            category: "Legs",
                            imageUrl: "https://....",
                          ),
                        ],
                      ),

                    SizedBox(height: 25.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Recommendations",
                          style: theme.semiBold24.copyWith(
                            color: theme.surface,
                          ),
                        ),
                        Text(
                          "View more",
                          style: theme.regular14.copyWith(color: theme.primary),
                        ),
                      ],
                    ),
                    SizedBox(height: 22.h),

                    // Dynamic Recommendations from Dashboard
                    if (state.trainingDashboard.data?.quickRecommendations !=
                            null &&
                        state
                            .trainingDashboard
                            .data!
                            .quickRecommendations
                            .isNotEmpty)
                      ...List.generate(
                        state
                            .trainingDashboard
                            .data!
                            .quickRecommendations
                            .length,
                        (index) {
                          final recommendation = state
                              .trainingDashboard
                              .data!
                              .quickRecommendations[index];
                          return Column(
                            children: [
                              Container(
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(
                                  vertical: 10.h,
                                  horizontal: 16.w,
                                ),
                                decoration: BoxDecoration(
                                  color: Color(0xFFEAF6EC),
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      width: 40.w,
                                      height: 35.h,
                                      padding: EdgeInsets.all(4.w),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFB9D7C0),
                                        borderRadius: BorderRadius.circular(
                                          8.r,
                                        ),
                                      ),
                                      child: Icon(
                                        Icons.sports_football,
                                        size: 20.r,
                                      ),
                                    ),
                                    SizedBox(width: 10.w),
                                    Expanded(
                                      child: Text(
                                        recommendation.title,
                                        style: theme.regular22.copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              if (index <
                                  state
                                          .trainingDashboard
                                          .data!
                                          .quickRecommendations
                                          .length -
                                      1)
                                SizedBox(height: 16.h),
                            ],
                          );
                        },
                      )
                    else ...[
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            AppRoutes.sessionView,
                            arguments: const TrainingVideoArgs(
                              title: 'Shooting lesson',
                              videoUrl: TrainingHubView.shootingVideo,
                            ),
                          );
                        },
                        borderRadius: BorderRadius.circular(12.r),
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                            vertical: 10.h,
                            horizontal: 16.w,
                          ),
                          decoration: BoxDecoration(
                            color: Color(0xFFEAF6EC),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 40.w,
                                height: 35.h,
                                padding: EdgeInsets.all(4.w),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFB9D7C0),
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                                child: SvgPicture.asset(SVGAssets.football),
                              ),
                              SizedBox(width: 10.w),
                              Text(
                                "Shooting lesson",
                                style: theme.regular22.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 16.h),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            AppRoutes.sessionView,
                            arguments: const TrainingVideoArgs(
                              title: 'Passing lesson',
                              videoUrl: TrainingHubView.passingVideo,
                            ),
                          );
                        },
                        borderRadius: BorderRadius.circular(12.r),
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                            vertical: 10.h,
                            horizontal: 16.w,
                          ),
                          decoration: BoxDecoration(
                            color: Color(0xFFEAF6EC),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 40.w,
                                height: 35.h,
                                padding: EdgeInsets.all(4.w),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFB9D7C0),
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                                child: SvgPicture.asset(
                                  SVGAssets.passingLesson,
                                ),
                              ),
                              SizedBox(width: 10.w),
                              Text(
                                "Passing lesson",
                                style: theme.regular22.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],

                    SizedBox(height: 24.h),
                    InkWell(
                      onTap: () {},
                      borderRadius: BorderRadius.circular(15.r),
                      child: Container(
                        height: 45.h,
                        decoration: BoxDecoration(
                          color: theme.primary,
                          borderRadius: BorderRadius.circular(15.r),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.play_arrow,
                              size: 30.sp,
                              color: theme.secondary,
                            ),
                            SizedBox(width: 4.w),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  AppRoutes.sessionView,
                                );
                              },
                              child: Text(
                                "Start Training",
                                style: theme.semiBold24.copyWith(
                                  color: theme.secondary,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20.sp,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
