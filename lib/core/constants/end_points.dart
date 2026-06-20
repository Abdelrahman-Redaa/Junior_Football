final class EndPoint {
  EndPoint._();

  static const String login = "/api/auth/login";
  static const String loginWithGoogle = "/api/auth/google-login";
  static const String refreshToken = "/api/auth/refresh-token";
  static const String signup = "/api/auth/register";
  static const String forgetPassword = '/api/auth/forget-password';
  static const String verifyOtp = '/api/auth/verify-otp';
  static const String resetPassword = '/api/auth/reset-password';
  static const String uploadVideoAi = "/api/Ai/upload-video";
  static const String analysisVideo = "/api/ai/analyze";

  static const String recentAiReports = "/api/Ai/reports";
  static const String injuryPrediction = "/api/Health/injury-prediction";
  static const String skillTwin = "/api/skilltwin/random";
  static const String chatAi = "/api/Ai/chat";
  static const String communityFeed = "/api/post/feed";
  static const String likePost = "/api/Post/{postId}/like";
  static const String commentPost = "/api/Post/{postId}/comment";
  static const String trainingDashboard = "/api/Training/dashboard";
  static const String fullWeeklyPlan = "/api/WeeklyPlan/full-plan";
  static const String createPost = "/api/Post";
  static const String userProfile = "/api/UserProfile";
  static const String userProfileById = "/api/userprofile/{userId}";
  static const String uploadProfilePicture = "/api/UserProfile/upload-picture";
  static const String followUser = "/api/userprofile/{userId}/follow";
  static const String unfollowUser = "/api/userprofile/{userId}/unfollow";
  static const String uploadFileVideo = "/api/file/upload-video";
}
