import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leemcwest/assets_helper/app_colors.dart';
import 'package:leemcwest/assets_helper/app_fonts.dart';
import 'package:leemcwest/helpers/ui_helpers.dart';
class ResetBtn extends StatelessWidget {
  final void Function()? onTap;
  const ResetBtn({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
            color: AppColors.c99A1AF,
          ),
          color: AppColors.cFFFFFF,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.refresh,
            ),
            UIHelper.horizontalSpace(2.w),
            Text(
              'Reset',
              style: TextFontStyle.textStyle16w500c6A7282.copyWith(
                color: AppColors.c0A2340,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
