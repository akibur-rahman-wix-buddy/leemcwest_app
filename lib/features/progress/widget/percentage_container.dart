import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leemcwest/assets_helper/app_colors.dart';
import 'package:leemcwest/assets_helper/app_fonts.dart';
import 'package:leemcwest/features/progress/widget/percentage_circular_progress.dart';
import 'package:leemcwest/helpers/ui_helpers.dart';
class PercentageContainer extends StatelessWidget {
  final String text1;
  final String text2;
  final double percentage;
  const PercentageContainer({
    super.key,
    required this.text1,
    required this.text2, 
    required this.percentage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          EdgeInsets.symmetric(vertical: 12.h, horizontal: 8.w),
      decoration: BoxDecoration(
        color: AppColors.cFFFFFF,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
           PercentageCircularProgress(
            percentage: percentage,
            size: 48,
          ),
          UIHelper.horizontalSpace(4.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                text1,
                style: TextFontStyle.textStyle14w400c6A7282
                    .copyWith(
                  color: AppColors.c081B31,
                  fontSize: 12.sp,
                ),
              ),
              UIHelper.verticalSpace(8.h),
              Text(
                text2,
                style: TextFontStyle.textStyle16w500c6A7282,
              ),
            ],
          )
        ],
      ),
    );
  }
}
