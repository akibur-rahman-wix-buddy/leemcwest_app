import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leemcwest/assets_helper/app_colors.dart';
import 'package:leemcwest/assets_helper/app_image.dart';
import 'package:leemcwest/common_widgets/custom_home_appbar.dart';
import 'package:leemcwest/features/home/widget/music_info_container.dart';
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
                imagePath: AppImages.backgroundOne,
                btnText: 'Start Lesson',
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
                subTitle: 'Hear the gravity and feel where the music flows.',
                imagePath: AppImages.backgroundTwo
                ,
                btnText: 'Start',
                btnColor: AppColors.cFD9817,
              ),
              UIHelper.verticalSpace(10.h),
              MusicInfoContainer(
                title: 'Functional Ear Training',
                titleColor: AppColors.cFD9817,
                subTitle: 'Hear the gravity and feel where the music flows.',
                imagePath: AppImages.backgroundTwo
                ,
                btnText: 'Start',
                btnColor: AppColors.cFD9817,
              ),
              UIHelper.verticalSpace(10.h),
              MusicInfoContainer(
                title: 'Functional Ear Training',
                titleColor: AppColors.cFD9817,
                subTitle: 'Hear the gravity and feel where the music flows.',
                imagePath: AppImages.backgroundTwo
                ,
                btnText: 'Start',
                btnColor: AppColors.cFD9817,
              ),
              UIHelper.verticalSpace(10.h),
              MusicInfoContainer(
                title: 'Functional Ear Training',
                titleColor: AppColors.cFD9817,
                subTitle: 'Hear the gravity and feel where the music flows.',
                imagePath: AppImages.backgroundTwo
                ,
                btnText: 'Start',
                btnColor: AppColors.cFD9817,
              ),
            ],
          ),
        ),
      ),
    );
  }
}