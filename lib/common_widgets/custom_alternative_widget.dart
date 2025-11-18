import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leemcwest/assets_helper/app_colors.dart';
import 'package:leemcwest/assets_helper/app_fonts.dart';
import 'package:leemcwest/helpers/ui_helpers.dart';

// ignore: must_be_immutable
class CustomAlternativeWidget extends StatelessWidget {
  String text;
  CustomAlternativeWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 94.w,
          height: 1.h,
          color: AppColors.cE5E7EB,
        ),
        UIHelper.horizontalSpace(16.w),
        Text(
          text,
          style: TextFontStyle.textStyle14w400c6A7282.copyWith(
            color: AppColors.c99A1AF,
          ),
        ),
        UIHelper.horizontalSpace(16.w),
        Container(
          width: 94.w,
          height: 1.h,
          color: AppColors.cE5E7EB,
        ),
      ],
    );
  }
}
