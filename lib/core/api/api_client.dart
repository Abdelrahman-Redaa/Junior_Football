import 'dart:io';
import 'package:injectable/injectable.dart';
import 'package:junior_football/core/constants/end_points.dart';
import 'package:junior_football/feature/ai/data/models/chat_ai_response.dart';
import 'package:junior_football/feature/ai/data/models/injury_prediction_response.dart';
import 'package:junior_football/feature/ai/data/models/recent_ai_report_response.dart';
import 'package:junior_football/feature/ai/data/models/twin_player_response.dart';
import 'package:junior_football/feature/auth/data/models/request_models/login_request_dto.dart';
import 'package:junior_football/feature/auth/data/models/request_models/login_with_google_dto.dart';
import 'package:junior_football/feature/auth/data/models/request_models/sign_up_request_dto.dart';
import 'package:junior_football/feature/auth/data/models/response_models/forget_password_dto.dart';
import 'package:junior_football/feature/community/data/models/created_response.dart';
import 'package:junior_football/feature/home/data/models/request/analysis_ai_request.dart';
import 'package:junior_football/feature/home/data/models/response/analysis_ai_response.dart';
import 'package:junior_football/feature/home/data/models/response/community_feed.dart';
import 'package:junior_football/feature/home/data/models/response/upload_video_response.dart';
import 'package:junior_football/feature/home/data/models/response/full_weekly_plan_response.dart';
import 'package:junior_football/feature/home/data/models/response/training_dashboard.dart';
import 'package:junior_football/feature/auth/data/models/response_models/verify_otp_response.dart';
import 'package:junior_football/feature/profile/data/models/response_models/user_profile_dto.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import '../../feature/auth/data/models/request_models/verify-otp_request.dart';
import '../../feature/auth/data/models/response_models/login_response.dart';
import '../../feature/auth/data/models/response_models/register_response.dart';
part 'api_client.g.dart';

@RestApi()
abstract class ApiClient {
  @factoryMethod
  factory ApiClient(Dio dio, {String? baseUrl}) = _ApiClient;

  @POST(EndPoint.signup)
  Future<RegisterResponse> signup(@Body() SignupRequestDto signupModel);

  @POST(EndPoint.login)
  Future<LoginResponse> login(@Body() LoginRequestDto loginModel);
  @POST(EndPoint.loginWithGoogle)
  Future<LoginResponse> loginWithGoogle(@Body() GoogleLoginRequest request);

  @POST(EndPoint.forgetPassword)
  Future<EmailVerificationResponseDto> emailVerification({
    @Body() required UserOTPDto userOTPDto,
  });

  @POST(EndPoint.verifyOtp)
  Future<VerifyOtpResponse> verifyResetPasswordCode({
    @Body() required VerifyOtpRequest userOTPDto,
  });

  @POST(EndPoint.resetPassword)
  Future<ResetPasswordResponseDto> resetPassword({
    @Body() required UserOTPDto userOTPDto,
  });

  /////////////////// Home /////////////////////////////////////////////////

  @POST(EndPoint.uploadVideoAi)
  @MultiPart()
  Future<UploadVideoResponse> uploadVideoAi({
    @Part(name: 'file') required File file,
    @PartMap() Map<String, dynamic>? metadata,
    @SendProgress() void Function(int sent, int total)? onProgress,
  });
  @POST(EndPoint.analysisVideo)
  Future<AnalysisAiResponse> analysisVideo({
    @Body() required AnalysisAiRequest analysisAiRequest,
    @SendProgress() void Function(int sent, int total)? onProgress,
  });
  @GET(EndPoint.recentAiReports)
  Future<List<RecentAiReportResponse>> getRecentAiReports();

  @GET(EndPoint.injuryPrediction)
  Future<InjuryPredictionResponse> getInjuryPrediction();

  @GET(EndPoint.skillTwin)
  Future<TwinPlayerResponse> getSkillTwin();

  @POST(EndPoint.chatAi)
  Future<ChatAiResponse> chatAi(@Field("question") String message);

  @GET(EndPoint.communityFeed)
  Future<List<CommunityFeedResponse>> getCommunityFeed();

  @POST(EndPoint.likePost)
  Future<CreatedResponse> likePost(@Path("postId") String postId);

  @POST(EndPoint.commentPost)
  Future<CreatedResponse> commentPost(
    @Path("postId") String postId,
    @Body() Map<String, dynamic> body,
  );

  @POST(EndPoint.createPost)
  @MultiPart()
  Future<CreatedResponse> createPost({
    @Part(name: "file") required File file,
    @Part(name: "content") required String content,
  });

  @GET(EndPoint.trainingDashboard)
  Future<TrainingDashboard> getTrainingDashboard();

  @MultiPart()
  @POST(EndPoint.uploadProfilePicture)
  Future<UserProfileDto> uploadProfilePicture({
    @Part(name: 'file') required File file,
  });

  @GET(EndPoint.fullWeeklyPlan)
  Future<List<FullWeeklyPlanResponse>> getFullWeeklyPlan();

  @GET(EndPoint.userProfile)
  Future<UserProfileDto> getUserProfile();

  @GET(EndPoint.userProfileById)
  Future<UserProfileDto> getUserProfileById(@Path("userId") String userId);

  @POST(EndPoint.followUser)
  Future<CreatedResponse> followUser(@Path("userId") String userId);

  @POST(EndPoint.unfollowUser)
  Future<CreatedResponse> unfollowUser(@Path("userId") String userId);

  @POST(EndPoint.uploadFileVideo)
  @MultiPart()
  Future<UploadVideoResponse> uploadProfileVideo({
    @Part(name: 'file') required File file,
    @SendProgress() void Function(int sent, int total)? onProgress,
  });
}
