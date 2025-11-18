import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leemcwest/assets_helper/app_colors.dart';
import 'package:leemcwest/assets_helper/app_fonts.dart';

class FreeContainer extends StatelessWidget {
  const FreeContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.sp),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40.r),
        color: AppColors.c20B80C.withOpacity(0.08),
      ),
      child: Text(
        'Free',
        style: TextFontStyle.textStyle14w400c6A7282.copyWith(
          fontSize: 12.sp,
          color: AppColors.c20B80C,
        ),
      ),
    );
  }
}
