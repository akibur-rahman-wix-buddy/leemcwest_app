import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leemcwest/assets_helper/app_colors.dart';
import 'package:leemcwest/assets_helper/app_fonts.dart';
import 'package:leemcwest/helpers/ui_helpers.dart';

class LessonGradeWidget extends StatelessWidget {
  final String title;
  final int grade;
  final String subtitle;
  const LessonGradeWidget({
    super.key,
    required this.title,
    required this.grade,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 12.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: AppColors.cEDBFF,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextFontStyle.textStyle14w400c6A7282.copyWith(
                  fontSize: 16.sp,
                  color: AppColors.c0A0E1A,
                ),
              ),
              Text(
                "${grade.toString()}%",
                style: TextFontStyle.textStyle14w500c6A7282
                    .copyWith(color: AppColors.c3DD983),
              ),
            ],
          ),
          UIHelper.verticalSpace(8.h),
          Text(
            subtitle,
            style: TextFontStyle.textStyle14w400c6A7282.copyWith(
              fontSize: 16.sp,
            ),
          ),
          UIHelper.verticalSpace(24.h),
          LinearProgressIndicator(
            value: 1.0,
            backgroundColor: AppColors.c64748B,
            valueColor: const AlwaysStoppedAnimation<Color>(
              AppColors.c134074,
            ),
            minHeight: 8.h,
          ),
        ],
      ),
    );
  }
}
