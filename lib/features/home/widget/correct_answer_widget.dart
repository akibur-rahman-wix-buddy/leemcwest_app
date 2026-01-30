import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leemcwest/assets_helper/app_colors.dart';
import 'package:leemcwest/assets_helper/app_fonts.dart';
import 'package:leemcwest/helpers/ui_helpers.dart';
class CorrectAnswerWidget extends StatelessWidget {
  final String answer;
  final String description;
  const CorrectAnswerWidget({
    super.key, 
    required this.answer,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          color: AppColors.cF0FDF4,
          border: Border.all(
            color: AppColors.c05DF72.withOpacity(0.5.r),
          )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Correct answer: $answer',
            style: TextFontStyle.textStyle16w400c6A7282.copyWith(
              color: AppColors.c0B4F4A,
            ),
          ),
          UIHelper.verticalSpace(16.h),
          Text(
            description,
            style: TextFontStyle.textStyle14w400c6A7282.copyWith(
              color: AppColors.c314158,
            ),
          ),
        ],
      ),
    );
  }
}
