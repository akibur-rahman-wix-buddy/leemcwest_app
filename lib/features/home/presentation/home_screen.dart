import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:leemcwest/assets_helper/app_colors.dart';
import 'package:leemcwest/assets_helper/app_fonts.dart';
import 'package:leemcwest/assets_helper/app_icons.dart';
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
                title: 'Home',
                subTitle: '',
                onTapNotification: () {
                  NavigationService.navigateTo(Routes.notification);
                },
                url: '',
                menuTap: () {
                  showMenu(
                    context: context,
                    position: const RelativeRect.fromLTRB(0, 0, 100, 100),
                    items: [
                      PopupMenuItem(
                        onTap: () {
                          NavigationService.navigateTo(Routes.introScreen);
                        },
                        child: _menuItem(AppIcons.homeMenu, "Home"),
                      ),
                      PopupMenuItem(
                        onTap: () {},
                        child: _menuItem(AppIcons.membership, "Membership"),
                      ),
                      PopupMenuItem(
                        onTap: () {},
                        child: _menuItem(AppIcons.setting, "Settings"),
                      ),
                      PopupMenuItem(
                        onTap: () {},
                        child: _menuItem(AppIcons.userGuid, "User Guide"),
                      ),
                      PopupMenuItem(
                        onTap: () {},
                        child: _menuItem(AppIcons.support, "Support"),
                      ),
                    ],
                  );
                }),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                children: [
                  UIHelper.verticalSpace(22.h),
                  MusicInfoContainer(
                    title: 'Guided Lessons ',
                    subTitle:
                        'Begin your journey through Functional Numeric Harmony. These lessons build perceptual understanding step by step teaching you how harmony behaves in time.',
                    imagePath: AppImages.homeBackOne,
                    btnText: 'Start Lesson',
                    onTap: () {
                      NavigationService.navigateToWithArgs(
                        Routes.navigation,
                        {'pageNum': 1},
                      );
                    },
                  ),
                  UIHelper.verticalSpace(22.h),
                  MusicInfoContainer(
                    title: 'Core Studies ',
                    subTitle:
                        'The complete FNH theory, organised as clear chapters. Use this as your reference library for definitions, principles and deeper explanations behind the system',
                    imagePath: AppImages.homeBackOne,
                    btnText: 'Start Building',
                    onTap: () {},
                  ),
                  UIHelper.verticalSpace(22.h),
                  MusicInfoContainer(
                    title: 'Functional Era Training ',
                    subTitle:
                        'Train your ear to recognise harmonic gravity. Learn to hear functional roles and feel how music leans, suspends and resolves.',
                    imagePath: AppImages.homeBackOne,
                    btnText: 'Start Training',
                    onTap: () {},
                  ),
                  UIHelper.verticalSpace(22.h),
                  MusicInfoContainer(
                    title: 'Advanced Insights ',
                    subTitle:
                        'Ideal for analysts and advanced learners. Explore deeper logic behind Functional Numeric Harmony, revealing why harmony behaves the way it does. ',
                    imagePath: AppImages.homeBackOne,
                    btnText: 'Discover More',
                    onTap: () {},
                  ),
                  UIHelper.verticalSpace(22.h),
                  MusicInfoContainer(
                    title: 'Case Studies ',
                    subTitle:
                        'See FNH applied to real music and compositions. Analyse how functional flow shapes structure, tension and release across genres and styles.',
                    imagePath: AppImages.homeBackOne,
                    btnText: 'Explore Studies',
                    onTap: () {
                      NavigationService.navigateTo(Routes.multiScreenPage);
                    },
                  ),
                  UIHelper.verticalSpace(22.h),
                  MusicInfoContainer(
                    title: 'Songwriting Lab ',
                    subTitle:
                        'Learn how to write your own music. With guided tools and templates that help you experiment, develop ideas and shape complete songs with FNH concepts.',
                    imagePath: AppImages.homeBackOne,
                    btnText: 'Start Writing',
                    onTap: () {
                      NavigationService.navigateTo(
                          Routes.clientNavigationsBarScreen);
                    },
                  ),
                  // UIHelper.verticalSpace(22.h),
                  // MusicInfoContainer(
                  //   title: 'Learn Lesson',
                  //   subTitle:
                  //       'Pick up right where you left off and keep your flow strong.',
                  //   imagePath: AppImages.homeBackOne,
                  //   btnText: 'Start Lesson',
                  //   onTap: () {
                  //     NavigationService.navigateToWithArgs(
                  //       Routes.navigation,
                  //       {'pageNum': 1},
                  //     );
                  //   },
                  // ),
                  // UIHelper.verticalSpace(10.h),
                  // MusicInfoContainer(
                  //   title: 'Core Theory',
                  //   subTitle:
                  //       'Core Theory - Read the foundational framework behind Functional Harmonic Theory.',
                  //   imagePath: AppImages.homeBackOne,
                  //   btnText: 'Start Lesson',
                  //   onTap: () {
                  //     NavigationService.navigateTo(Routes.coreTheory);
                  //   },
                  // ),
                  // UIHelper.verticalSpace(10.h),
                  // MusicInfoContainer(
                  //   title: 'Composition Builder',
                  //   subTitle:
                  //       'Pick up right where you left off and keep your flow strong.',
                  //   imagePath: AppImages.homeBackOne,
                  //   btnText: 'Start Lesson',
                  //   onTap: () {
                  //     NavigationService.navigateTo(
                  //         Routes.compositionBuilderScreen);
                  //   },
                  // ),
                  // UIHelper.verticalSpace(10.h),
                  // MusicInfoContainer(
                  //   title: 'Functional Ear Training',
                  //   subTitle:
                  //       'Hear the gravity and feel where the music flows. Develop instinctive recognition of functional motion: T, S, D, D#, D♭ relationships.',
                  //   imagePath: AppImages.homeBackOne,
                  //   btnText: 'Start',
                  //   onTap: () {
                  //     NavigationService.navigateTo(Routes.earTrainingLevel);
                  //   },
                  // ),
                  // UIHelper.verticalSpace(10.h),
                  // MusicInfoContainer(
                  //   title: 'Advanced Insights',
                  //   subTitle:
                  //       'Explore the deeper logic and discoveries behind Functional Harmonic Theory. Uncover what traditional theory left out',
                  //   imagePath: AppImages.homeBackOne,
                  //   btnText: 'Discover More',
                  //   onTap: () {
                  //     NavigationService.navigateTo(Routes.advancedInsights);
                  //   },
                  // ),
                  // UIHelper.verticalSpace(10.h),
                  // MusicInfoContainer(
                  //   title: 'Case Study Analysis',
                  //   subTitle:
                  //       'See FHT applied in real music. Analyse how harmonic flow shapes great compositions.',
                  //   imagePath: AppImages.homeBackOne,
                  //   btnText: 'Coming Soon',
                  // ),
                  // UIHelper.verticalSpace(10.h),
                  // MusicInfoContainer(
                  //   title: 'Songwriting Lab',
                  //   subTitle:
                  //       'Craft songs using FHT’s functional flow — guided templates and creative tools coming soon..',
                  //   imagePath: AppImages.homeBackOne,
                  //   btnText: 'Coming Soon',
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _menuItem(String icon, String title) {
  return Row(
    children: [
      SvgPicture.asset(icon),
      SizedBox(width: 12),
      Text(
        title,
        style: TextFontStyle.textStyle14w400c0A2340,
      ),
    ],
  );
}
