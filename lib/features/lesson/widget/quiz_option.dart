import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leemcwest/assets_helper/app_colors.dart';
import 'package:leemcwest/assets_helper/app_fonts.dart';
import 'package:leemcwest/assets_helper/app_image.dart';
import 'package:leemcwest/helpers/ui_helpers.dart';

class QuizOption extends StatefulWidget {
  const QuizOption({
    super.key,
  });

  @override
  State<QuizOption> createState() => _QuizOptionState();
}

class _QuizOptionState extends State<QuizOption> {
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (isSelected == false) {
            isSelected = true;
          } else {
            isSelected = false;
          }
        });
      },
      child: Container(
        padding: EdgeInsets.all(20.sp),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.sp),
          color: AppColors.cF3F4F6,
        ),
        child: Row(
          children: [
            isSelected
                ? Image.asset(
                    AppImages.selected,
                    width: 20.w,
                  )
                : Image.asset(
                    AppImages.unselected,
                    width: 20.w,
                  ),
            UIHelper.horizontalSpace(8.w),
            Text(
              'Retry Quiz',
              style: TextFontStyle.textStyle14w400c6A7282.copyWith(
                color: AppColors.c061426,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
