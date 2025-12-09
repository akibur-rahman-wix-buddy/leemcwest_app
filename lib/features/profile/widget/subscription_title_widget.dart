import 'package:flutter/material.dart';
import 'package:leemcwest/assets_helper/app_colors.dart';
import 'package:leemcwest/assets_helper/app_fonts.dart';

class SubscriptionTitleWidget extends StatelessWidget {
  final String title;
  final String info;
  const SubscriptionTitleWidget({
    super.key,
    required this.title,
    required this.info,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextFontStyle.textStyle14w400c6A7282.copyWith(
            color: AppColors.c134074,
          ),
        ),
        Text(
          info,
          style: TextFontStyle.textStyle14w400c6A7282.copyWith(
            color: AppColors.c134074,
          ),
        ),
      ],
    );
  }
}