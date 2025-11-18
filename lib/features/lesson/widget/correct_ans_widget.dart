import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leemcwest/assets_helper/app_colors.dart';
import 'package:leemcwest/assets_helper/app_fonts.dart';
import 'package:leemcwest/helpers/ui_helpers.dart';

class CorrectAnsWidget extends StatelessWidget {
  final String imagePath;
  final String imagePath2;
  final Color? borderColor;
  final Color? bgColor;
  const CorrectAnsWidget({
    super.key,
    required this.imagePath,
    required this.imagePath2,
    this.borderColor,
    this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(
          color: borderColor ?? AppColors.cFB2C36.withOpacity(0.5),
        ),
        color: bgColor ?? AppColors.cFEF2F2,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset(
                imagePath,
                width: 20.w,
              ),
              UIHelper.horizontalSpace(8.w),
              Text(
                'Retry Quiz',
                style: TextFontStyle.textStyle14w400c6A7282.copyWith(
                  color: AppColors.c061426,
                ),
              ),
            ],
          ),
          UIHelper.horizontalSpace(4.w),
          Image.asset(
            imagePath2,
            width: 24.w,
          ),
        ],
      ),
    );
  }
}