import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leemcwest/assets_helper/app_colors.dart';
import 'package:leemcwest/assets_helper/app_fonts.dart';

class ChromaticAnswerWidget extends StatelessWidget {
  final String? answer;
  final Color? borderColor;
  const ChromaticAnswerWidget({
    super.key, 
    this.answer, 
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
      decoration:  BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.cF3F4F6,
        border: Border.all(
          color: borderColor ?? AppColors.c134074,
        )
      ),
      child: Text(
        answer ?? '',
        style: TextFontStyle.textStyle14w500c6A7282.copyWith(
          color: AppColors.c134074,
        ),
      ),
    );
  }
}