import 'package:leemcwest/features/authentication/data/rx_post_change_password/rx.dart';
import 'package:leemcwest/features/authentication/data/rx_post_create_password/rx.dart';
import 'package:leemcwest/features/authentication/data/rx_post_forget_password/rx.dart';
import 'package:leemcwest/features/authentication/data/rx_post_login/rx.dart';
import 'package:leemcwest/features/authentication/data/rx_post_resend_otp/rx.dart';
import 'package:leemcwest/features/authentication/data/rx_post_reset_password_otp/rx.dart';
import 'package:leemcwest/features/authentication/data/rx_post_sign_up/rx.dart';
import 'package:leemcwest/features/authentication/data/rx_post_social_login/rx.dart';
import 'package:leemcwest/features/authentication/data/rx_post_verify_email/rx.dart';
import 'package:leemcwest/features/authentication/model/login_model.dart';
import 'package:leemcwest/features/authentication/model/otp_pass_model.dart';
import 'package:leemcwest/features/authentication/model/otp_verify_model.dart';
import 'package:leemcwest/features/authentication/model/social_login_model.dart';
import 'package:leemcwest/features/lesson/data/rx_get_lesson/rx.dart';
import 'package:leemcwest/features/lesson/data/rx_get_lesson_quiz/rx.dart';
import 'package:leemcwest/features/lesson/data/rx_get_lesson_show/rx.dart';
import 'package:leemcwest/features/lesson/data/rx_get_lesson_summary/rx.dart';
import 'package:leemcwest/features/lesson/data/rx_post_lesson_completed/rx.dart';
import 'package:leemcwest/features/lesson/data/rx_post_next_lesson/rx.dart';
import 'package:leemcwest/features/lesson/data/rx_post_submit_answer/rx.dart';
import 'package:leemcwest/features/lesson/model/get_lesson_model.dart';
import 'package:leemcwest/features/lesson/model/get_lesson_quiz_model.dart';
import 'package:leemcwest/features/lesson/model/get_lesson_show_model.dart';
import 'package:leemcwest/features/lesson/model/get_lesson_summary.dart';
import 'package:leemcwest/features/profile/data/rx_get_faq/rx.dart';
import 'package:leemcwest/features/profile/data/rx_get_notification_settings/rx.dart';
import 'package:leemcwest/features/profile/data/rx_get_profile_data/rx.dart';
import 'package:leemcwest/features/profile/data/rx_post_delete_account/rx.dart';
import 'package:leemcwest/features/profile/data/rx_post_logout/rx.dart';
import 'package:leemcwest/features/profile/data/rx_post_review_store/rx.dart';
import 'package:leemcwest/features/profile/data/rx_post_update_notification/rx.dart';
import 'package:leemcwest/features/profile/data/rx_post_update_profile/rx.dart';
import 'package:leemcwest/features/profile/model/faq_model.dart';
import 'package:leemcwest/features/profile/model/notification_settings_model.dart';
import 'package:leemcwest/features/profile/model/profile_data_model.dart';
import 'package:leemcwest/features/progress/data/rx_get_progress/rx.dart';
import 'package:leemcwest/features/progress/model/get_progress_model.dart';
import 'package:leemcwest/features/support/data/rx_post_bug_report/rx.dart';
import 'package:leemcwest/features/support/data/rx_post_contact_support/rx.dart';
import 'package:leemcwest/features/support/data/rx_post_feature_suggestion/rx.dart';
import 'package:rxdart/subjects.dart';

SignUpRx signUpRxObj = SignUpRx(empty: {}, dataFetcher: BehaviorSubject<Map>());

VerifyEmailRX verifyEmailRxObj = VerifyEmailRX(
    empty: OtpVerifyModel(), dataFetcher: BehaviorSubject<OtpVerifyModel>());
LoginRx loginRxObj =
    LoginRx(empty: LoginModel(), dataFetcher: BehaviorSubject<LoginModel>());
ForgotPassRx forgotPassRxObj =
    ForgotPassRx(empty: {}, dataFetcher: BehaviorSubject<Map>());
ResetPassOtpRx resetPassOtpRxObj = ResetPassOtpRx(
    empty: OtpPassModel(), dataFetcher: BehaviorSubject<OtpPassModel>());
PostResetPasswordRx postResetPasswordRxObj =
    PostResetPasswordRx(empty: {}, dataFetcher: BehaviorSubject<Map>());
PostChangePasswordRx postChangePasswordRxObj =
    PostChangePasswordRx(empty: {}, dataFetcher: BehaviorSubject<Map>());
LogoutRx logoutRxObj = LogoutRx(empty: {}, dataFetcher: BehaviorSubject<Map>());
GetOwnProfileRx getOwnProfileRxObj = GetOwnProfileRx(
    empty: ProfileDataModel(),
    dataFetcher: BehaviorSubject<ProfileDataModel>());
PostContactSupportRx postContactSupportRxObj =
    PostContactSupportRx(empty: {}, dataFetcher: BehaviorSubject<Map>());
PostFeatureSuggestionRx postFeatureSuggestionRxObj =
    PostFeatureSuggestionRx(empty: {}, dataFetcher: BehaviorSubject<Map>());
PostBugReportRx postBugReportRxObj =
    PostBugReportRx(empty: {}, dataFetcher: BehaviorSubject<Map>());
EditProfileRx editProfileRxObj =
    EditProfileRx(empty: {}, dataFetcher: BehaviorSubject<Map>());
GetFaqRx getFaqRxObj =
    GetFaqRx(empty: FaqModel(), dataFetcher: BehaviorSubject<FaqModel>());
ResendOtpRx resendOtpRxObj =
    ResendOtpRx(empty: {}, dataFetcher: BehaviorSubject<Map>());
DeleteAccountRx deleteAccountRxObj =
    DeleteAccountRx(empty: {}, dataFetcher: BehaviorSubject<Map>());
PostStoreReviewRx postStoreReviewRxObj =
    PostStoreReviewRx(empty: {}, dataFetcher: BehaviorSubject<Map>());
UpdateNotificationRx updateNotificationRxObj =
    UpdateNotificationRx(empty: {}, dataFetcher: BehaviorSubject<Map>());
GetNotificationSettingsRx getNotificationSettingsRxObj =
    GetNotificationSettingsRx(
        empty: NotificationSettingsModel(),
        dataFetcher: BehaviorSubject<NotificationSettingsModel>());
SocialLoginRX socialLoginRXObj = SocialLoginRX(
    empty: SocialLoginModel(),
    dataFetcher: BehaviorSubject<SocialLoginModel>());

GetLessonRX getLessonRXObj = GetLessonRX(
  empty: GetLessonResponseModel(),
  dataFetcher: BehaviorSubject<GetLessonResponseModel>(),
);

GetLessonShowRX getLessonShowRXObj = GetLessonShowRX(
  empty: GetLessonShowResponseModel(),
  dataFetcher: BehaviorSubject<GetLessonShowResponseModel>(),
);


GetLessonSummaryRX getLessonSummaryRXObj = GetLessonSummaryRX(
  empty: GetLessonSummaryResponseModel(),
  dataFetcher: BehaviorSubject<GetLessonSummaryResponseModel>(),
);


GetLessonQuizRX getLessonQuizRXObj = GetLessonQuizRX(
  empty: GetLessonQuizResponseModel(),
  dataFetcher: BehaviorSubject<GetLessonQuizResponseModel>(),
);


GetProgressRX getProgressRXObj = GetProgressRX(
  empty: GetProgressResponseModel(),
  dataFetcher: BehaviorSubject<GetProgressResponseModel>(),
);


LessonCompletedRx lessonCompletedRxObj =
    LessonCompletedRx(empty: {}, dataFetcher: BehaviorSubject<Map>());

SubmitAnswerRx submitAnswerRxObj =
    SubmitAnswerRx(
      empty: {},
      dataFetcher: BehaviorSubject<Map<String, dynamic>>(),
    );

NextLessonRx nextLessonRxObj =
    NextLessonRx(empty: {}, dataFetcher: BehaviorSubject<Map>());
