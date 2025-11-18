import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leemcwest/assets_helper/app_colors.dart';
import 'package:leemcwest/assets_helper/app_fonts.dart';
import 'package:leemcwest/assets_helper/app_image.dart';
import 'package:leemcwest/helpers/ui_helpers.dart';

class LessonBtn extends StatelessWidget {
  final void Function()? onTapLesson;
  const LessonBtn({
    super.key,
    this.onTapLesson,
    
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapLesson,
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: 12.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: AppColors.onboardingButtonColor,
          borderRadius: BorderRadius.circular(4.r),
        ),
        child: Row(
          children: [
            Image.asset(
              AppImages.soundOff,
              width: 20.w,
            ),
            UIHelper.horizontalSpace(4.w),
            Text(
              'Start Lesson',
              style: TextFontStyle.headlinePoppins40014.copyWith(
                color: AppColors.cFFFFFF,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
