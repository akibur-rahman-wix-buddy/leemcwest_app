import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leemcwest/assets_helper/app_colors.dart';
import 'package:leemcwest/assets_helper/app_fonts.dart';
class OptionWidget extends StatelessWidget {
  final String text;
  final Color? bgColor;
  final Color? borderColor;
  const OptionWidget({
    super.key,
    required this.text,
    this.bgColor, 
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        color: bgColor ?? AppColors.cFEF2F2,
        border: Border.all(
          color: borderColor ?? AppColors.cFB2C3680.withOpacity(0.5),
        ),
      ),
      child: Center(
        child: Text(
          text,
          style: TextFontStyle.textStyle12w400c64748B.copyWith(
            color: AppColors.c061426,
          ),
        ),
      ),
    );
  }
}
