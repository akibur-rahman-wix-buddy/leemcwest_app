// ignore_for_file: constant_identifier_names

// const String url = String.fromEnvironment("BASE_URL");
const String url = "https://leemcwest.thewarriors.team";
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
  static String signUp() => "/api/register";
  static String login() => "/api/login";
  static String verifyEmail() =>"/api/email/verify";
  static String forgotPassEndpoint() =>"/api/password/forgot";
  static String resetPassOtp() =>"/api/password/forgot/verify";
  static String logOut() => "/api/logout";
  static String sendOtpEndPoint() => "/api/send-register-otp";
  static String resendOtpEndPoint() => "/api/resend-register-otp";
  static String verifyOtpEndPoint() => "/api/verify-register-otp";
  static String resendPassOtpEndPoint() => "/api/resend-otp";
  static String sendOtpPassEndPoint() => "/api/send-otp";
  static String verifyOtpPassEndPoint() => "/api/verify-otp";
  static String createPassWordEndPoint() => "/api/password/reset";

  static String featureSuggestion() => "/api/support/feature-suggestion";
  static String bugReport() => "/api/support/bug-report";
 
  


  
  // Profile
  static String getProfile() => "/api/profile/manage-account";
  static String changePassWordEndPoint() => "/api/password/change";
  static String contactSupport() => "/api/support/contact";
  static String editProfile() => "/api/profile/details";
  static String getFaq() => "/api/faq";
}
