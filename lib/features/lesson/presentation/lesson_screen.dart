import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leemcwest/assets_helper/app_colors.dart';
import 'package:leemcwest/assets_helper/app_fonts.dart';
import 'package:leemcwest/features/lesson/widget/music_exercise_container.dart';
import 'package:leemcwest/helpers/all_routes.dart';
import 'package:leemcwest/helpers/navigation_service.dart';
import 'package:leemcwest/helpers/ui_helpers.dart';

class LessonScreen extends StatefulWidget {
  const LessonScreen({super.key});

  @override
  State<LessonScreen> createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cF9FAFB,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.cFFFFFF,
        automaticallyImplyLeading: false,
        title: Center(
          child: Text(
            'Lesson',
            style: TextFontStyle.headlineCinzel24w700cFFFFFF.copyWith(
              color: AppColors.onboardingButtonColor,
              fontSize: 18.sp,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              UIHelper.verticalSpace(22.h),
              Text(
                'All Lessons',
                style: TextFontStyle.headlineCinzel24w700cFFFFFF.copyWith(
                  fontSize: 16.sp,
                  color: AppColors.c0F1835,
                ),
              ),
              UIHelper.verticalSpace(16.h),
              MusicExerciseContainer(
                onTapLesson: (){
                  NavigationService.navigateTo(Routes.lessonDescription);
                },
                lessonNumber: 1,
                title: 'Scale Degrees',
              ),
              UIHelper.verticalSpace(16.h),
              MusicExerciseContainer(
                onTapLesson: (){},
                lessonNumber: 2,
                title: 'Major Scales',
              ),
              UIHelper.verticalSpace(16.h),
              MusicExerciseContainer(
                onTapLesson: (){},
                lessonNumber: 3,
                title: 'Minor Scales',
              ),
            ],
          ),
        ),
      ),
    );
  }
}