import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:leemcwest/assets_helper/app_colors.dart';
import 'package:leemcwest/assets_helper/app_fonts.dart';
import 'package:leemcwest/assets_helper/app_icons.dart';
import 'package:leemcwest/helpers/ui_helpers.dart';

class LessonCompleteDialogue extends StatelessWidget {
  const LessonCompleteDialogue({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.cFFFFFF,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Padding(
        padding: EdgeInsets.all(24.sp),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "You've Completed Lesson 3!",
              style: TextFontStyle.textStyle14w400c6A7282.copyWith(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.onboardingButtonColor,
              ),
              textAlign: TextAlign.center,
            ),
            UIHelper.verticalSpace(8.h),
            Text(
              'Great progress - you\'re mastering the flow of Functional Harmony',
              style: TextFontStyle.textStyle14w400c6A7282,
              textAlign: TextAlign.center,
            ),
            UIHelper.verticalSpace(24.h),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                color: AppColors.onboardingButtonColor,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Proceed to next lesson',
                    style: TextFontStyle.headlinePoppins50014.copyWith(
                      color: AppColors.cFFFFFF,
                    ),
                  ),
                  UIHelper.horizontalSpace(4.w),
                  SvgPicture.asset(
                    AppIcons.forwardArrow,
                  ),
                ],
              ),
            ),
            UIHelper.verticalSpace(12.h),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                color: AppColors.c3DC699,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Start Quiz',
                    style: TextFontStyle.headlinePoppins50014.copyWith(
                      color: AppColors.cFFFFFF,
                    ),
                  ),
                  UIHelper.horizontalSpace(4.w),
                  SvgPicture.asset(
                    AppIcons.forwardArrow,
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
