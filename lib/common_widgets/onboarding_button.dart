// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leemcwest/assets_helper/app_colors.dart';
import 'package:leemcwest/assets_helper/app_fonts.dart';

class OnboardingButton extends StatelessWidget {
  void Function()? onTap;
  String text;
  OnboardingButton({super.key, this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        // padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 22.w),
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          color: AppColors.onboardingButtonColor,
        ),
        child: Text(
          text,
          style: TextFontStyle.headlinePoppins60016.copyWith(
            color: AppColors.cFFFFFF,
          ),
        ),
      ),
    );
  }
}
