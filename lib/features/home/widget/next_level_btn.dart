import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leemcwest/assets_helper/app_colors.dart';
import 'package:leemcwest/assets_helper/app_fonts.dart';
import 'package:leemcwest/helpers/ui_helpers.dart';
class NextLevelBtn extends StatelessWidget {
  final void Function() onTap;
  final String text;
  const NextLevelBtn({
    super.key,
    required this.onTap,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding:
            EdgeInsets.symmetric(horizontal: 8.w, vertical: 12.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.w),
          color: AppColors.c134074,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: TextFontStyle.textStyle12w400c64748B.copyWith(
                color: AppColors.cFFFFFF,
              ),
            ),
            UIHelper.horizontalSpace(8.w),
            const Icon(
              Icons.arrow_forward,
              color: AppColors.cFFFFFF,
            ),
          ],
        ),
      ),
    );
  }
}
