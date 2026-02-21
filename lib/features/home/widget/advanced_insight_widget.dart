import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leemcwest/assets_helper/app_colors.dart';
import 'package:leemcwest/assets_helper/app_fonts.dart';
import 'package:leemcwest/helpers/ui_helpers.dart';

class AdvancedInsightWidget extends StatelessWidget {
  final String title;
  final String subTitle;
  final String backgroundImage;
  const AdvancedInsightWidget({
    super.key, 
    required this.title, 
    required this.subTitle, 
    required this.backgroundImage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.sp),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        image:  DecorationImage(
            image: AssetImage(backgroundImage),
            fit: BoxFit.cover),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextFontStyle.textStyle14w400c6A7282
                .copyWith(color: AppColors.c1A1A1A, fontSize: 20.sp),
          ),
          UIHelper.verticalSpace(12.h),
          Text(
            subTitle,
            style: TextFontStyle.textStyle14w400c6A7282
                .copyWith(color: AppColors.c6B7280, fontSize: 16.sp)
          ),
        ],
      ),
    );
  }
}
