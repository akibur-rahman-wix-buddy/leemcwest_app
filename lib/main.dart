// ignore_for_file: unused_label

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:leemcwest/assets_helper/app_colors.dart';
import 'package:leemcwest/constants/custome_theme.dart';
import 'package:leemcwest/helpers/all_routes.dart';
import 'package:provider/provider.dart';
import 'helpers/di.dart';
import 'helpers/helper_methods.dart';
import 'helpers/navigation_service.dart';
import 'helpers/register_provider.dart';
import 'loading_screen.dart';
import 'networks/dio/dio.dart';
import 'networks/internet_checker/internet_checker_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(InternetController(), permanent: true);
  await GetStorage.init();
  diSetup();
  DioSingleton.instance.create();

  runApp(
    MultiProvider(
      providers: providers,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    rotation();
    theme: ThemeData(
                primarySwatch: CustomTheme.kToDark,
                useMaterial3: false,
                scaffoldBackgroundColor: AppColors.cFFFFFF);
    setInitValue();
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) async {
        showMaterialDialog(context);
      },
      child: LayoutBuilder(
        builder: (context, constraints) {
          return const UtillScreenMobile();
        },
      ),
    );
  }
}

class UtillScreenMobile extends StatelessWidget {
  const UtillScreenMobile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          builder: (context, widget) {
            return MediaQuery(
              data: MediaQuery.of(context),
              child: widget!,
            );
          },
          navigatorKey: NavigationService.navigatorKey,
          onGenerateRoute: RouteGenerator.generateRoute,
          home: const Loading(),
          // home: const AppOnboardingSeventeenScreen(),


        );
      },
    );
  }
}
