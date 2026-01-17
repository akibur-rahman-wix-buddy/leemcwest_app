import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:leemcwest/assets_helper/app_colors.dart';
import 'package:leemcwest/assets_helper/app_fonts.dart';
import 'package:leemcwest/assets_helper/app_icons.dart';
import 'package:leemcwest/helpers/ui_helpers.dart';
class RepeatLevelWidget extends StatelessWidget {
  final void Function() onTap;
  const RepeatLevelWidget({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding:
            EdgeInsets.symmetric(vertical: 12.h, horizontal: 8.w),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            color: AppColors.cFFFFFF,
            border: Border.all(
              color: AppColors.cE2E8F0,
            )),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(AppIcons.resume),
            UIHelper.horizontalSpace(8.w),
            Text(
              'Repeat Level',
              style: TextFontStyle.textStyle12w400c64748B.copyWith(
                color: AppColors.c061426,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
