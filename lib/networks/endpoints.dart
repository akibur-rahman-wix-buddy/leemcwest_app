// ignore_for_file: constant_identifier_names

// const String url = String.fromEnvironment("BASE_URL");
const String url = "https://leemcwest.thewarriors.team/api";
const String imageUrl = "$url/";

final class NetworkConstants {
  NetworkConstants._();
  static const ACCEPT = "Accept";
  static const APP_KEY = "App-Key";
  static const ACCEPT_LANGUAGE = "Accept-Language";
  static const ACCEPT_LANGUAGE_VALUE = "pt";
  static const APP_KEY_VALUE = String.fromEnvironment("APP_KEY_VALUE");
  static const ACCEPT_TYPE = "application/json";
  static const AUTHORIZATION = "Authorization";
  static const CONTENT_TYPE = "content-Type";
}

final class Endpoints {
  Endpoints._();
  //backend_url

  // Authentication
  static String signUp() => "/register";
  static String login() => "/login";
  static String verifyEmail() => "/email/verify";
  static String forgotPassEndpoint() => "/password/forgot";
  static String resetPassOtp() => "/password/forgot/verify";
  static String logOut() => "/logout";
  static String sendOtpEndPoint() => "/send-register-otp";
  static String resendOtpEndPoint() => "/email/verify/resend";
  static String verifyOtpEndPoint() => "/verify-register-otp";
  static String resendPassOtpEndPoint() => "/resend-otp";
  static String sendOtpPassEndPoint() => "/send-otp";
  static String verifyOtpPassEndPoint() => "/verify-otp";
  static String createPassWordEndPoint() => "/password/reset";

  static String featureSuggestion() => "/support/feature-suggestion";
  static String bugReport() => "/support/bug-report";
  static String socialLogin() => "/social/login";

  // Profile
  static String getProfile() => "/profile/manage-account";
  static String changePassWordEndPoint() => "/password/change";
  static String contactSupport() => "/support/contact";
  static String editProfile() => "/profile/details";
  static String getFaq() => "/faq";
  static String deleteAccount() => "/profile/delete-account";
  static String reviewStore() => "/reviews-store";
  static String notificationSettingsUpdate() => "/notification-settings-update";
  static String getNotificationSettings() => "/notification-settings-show";
  static String getLesson() => "/lessons";
  static String getProgress() => "/user/progress";
  static String lessonCompleted() => "/lessons/completed";
  static String nextLesson() => "/lessons/next";
  static String getLessonShow({ required int lessonId}) => "/lessons/show/$lessonId";
  static String getLessonQuiz({ required int lessonId}) => "/quiz/by-lesson/$lessonId";
  static String submitAnswer({ required int lessonId}) => "/quiz/submit/$lessonId";
}
