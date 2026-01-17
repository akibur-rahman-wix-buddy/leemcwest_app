import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leemcwest/assets_helper/app_colors.dart';
import 'package:leemcwest/assets_helper/app_fonts.dart';
import 'package:leemcwest/helpers/ui_helpers.dart';
class EarTrainingLevelWidget extends StatelessWidget {
  final String title;
  final String subTitle;
  final void Function()? onTap;
  const EarTrainingLevelWidget({
    super.key,
    required this.title, 
    required this.subTitle,
    this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 2.w),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: AppColors.c386BF6,
            )),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                title,
                style: TextFontStyle.headlinePublicSans60024,
              ),
            ),
            UIHelper.verticalSpace(8.h),
            Text(
              subTitle,
              style: TextFontStyle.textStyle14w400c6A7282,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
