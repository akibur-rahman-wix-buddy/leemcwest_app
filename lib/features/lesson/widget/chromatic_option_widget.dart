import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leemcwest/assets_helper/app_colors.dart';
import 'package:leemcwest/assets_helper/app_fonts.dart';
class ChromaticOptionWidget extends StatelessWidget {
  final String option;
  const ChromaticOptionWidget({
    super.key, 
    required this.option,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: AppColors.cF3F4F6,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Text(
        option,
        style: TextFontStyle.textStyle14w500c6A7282.copyWith(
          color: AppColors.c061426,
        ),
      ),
    );
  }
}
