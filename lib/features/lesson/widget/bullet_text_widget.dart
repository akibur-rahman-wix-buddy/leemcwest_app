import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leemcwest/assets_helper/app_colors.dart';
import 'package:leemcwest/assets_helper/app_fonts.dart';

class BulletTextWidget extends StatelessWidget {
  final String text;

  const BulletTextWidget({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "•  ",
          style: TextStyle(
            fontSize: 16,
            height: 1.4,
          ),
        ),
        Expanded(
          child: Text(
            text,
            style: TextFontStyle.headlineCinzel24w500cFFFFFF.copyWith(
              color: AppColors.c000000,
              fontSize: 16.sp,
            )
          ),
        ),
      ],
    );
  }
}
