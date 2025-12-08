import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leemcwest/assets_helper/app_colors.dart';
import 'package:leemcwest/assets_helper/app_fonts.dart';

class BulletText extends StatelessWidget {
  final String text;

  const BulletText({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("• "),
        Expanded(
          child: Text(
            text,
            style: TextFontStyle.textStyle14w400c6A7282.copyWith(
              color: AppColors.c4A5565,
              fontSize: 16.sp,
            ),
          ),
        ),
      ],
    );
  }
}
