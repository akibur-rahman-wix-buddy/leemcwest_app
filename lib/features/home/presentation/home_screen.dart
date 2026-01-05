import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leemcwest/assets_helper/app_colors.dart';
import 'package:leemcwest/assets_helper/app_image.dart';
import 'package:leemcwest/common_widgets/custom_home_appbar.dart';
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
      backgroundColor: AppColors.cFFFFFF,
      appBar: CustomHomeAppbar(
        title: 'Home FHT',
        onTap: () {
          NavigationService.navigateTo(Routes.notification);
        },
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              UIHelper.verticalSpace(22.h),
              MusicInfoContainer(
                title: 'Learn Lesson',
                subTitle: 'Pick up right where you left off and keep your flow strong.',
                imagePath: AppImages.homeBackOne,
                btnText: 'Start Lesson',
              ),
              UIHelper.verticalSpace(10.h),
              MusicInfoContainer(
                title: 'Core Theory',
                titleColor: AppColors.c1FB2C9,
                subTitle: 'Core Theory - Read the foundational framework behind Functional Harmonic Theory.',
                imagePath: AppImages.homeBackTwo,
                btnText: 'Start Lesson',
                btnColor: AppColors.c1FB2C9,
              ),
              UIHelper.verticalSpace(10.h),
              MusicInfoContainer(
                title: 'Composition Builder',
                titleColor: AppColors.cF21173,
                subTitle: 'Pick up right where you left off and keep your flow strong.',
                imagePath: AppImages.backgroundTwo,
                btnText: 'Start Lesson',
                btnColor: AppColors.cF21173,
              ),
              UIHelper.verticalSpace(10.h),
              MusicInfoContainer(
                title: 'Functional Ear Training',
                titleColor: AppColors.cFD9817,
                subTitle: 'Hear the gravity and feel where the music flows. Develop instinctive recognition of functional motion: T, S, D, D#, D♭ relationships.',
                imagePath: AppImages.homeBackFour,
                btnText: 'Start',
                btnColor: AppColors.cFD9817,
                onTap: () {
                  NavigationService.navigateTo(Routes.functionalEarTraining);
                },
              ),
              UIHelper.verticalSpace(10.h),
              MusicInfoContainer(
                title: 'Advanced Insights',
                titleColor: AppColors.c46B054,
                subTitle: 'Explore the deeper logic and discoveries behind Functional Harmonic Theory. Uncover what traditional theory left out',
                imagePath: AppImages.homeBackFive,
                btnText: 'Discover More',
                btnColor: AppColors.c46B054,
                onTap: () {
                  NavigationService.navigateTo(Routes.advancedInsights);
                },
              ),
              UIHelper.verticalSpace(10.h),
              MusicInfoContainer(
                title: 'Case Study Analysis',
                titleColor: AppColors.c750FFE,
                subTitle: 'See FHT applied in real music. Analyse how harmonic flow shapes great compositions.',
                imagePath: AppImages.homeBackSix,
                btnText: 'Coming Soon',
                btnColor: AppColors.c750FFE,
              ),
              UIHelper.verticalSpace(10.h),
              MusicInfoContainer(
                title: 'Songwriting Lab',
                titleColor: AppColors.cFEBF30,
                subTitle: 'Craft songs using FHT’s functional flow — guided templates and creative tools coming soon..',
                imagePath: AppImages.homeBackSeven,
                btnText: 'Coming Soon',
                btnColor: AppColors.cFEBF30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}