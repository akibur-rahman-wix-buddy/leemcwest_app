import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:leemcwest/assets_helper/app_colors.dart';
import 'package:leemcwest/assets_helper/app_fonts.dart';
import 'package:leemcwest/assets_helper/app_icons.dart';
import 'package:leemcwest/helpers/ui_helpers.dart';

class PlaySoundContainer extends StatelessWidget {
  final void Function() onTap;
  const PlaySoundContainer({
    super.key, 
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          color: AppColors.c134074,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              AppIcons.play,
            ),
            UIHelper.horizontalSpace(12.w),
            Text(
              'Play Phrase',
              style: TextFontStyle.textStyle16w400c6A7282.copyWith(
                fontSize: 14.sp,
                color: AppColors.cFFFFFF,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
