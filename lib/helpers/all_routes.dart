import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:leemcwest/features/authentication/password/presentation/change_password_screen.dart';
import 'package:leemcwest/features/authentication/password/presentation/create_password_screen.dart';
import 'package:leemcwest/features/authentication/password/presentation/forgot_password_screen.dart';
import 'package:leemcwest/features/authentication/password/presentation/password_reset_otp_screen.dart';
import 'package:leemcwest/features/authentication/sign_in/presentation/sign_in_screen.dart';
import 'package:leemcwest/features/authentication/sign_up/presentation/sign_up_screen.dart';
import 'package:leemcwest/features/authentication/verification/presentation/otp_verification_screen.dart';
import 'package:leemcwest/features/composition_builder/presentation/composition_builder_screen.dart';
import 'package:leemcwest/features/home/presentation/advanced_insight_screen.dart';
import 'package:leemcwest/features/home/presentation/beginer_ear_training_screen.dart';
import 'package:leemcwest/features/home/presentation/core_theory_screen.dart';
import 'package:leemcwest/features/home/presentation/ear_training_level_screen.dart';
import 'package:leemcwest/features/home/presentation/ear_training_quiz_screen.dart';
import 'package:leemcwest/features/home/presentation/ear_training_screen.dart';
import 'package:leemcwest/features/home/presentation/ear_training_theory_screen.dart';
import 'package:leemcwest/features/home/presentation/ear_training_transition_screen.dart';
import 'package:leemcwest/features/home/presentation/functional_ear_training_screen.dart';
import 'package:leemcwest/features/home/presentation/notification_screen.dart';
import 'package:leemcwest/features/lesson/presentation/lesson_description_screen.dart';
import 'package:leemcwest/features/lesson/presentation/lesson_fade_screen.dart';
import 'package:leemcwest/features/lesson/presentation/lesson_summary_screen.dart';
import 'package:leemcwest/features/lesson/presentation/next_level_quiz_screen.dart';
import 'package:leemcwest/features/lesson/presentation/quiz_screen.dart';
import 'package:leemcwest/features/profile/presentation/about_fht_screen.dart';
import 'package:leemcwest/features/profile/presentation/edit_profile_screen.dart';
import 'package:leemcwest/features/profile/presentation/faq_screen.dart';
import 'package:leemcwest/features/profile/presentation/glossary_screen.dart';
import 'package:leemcwest/features/profile/presentation/manage_account_screen.dart';
import 'package:leemcwest/features/profile/presentation/push_notification_screen.dart';
import 'package:leemcwest/features/profile/presentation/saved_work_screen.dart';
import 'package:leemcwest/features/profile/presentation/user_guide_screen.dart';
import 'package:leemcwest/features/support/presentation/contact_support_screen.dart';
import 'package:leemcwest/features/support/presentation/report_a_bug_screen.dart';
import 'package:leemcwest/features/support/presentation/suggest_a_feature_screen.dart';
import 'package:leemcwest/features/support/presentation/support_screen.dart';
import 'package:leemcwest/features/support/presentation/terms_use_screen.dart';
import 'package:leemcwest/navigation_screen.dart';



final class Routes {
  static final Routes _routes = Routes._internal();

  Routes._internal();

  static Routes get instance => _routes;

  static const String signUp = '/signUp';
  static const String signIn = '/signIn';
  static const String otpVerification = '/otpVerification';
  static const String forgotPassword = '/forgotPassword';
  static const String createPassword = '/createPassword';
  static const String earTraining = '/earTraining';
  static const String navigation = '/navigation';
  static const String functionalEarTraining = '/functionalEarTraining';
  static const String lessonDescription = '/lessonDescription';
  static const String quiz = '/quiz';
  static const String savedWork = '/savedWork';
  static const String notification = '/notification';
  static const String faq = '/faq';
  static const String userGuide = '/userGuide';
  static const String glossary = '/glossary';
  static const String aboutFht = '/aboutFht';
  static const String pushNotification = '/pushNotification';
  static const String manageAccount = '/manageAccount';
  static const String support = '/support';
  static const String contactSupport = '/contactSupport';
  static const String reportabug = '/reportabug';
  static const String suggestafeature = '/suggestafeature';
  static const String lessonSummary = '/lessonSummary';
  static const String editProfile = '/editProfile';
  static const String termsUse = '/termsUse';
  static const String advancedInsights = '/advancedInsights';
  static const String earTrainingLevel = '/earTrainingLevel';
  static const String coreTheory = '/coreTheory';
  static const String lessonFade = '/lessonFade';
  static const String beginerEarTraining = '/beginerEarTraining';
  static const String earTrainingTransition = '/earTrainingTransition';
  static const String earTrainingTheory = '/earTrainingTheory';
  static const String earTrainingQuiz = '/earTrainingQuiz';
  static const String nextLevelQuiz = '/nextLevelQuiz';
  static const String resetPasswordOtp = '/resetPasswordOtp';
  static const String changePassword = '/changePassword';
  static const String compositionBuilderScreen = '/CompositionBuilderScreen';
  
}

final class RouteGenerator {
  static final RouteGenerator _routeGenerator = RouteGenerator._internal();

  RouteGenerator._internal();

  static RouteGenerator get instance => _routeGenerator;

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.signUp:
        if (Platform.isAndroid) {
          return FadedTransitionRoute(
              widget: const SignUpScreen(), settings: settings);
        } else {
          return CupertinoPageRoute(
              builder: (context) => const SignUpScreen());
        }
      case Routes.signIn:
        if (Platform.isAndroid) {
          return FadedTransitionRoute(
              widget: const SignInScreen(), settings: settings);
        } else {
          return CupertinoPageRoute(
              builder: (context) => const SignInScreen());
        }

      case Routes.otpVerification:
      Map args = settings.arguments as Map;
        if (Platform.isAndroid) {
          return FadedTransitionRoute(
              widget: OtpVerificationScreen(
                email: args["email"],
              ), settings: settings);
        } else {
          return CupertinoPageRoute(
              builder: (context) =>  OtpVerificationScreen(
                email: args["email"], 
              ));
        }

      case Routes.forgotPassword:
        if (Platform.isAndroid) {
          return FadedTransitionRoute(
              widget: const ForgotPasswordScreen(), settings: settings);
        } else {
          return CupertinoPageRoute(
              builder: (context) => const ForgotPasswordScreen());
        }

      case Routes.createPassword:
        if (Platform.isAndroid) {
          return FadedTransitionRoute(
              widget: const CreatePasswordScreen(), settings: settings);
        } else {
          return CupertinoPageRoute(
              builder: (context) => const CreatePasswordScreen());
        }

      case Routes.earTraining:
        if (Platform.isAndroid) {
          return FadedTransitionRoute(
              widget: const EarTrainingScreen(), settings: settings);
        } else {
          return CupertinoPageRoute(
              builder: (context) => const EarTrainingScreen());
        }

      case Routes.navigation:
        if (Platform.isAndroid) {
          return FadedTransitionRoute(
              widget: const NavigationsBarScreen(), settings: settings);
        } else {
          return CupertinoPageRoute(
              builder: (context) => const NavigationsBarScreen());
        }
      case Routes.functionalEarTraining:
        if (Platform.isAndroid) {
          return FadedTransitionRoute(
              widget: const FunctionalEarTrainingScreen(), settings: settings);
        } else {
          return CupertinoPageRoute(
              builder: (context) => const FunctionalEarTrainingScreen());
        }


        //  case Routes.partsDetailsScreen:
        // Map args = settings.arguments as Map;
        // return Platform.isAndroid
        //     ? _FadedTransitionRoute(
        //         widget: PartsDetailsScreen(id: args['id']), settings: settings)
        //     : CupertinoPageRoute(
        //         builder: (context) => PartsDetailsScreen(id: args['id']));



      case Routes.lessonDescription:
      Map args = settings.arguments as Map;
        if (Platform.isAndroid) {
          return FadedTransitionRoute(
              widget:  LessonDescriptionScreen(id: args['id']), settings: settings);
        } else {
          return CupertinoPageRoute(
              builder: (context) =>  LessonDescriptionScreen(id: args['id']));
        }
      case Routes.quiz:
        if (Platform.isAndroid) {
          return FadedTransitionRoute(
              widget: const QuizScreen(), settings: settings);
        } else {
          return CupertinoPageRoute(
              builder: (context) => const QuizScreen());
        }
      case Routes.savedWork:
        if (Platform.isAndroid) {
          return FadedTransitionRoute(
              widget: const SavedWorkScreen(), settings: settings);
        } else {
          return CupertinoPageRoute(
              builder: (context) => const SavedWorkScreen());
        }

      case Routes.notification:
        if (Platform.isAndroid) {
          return FadedTransitionRoute(
              widget: const NotificationScreen(), settings: settings);
        } else {
          return CupertinoPageRoute(
              builder: (context) => const NotificationScreen());
        }

      case Routes.faq:
        if (Platform.isAndroid) {
          return FadedTransitionRoute(
              widget: const FaqScreen(), settings: settings);
        } else {
          return CupertinoPageRoute(
              builder: (context) => const FaqScreen());
        }

      case Routes.userGuide:
        if (Platform.isAndroid) {
          return FadedTransitionRoute(
              widget: const UserGuideScreen(), settings: settings);
        } else {
          return CupertinoPageRoute(
              builder: (context) => const UserGuideScreen());
        }

      case Routes.glossary:
        if (Platform.isAndroid) {
          return FadedTransitionRoute(
              widget: const GlossaryScreen(), settings: settings);
        } else {
          return CupertinoPageRoute(
              builder: (context) => const GlossaryScreen());
        }

      case Routes.aboutFht:
        if (Platform.isAndroid) {
          return FadedTransitionRoute(
              widget: const AboutFhtScreen(), settings: settings);
        } else {
          return CupertinoPageRoute(
              builder: (context) => const GlossaryScreen());
        }

      case Routes.pushNotification:
        if (Platform.isAndroid) {
          return FadedTransitionRoute(
              widget: const PushNotificationScreen(), settings: settings);
        } else {
          return CupertinoPageRoute(
              builder: (context) => const PushNotificationScreen());
        }

      case Routes.manageAccount:
        if (Platform.isAndroid) {
          return FadedTransitionRoute(
              widget: const ManageAccountScreen(), settings: settings);
        } else {
          return CupertinoPageRoute(
              builder: (context) => const ManageAccountScreen());
        }
      
      case Routes.support:
        if (Platform.isAndroid) {
          return FadedTransitionRoute(
              widget: const SupportScreen(), settings: settings);
        } else {
          return CupertinoPageRoute(
              builder: (context) => const SupportScreen());
        }
      case Routes.contactSupport:
        if (Platform.isAndroid) {
          return FadedTransitionRoute(
              widget: const ContactSupportScreen(), settings: settings);
        } else {
          return CupertinoPageRoute(
              builder: (context) => const ContactSupportScreen());
        }
      case Routes.reportabug:
        if (Platform.isAndroid) {
          return FadedTransitionRoute(
              widget: const ReportABugScreen(), settings: settings);
        } else {
          return CupertinoPageRoute(
              builder: (context) => const ReportABugScreen());
        }
      case Routes.suggestafeature:
        if (Platform.isAndroid) {
          return FadedTransitionRoute(
              widget: const SuggestAFeatureScreen(), settings: settings);
        } else {
          return CupertinoPageRoute(
              builder: (context) => const SuggestAFeatureScreen());
        }
      case Routes.lessonSummary:
        if (Platform.isAndroid) {
          return FadedTransitionRoute(
              widget: const LessonSummaryScreen(), settings: settings);
        } else {
          return CupertinoPageRoute(
              builder: (context) => const LessonSummaryScreen());
        }
      case Routes.editProfile:
        if (Platform.isAndroid) {
          return FadedTransitionRoute(
              widget: const EditProfileScreen(), settings: settings);
        } else {
          return CupertinoPageRoute(
              builder: (context) => const EditProfileScreen());
        }

      case Routes.termsUse:
        if (Platform.isAndroid) {
          return FadedTransitionRoute(
              widget: const TermsUseScreen(), settings: settings);
        } else {
          return CupertinoPageRoute(
              builder: (context) => const TermsUseScreen());
        }

      case Routes.advancedInsights:
        if (Platform.isAndroid) {
          return FadedTransitionRoute(
              widget: const AdvancedInsightScreen(), settings: settings);
        } else {
          return CupertinoPageRoute(
              builder: (context) => const AdvancedInsightScreen());
        }

      case Routes.earTrainingLevel:
        if (Platform.isAndroid) {
          return FadedTransitionRoute(
              widget: const EarTrainingLevelScreen(), settings: settings);
        } else {
          return CupertinoPageRoute(
              builder: (context) => const EarTrainingLevelScreen());
        }

      case Routes.coreTheory:
        if (Platform.isAndroid) {
          return FadedTransitionRoute(
              widget: const CoreTheoryScreen(), settings: settings);
        } else {
          return CupertinoPageRoute(
              builder: (context) => const CoreTheoryScreen());
        }

      // case Routes.lessonFade:
      //   if (Platform.isAndroid) {
      //     return FadedTransitionRoute(
      //         widget: const LessonFadeScreen(), settings: settings);
      //   } else {
      //     return CupertinoPageRoute(
      //         builder: (context) => const LessonFadeScreen());
      //   }

      case Routes.beginerEarTraining:
        if (Platform.isAndroid) {
          return FadedTransitionRoute(
              widget: const BeginerEarTrainingScreen(), settings: settings);
        } else {
          return CupertinoPageRoute(
              builder: (context) => const BeginerEarTrainingScreen());
        }

      case Routes.earTrainingTransition:
        if (Platform.isAndroid) {
          return FadedTransitionRoute(
              widget: const EarTrainingTransitionScreen(), settings: settings);
        } else {
          return CupertinoPageRoute(
              builder: (context) => const EarTrainingTransitionScreen());
        }

      case Routes.earTrainingTheory:
        if (Platform.isAndroid) {
          return FadedTransitionRoute(
              widget: const EarTrainingTheoryScreen(), settings: settings);
        } else {
          return CupertinoPageRoute(
              builder: (context) => const EarTrainingTheoryScreen());
        }

      case Routes.earTrainingQuiz:
        if (Platform.isAndroid) {
          return FadedTransitionRoute(
              widget: const EarTrainingQuizScreen(), settings: settings);
        } else {
          return CupertinoPageRoute(
              builder: (context) => const EarTrainingQuizScreen());
        }

      case Routes.nextLevelQuiz:
        if (Platform.isAndroid) {
          return FadedTransitionRoute(
              widget: const NextLevelQuizScreen(), settings: settings);
        } else {
          return CupertinoPageRoute(
              builder: (context) => const NextLevelQuizScreen());
        }

      case Routes.resetPasswordOtp:
        if (Platform.isAndroid) {
          return FadedTransitionRoute(
              widget: const PasswordResetOtpScreen(), settings: settings);
        } else {
          return CupertinoPageRoute(
              builder: (context) => const PasswordResetOtpScreen());
        }

      case Routes.changePassword:
        if (Platform.isAndroid) {
          return FadedTransitionRoute(
              widget: const ChangePasswordScreen(), settings: settings);
        } else {
          return CupertinoPageRoute(
              builder: (context) => const ChangePasswordScreen());
        }
      
      case Routes.compositionBuilderScreen:
        if (Platform.isAndroid) {
          return FadedTransitionRoute(
              widget: const CompositionBuilderScreen(), settings: settings);
        } else {
          return CupertinoPageRoute(
              builder: (context) => const CompositionBuilderScreen());
        }
      

      default:
        return null;
    }
  }
}

class FadedTransitionRoute extends PageRouteBuilder {
  final Widget widget;
  @override
  final RouteSettings settings;

  FadedTransitionRoute({required this.widget, required this.settings})
      : super(
          settings: settings,
          reverseTransitionDuration: const Duration(milliseconds: 1),
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) {
            return widget;
          },
          transitionDuration: const Duration(milliseconds: 1),
          transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child) {
            return FadeTransition(
              opacity: CurvedAnimation(
                parent: animation,
                curve: Curves.ease,
              ),
              child: child,
            );
          },
        );
}

class ScreenTitle extends StatelessWidget {
  final Widget widget;

  const ScreenTitle({super.key, required this.widget});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: .5, end: 1),
      duration: const Duration(milliseconds: 500),
      curve: Curves.bounceIn,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: child,
        );
      },
      child: widget,
    );
  }
}
