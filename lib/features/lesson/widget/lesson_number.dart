import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leemcwest/assets_helper/app_colors.dart';
import 'package:leemcwest/assets_helper/app_fonts.dart';

class LessonNumber extends StatelessWidget {
  final int lessonNumber;
  const LessonNumber({
    super.key,
    required this.lessonNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: 10.w, vertical: 6.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.r),
        color: AppColors.c0F1835.withOpacity(0.08),
      ),
      child: Text(
        'Lesson $lessonNumber',
        style: TextFontStyle.textStyle14w400c6A7282.copyWith(
          color: AppColors.c0F1835,
          fontSize: 12.sp,
        ),
      ),
    );
  }
}
