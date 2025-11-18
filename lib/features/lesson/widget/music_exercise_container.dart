import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leemcwest/assets_helper/app_colors.dart';
import 'package:leemcwest/assets_helper/app_fonts.dart';
import 'package:leemcwest/assets_helper/app_image.dart';
import 'package:leemcwest/features/lesson/widget/free_container.dart';
import 'package:leemcwest/features/lesson/widget/lesson_btn.dart';
import 'package:leemcwest/features/lesson/widget/lesson_number.dart';
import 'package:leemcwest/helpers/ui_helpers.dart';

class MusicExerciseContainer extends StatelessWidget {
  final int lessonNumber;
  final String title;
  final void Function()? onTapLesson;
  const MusicExerciseContainer({
    super.key,
    required this.lessonNumber,
    required this.title,
    this.onTapLesson,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.sp),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        color: AppColors.cFFFFFF,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                   LessonNumber(
                    lessonNumber: lessonNumber,
                  ),
                  UIHelper.horizontalSpace(8.w),
                  Text(
                    title,
                    style: TextFontStyle.headlineCinzel24w500cFFFFFF
                        .copyWith(
                      color: AppColors.c0A0E1A,
                      fontSize: 16.sp,
                    ),
                  ),
                ],
              ),
              const FreeContainer(),
            ],
          ),
          UIHelper.verticalSpace(18.h),
          Center(
            child: Image.asset(
              AppImages.classicalSheet,
              width: 242.w,
            ),
          ),
          UIHelper.verticalSpace(15.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              LessonBtn(
                onTapLesson: onTapLesson,
              ),
            ],
          )
        ],
      ),
    );
  }
}