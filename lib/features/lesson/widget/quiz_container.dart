import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leemcwest/assets_helper/app_colors.dart';
import 'package:leemcwest/assets_helper/app_fonts.dart';
import 'package:leemcwest/features/lesson/widget/quiz_option.dart';
import 'package:leemcwest/helpers/ui_helpers.dart';

class QuizContainer extends StatelessWidget {
  const QuizContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.sp),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        color: AppColors.cFFFFFF,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '1.What is harmonic function?',
            style: TextFontStyle.textStyle14w500c6A7282.copyWith(
              fontSize: 16.sp,
              color: AppColors.c364153,
            ),
          ),
          UIHelper.verticalSpace(20.h),
          const QuizOption(),
          UIHelper.verticalSpace(16.h),
          const QuizOption(),
          UIHelper.verticalSpace(16.h),
          const QuizOption(),
          UIHelper.verticalSpace(16.h),
          const QuizOption(),
        ],
      ),
    );
  }
}