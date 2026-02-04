import 'package:leemcwest/provider/auth_provider.dart';
import 'package:leemcwest/provider/onboarding_provider.dart';
import 'package:provider/provider.dart';


var providers = [

  ChangeNotifierProvider<OnboardingProvider>(create: (context) => OnboardingProvider()),
  ChangeNotifierProvider<AuthProvider>(create: (context) => AuthProvider()),

];
