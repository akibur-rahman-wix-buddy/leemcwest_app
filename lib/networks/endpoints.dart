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
  static String logOut() => "/api/logout";
  static String sendOtpEndPoint() => "/api/send-register-otp";
  static String resendOtpEndPoint() => "/api/resend-register-otp";
  static String verifyOtpEndPoint() => "/api/verify-register-otp";
  static String resendPassOtpEndPoint() => "/api/resend-otp";
  static String sendOtpPassEndPoint() => "/api/send-otp";
  static String verifyOtpPassEndPoint() => "/api/verify-otp";
  static String createPassWordEndPoint() => "/api/reset-password";
  static String storeRoutine() => "/api/routine/store";
  static String getTitrationList() => "/api/titration/index";
 
  static String storeMedication() => "/api/medication/store";
  static String storeTitration() => "/api/titration/store";
  static String getMedicationList() => "/api/medication/index";
  static String storeThought() => "/api/thought/store";
  static String getThoughtList() => "/api/thought/index";
  static String getSingleEvent() => "/api/event/single";
  static String storeEvent() => "/api/events";
  static String getMyEvent() => "/api/events/mine";
  static String deleteAccount() => "/api/delete-account";
  static String updateEvent({required int id}) => "/api/events/$id/edit";
  static String getAllEvent({required String filter}) => "/api/events?filter=$filter";

  // static String getAllEvent(Map<String, dynamic> queryParams) {
  //   final queryString = Uri(queryParameters: queryParams).query;
  //   return 'api/events?$queryString';
  // }

  
  // Profile
  static String getProfile() => "/api/me";
  static String updateProfile() => "/api/settings/update-profile";
  static String changePassWordEndPoint() => "/api/settings/change-password";
  static String updateNotification() => "/api/settings/push-notification";

  // products
  static String getCategoryList() => "/api/category/list";
  static String getMostSaleList() => "/api/product/most-sales";
  static String getOurofferList() => "/api/product/our-offers";
  static String getProductDetails(int id) => "/api/product/$id/show";
  static String getAllProducts(String slug) => "/api/product/list$slug";
  static String postReview() => "/api/review/store";

  // order
  static String pendingOrderList() => "/api/order/pending";
  static String completeOrderList() => "/api/order/completed";
  static String storeOrder() => "/api/order/store";

  // Logistics
  static String logisticsData() => "/api/logistics-data";

  ////post
  static String getPost() => "/api/posts";
  static String storePost() => "/api/post/store";
  
  static String reportPost() => "/api/post/report";

  ///Social Login
  static String socialLogin() => "/api/auth/google";

  ///Category
  static String getCategory() => "/api/categories";

  ///onboarding
  static String onboarding() => "/api/onboarding/setup";

  ///Reaction
  static String storeReact(int id) => "/api/post/$id/toggle-reaction";

  /// Comment
  static String getComment(int id) => "/api/post/$id/comments";
  static String getReplyComment(String id) => "/api/comment/reply/$id";
  static String storeComment(int id) => "/api/post/$id/comment";
  static String storeReplyComment(int id) => "/api/comment/reply/$id";


  /// Chat
  static String getMessageList() => "/api/messages/group/list";
  static String getChatList(int id) => "/api/messages/receive/user/$id";
  static String messageSend(int receiverId) => "/api/messages/send/user/$receiverId";


  ///// Delete
  static String deleteTitration(int id) => "/api/titration/delete/$id";
  static String deleteThought(int id) => "/api/thought/delete/$id";
  static String deleteMedication(int id) => "/api/medication/delete/$id";
  static String deletePlan(int id) => "/api/routine/delete/$id";
  static String deleteEvent(int id) => "/api/events/$id";


  /// weekly planner
   static String getRoutineList(String date){
    return "/api/routine/index?date=$date";
   }
    /// Search Post
     static String searchPost({required String search}) => "/api/posts?search=$search";

     /////Notification
     static String getNotification() => "/api/notification/list";
     static String sentFcmToken() => "/api/firebase/token/add";
}





// const String baseUrl = "https://leemcwest.thewarriors.team";
// final class NetworkConstants {
//   NetworkConstants._();
//   static const ACCEPT = "Accept";
//   static const APP_KEY = "App-Key";
//   static const ACCEPT_LANGUAGE = "Accept-Language";
//   static const ACCEPT_LANGUAGE_VALUE = "pt";
//   static const APP_KEY_VALUE = String.fromEnvironment("APP_KEY_VALUE");
//   static const ACCEPT_TYPE = "application/json";
//   static const AUTHORIZATION = "Authorization";
//   static const CONTENT_TYPE = "content-Type";

// }


// class Endpoints {
//   Endpoints._();
  



//   ///>>>>>>>>>>>>>>>>>>>>> auth and forget >>>>>>>>>>>>>>>>>>>>>>>>>
//   static String login() => "/api/login";
//   static String signUp() => "/api/register";
//   static String postEmailForgetApiLink() =>"/api/forget-password";
//   static String otpForgetApiLink() =>"/api/check-otp";
//   static String forgetPasswordChangeApiLink() =>"/api/reset-password";
//   static String logout() =>"/api/logout";
//   static String verifyEmail() =>"/api/email/verify";


//   ///>>>>>>>>>>>>>>>>>>>>>>>>>>> update profile >>>>>>>>>>>>>>>>>>>>>>>>>>

//   static String postEditProfileApiLink()=> "/api/user-update";
//   static String helpCenterApi()=> "/api/social-media";
//   static String privacyApiData(String apiLink)=> "$apiLink";

//   ///>>>>>>>>>>>>>>>>>>>>>>>>>>>> home screen api link >>>>>>>>>>>>>>>>>>>>>>>

// static String userInfo()=> "/api/dashboard";
// static String resendDocumentsData()=> "/api/dashboard/doucment";
// static String homeInvoiceApiLink()=> "/api/dashboard/invoice";


// ///>>>>>>>>>>>>>>>>>>>>>>>>>>>> Document screen api link >>>>>>>>>>>>>>>>>>>>>>>

// static String documentYearApiLink()=>"/api/document/year";
// static String allDocumentApiLink()=>"/api/document/year";


// ///>>>>>>>>>>>>>>>>>> invoice all api link >>>>>>>>>>>>>>

// static String invoiceAllDataApiLink()=> "/api/invoice";
// static String invoicePayment()=> "/api/stripe/checkout";


// }

// final class PaymentGateway {
//   PaymentGateway._();
//   static String gateway() => "/create-payment-intent";
// }