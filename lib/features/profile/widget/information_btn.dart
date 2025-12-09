import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leemcwest/assets_helper/app_colors.dart';
import 'package:leemcwest/assets_helper/app_fonts.dart';
import 'package:leemcwest/helpers/ui_helpers.dart';

class InformationBtn extends StatelessWidget {
  final IconData icon;
  final String text;
  final void Function()? onTap;
  const InformationBtn({
    super.key,
    required this.icon,
    required this.text,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding:
            EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.r),
          color: Colors.transparent,
          border: Border.all(
            color: AppColors.cD1D5DC,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             Icon(
              icon,
              weight: 11.w,
            ),
            UIHelper.horizontalSpace(8.w),
            Text(
              text,
              style: TextFontStyle.textStyle14w400c6A7282.copyWith(
                color: AppColors.c134074,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
