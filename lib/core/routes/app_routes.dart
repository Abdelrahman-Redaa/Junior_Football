import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:junior_football/core/di/di.dart';
import 'package:junior_football/core/routes/routes_name.dart';
import 'package:junior_football/feature/ai/presentation/view/ai_hub_view.dart';
import 'package:junior_football/feature/ai/presentation/view/chat_bot_view.dart';
import 'package:junior_football/feature/ai/presentation/view/injury_protection.dart';
import 'package:junior_football/feature/ai/presentation/view/recent_ai_report.dart';
import 'package:junior_football/feature/ai/presentation/view/skill_twin_view.dart';
import 'package:junior_football/feature/ai/presentation/view_model/ai_state.dart';
import 'package:junior_football/feature/ai/presentation/view_model/ai_view_model.dart';
import 'package:junior_football/feature/ai/presentation/view_model/chat_view_model.dart';
import 'package:junior_football/feature/auth/presentation/view_model/auth_view_model.dart';
import 'package:junior_football/feature/auth/presentation/views/forget_password_view.dart';
import 'package:junior_football/feature/auth/presentation/views/login_view.dart';
import 'package:junior_football/feature/auth/presentation/views/permission_view.dart';
import 'package:junior_football/feature/auth/presentation/views/sign_up_view.dart';
import 'package:junior_football/feature/auth/presentation/views/welcome_view.dart';
import 'package:junior_football/feature/community/presentation/view_model/community_state.dart';
import 'package:junior_football/feature/community/presentation/view_model/community_view_model.dart';
import 'package:junior_football/feature/home/domain/entity/community_feed_entity.dart';
import 'package:junior_football/feature/home/presentation/view_model/analysis_state.dart';
import 'package:junior_football/feature/home/presentation/view_model/analysis_view_model.dart';
import 'package:junior_football/feature/home/presentation/view_model/community_feed_state.dart';
import 'package:junior_football/feature/home/presentation/view_model/community_feed_view_model.dart';
import 'package:junior_football/feature/home/presentation/view_model/home_view_model.dart';
import 'package:junior_football/feature/home/presentation/view_model/home_state.dart';
import 'package:junior_football/feature/profile/presentation/views/edit_profile.dart';
import 'package:junior_football/feature/profile/presentation/views/player_profile.dart';
import 'package:junior_football/feature/profile/presentation/views/profile_view.dart';
import 'package:junior_football/feature/session_training/presentation/views/session_level.dart';
import 'package:junior_football/feature/session_training/presentation/views/session_view.dart';

import '../../feature/community/presentation/views/community_view.dart';
import '../../feature/community/presentation/views/post_view.dart';
import '../../feature/home/presentation/views/ai_recommendation_view.dart';
import '../../feature/home/presentation/views/ai_report_view.dart';
import '../../feature/home/presentation/views/analyze_video_view.dart';
import '../../feature/home/presentation/views/speed_session_view.dart';
import '../../feature/home/presentation/views/training_hub_view.dart';
import '../../feature/home/presentation/views/upload_vide_view.dart';
import '../../feature/home/presentation/views/video_record_screen.dart';
import '../../feature/home/presentation/views/weekly_plan_view.dart';
import '../../feature/layout/bottom_navigation_view.dart';

class Routes {
  static Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.welcomeView:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => getIt.get<AuthViewModel>(),
            child: WelcomeView(),
          ),
        );
      case AppRoutes.loginView:
        return MaterialPageRoute(builder: (context) => const LoginView());
      case AppRoutes.signupView:
        return MaterialPageRoute(builder: (context) => const SignUpView());
      case AppRoutes.permissionView:
        return MaterialPageRoute(builder: (context) => const PermissionView());
      case AppRoutes.forgetPasswordView:
        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: getIt.get<AuthViewModel>(),
            child: ForgetPasswordView(),
          ),
        );
      case AppRoutes.aiHubView:
        return MaterialPageRoute(builder: (context) => const AiHubView());
      case AppRoutes.skillTwinView:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) =>
                getIt.get<AiViewModel>()..doIntent(GetSkillTwinIntent()),
            child: SkillTwinView(),
          ),
        );
      case AppRoutes.chatBotView:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => getIt.get<ChatViewModel>(),
            child: ChatBotView(),
          ),
        );
      case AppRoutes.injuryProtectionView:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) =>
                getIt.get<AiViewModel>()..doIntent(GetInjuryPredictionIntent()),
            child: InjuryProtectionView(),
          ),
        );
      case AppRoutes.profileView:
        return MaterialPageRoute(builder: (context) => const ProfileView());
      case AppRoutes.editProfileView:
        return MaterialPageRoute(builder: (context) => const EditProfileView());
      case AppRoutes.sessionView:
        return MaterialPageRoute(
          builder: (context) => SessionView(
            args: settings.arguments is TrainingVideoArgs
                ? settings.arguments as TrainingVideoArgs
                : null,
          ),
        );
      case AppRoutes.trainingHubView:
        return MaterialPageRoute(builder: (context) => const TrainingHubView());
      case AppRoutes.sessionLevelView:
        return MaterialPageRoute(
          builder: (context) => const SessionLevelView(),
        );

      case AppRoutes.bottomNavigationView:
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) =>
                    getIt.get<CommunityFeedViewModel>()
                      ..doIntent(GetCommunityFeedIntent()),
              ),

              BlocProvider(
                create: (context) =>
                    getIt.get<HomeViewModel>()
                      ..doIntent(GetTrainingDashboardIntent()),
              ),
            ],
            child: const BottomNavigationView(),
          ),
        );
      case AppRoutes.uploadVideView:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => BlocProvider(
            create: (context) => getIt.get<HomeViewModel>(),
            child: UploadVideView(),
          ),
        );
      case AppRoutes.analyzeWithVideoView:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => BlocProvider(
            create: (context) => getIt.get<AnalysisViewModel>()
              ..doIntent(
                AnalysisVideoIntent(videoUrl: settings.arguments as String),
              ),
            child: AnalyzeVideoView(),
          ),
        );
      case AppRoutes.communityView:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) =>
                getIt.get<CommunityViewModel>()
                  ..doIntent(GetCommunityPostsIntent()),
            child: CommunityView(),
          ),
        );
      case AppRoutes.aiReportView:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const AiReportView(),
        );
      case AppRoutes.postView:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) =>
              PostView(post: settings.arguments as CommunityFeedEntity),
        );
      case AppRoutes.speedSessionView:
        return MaterialPageRoute(
          builder: (context) => const SpeedSessionView(),
        );
      case AppRoutes.aiRecommendationView:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const AiRecommendationView(),
        );
      case AppRoutes.recentAiReport:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) =>
                getIt.get<AiViewModel>()..doIntent(GetRecentReportIntent()),
            child: RecentAiReport(),
          ),
        );
      case AppRoutes.recordVideoScreen:
        return MaterialPageRoute(
          builder: (context) => const VideoRecorderScreen(),
        );
      case AppRoutes.weeklyPlanView:
        return MaterialPageRoute(
          builder: (context) => const WeeklyPlanScreen(),
        );
      case AppRoutes.playerProfileView:
        return MaterialPageRoute(
          builder: (context) => PlayerProfileView(
            userId: settings.arguments is String
                ? settings.arguments as String
                : null,
          ),
        );

      default:
        return null;
    }
  }
}
