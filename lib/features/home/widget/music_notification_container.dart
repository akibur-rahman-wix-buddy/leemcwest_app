import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leemcwest/assets_helper/app_colors.dart';
import 'package:leemcwest/assets_helper/app_fonts.dart';
import 'package:leemcwest/helpers/ui_helpers.dart';

class MusicNotificationContainer extends StatelessWidget {
  final int duration;
  const MusicNotificationContainer({
    super.key,
    required this.duration,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        color: AppColors.cFFFFFF,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Music Saved',
                    style: TextFontStyle.textStyle16w500c1E2939,
                  ),
                  UIHelper.verticalSpace(4.h),
                  Text(
                    'Your Music saved....',
                    style: TextFontStyle.textStyle14w400c99A1AF,
                  ),
                ],
              ),
            ],
          ),
          Text(
            '$duration min ago',
            style: TextFontStyle.textStyle14w400c99A1AF,
          ),
        ],
      ),
    );
  }
}
