import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leemcwest/assets_helper/app_colors.dart';
import 'package:leemcwest/assets_helper/app_image.dart';
import 'package:leemcwest/common_widgets/custom_navigation_appbar_duplicate.dart';
import 'package:leemcwest/features/home/widget/music_info_container.dart';
import 'package:leemcwest/helpers/all_routes.dart';
import 'package:leemcwest/helpers/navigation_service.dart';
import 'package:leemcwest/helpers/ui_helpers.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cEEF3ED,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            //UIHelper.verticalSpace(45.h),
            CustomNavigationAppbarDuplicate(
              title: 'Home FHT',
              subTitle: '',
              onTapNotification: () {
                NavigationService.navigateTo(Routes.notification);
              },
              url: '',
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                children: [
                  UIHelper.verticalSpace(22.h),
                  MusicInfoContainer(
                    title: 'Learn Lesson',
                    subTitle:
                        'Pick up right where you left off and keep your flow strong.',
                    imagePath: AppImages.homeBackOne,
                    btnText: 'Start Lesson',
                    onTap: () {
                      NavigationService.navigateTo(
                          Routes.compositionBuilderScreen);
                    },
                  ),
                  UIHelper.verticalSpace(10.h),
                  MusicInfoContainer(
                    title: 'Core Theory',
                    subTitle:
                        'Core Theory - Read the foundational framework behind Functional Harmonic Theory.',
                    imagePath: AppImages.homeBackOne,
                    btnText: 'Start Lesson',
                    onTap: () {
                      NavigationService.navigateTo(Routes.coreTheory);
                    },
                  ),
                  UIHelper.verticalSpace(10.h),
                  MusicInfoContainer(
                    title: 'Composition Builder',
                    subTitle:
                        'Pick up right where you left off and keep your flow strong.',
                    imagePath: AppImages.homeBackOne,
                    btnText: 'Start Lesson',
                  ),
                  UIHelper.verticalSpace(10.h),
                  MusicInfoContainer(
                    title: 'Functional Ear Training',
                    subTitle:
                        'Hear the gravity and feel where the music flows. Develop instinctive recognition of functional motion: T, S, D, D#, D♭ relationships.',
                    imagePath: AppImages.homeBackOne,
                    btnText: 'Start',
                    onTap: () {
                      NavigationService.navigateTo(Routes.earTrainingLevel);
                    },
                  ),
                  UIHelper.verticalSpace(10.h),
                  MusicInfoContainer(
                    title: 'Advanced Insights',
                    subTitle:
                        'Explore the deeper logic and discoveries behind Functional Harmonic Theory. Uncover what traditional theory left out',
                    imagePath: AppImages.homeBackOne,
                    btnText: 'Discover More',
                    onTap: () {
                      NavigationService.navigateTo(Routes.advancedInsights);
                    },
                  ),
                  UIHelper.verticalSpace(10.h),
                  MusicInfoContainer(
                    title: 'Case Study Analysis',
                    subTitle:
                        'See FHT applied in real music. Analyse how harmonic flow shapes great compositions.',
                    imagePath: AppImages.homeBackOne,
                    btnText: 'Coming Soon',
                  ),
                  UIHelper.verticalSpace(10.h),
                  MusicInfoContainer(
                    title: 'Songwriting Lab',
                    subTitle:
                        'Craft songs using FHT’s functional flow — guided templates and creative tools coming soon..',
                    imagePath: AppImages.homeBackOne,
                    btnText: 'Coming Soon',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
