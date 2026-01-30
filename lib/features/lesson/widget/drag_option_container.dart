import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leemcwest/assets_helper/app_colors.dart';
import 'package:leemcwest/assets_helper/app_fonts.dart';

class DragOptionContainer extends StatelessWidget {
  final String optionText;
  final bool isUsed;

  const DragOptionContainer({
    super.key,
    required this.optionText,
    required this.isUsed,
  });

  @override
  Widget build(BuildContext context) {
    return Draggable<String>(
      data: optionText,
      feedback: _dragItem(),
      childWhenDragging: Opacity(
        opacity: 0.4,
        child: _dragItem(),
      ),
      child: isUsed ? _usedItem() : _dragItem(),
    );
  }

  Widget _dragItem() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.sp),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: AppColors.cF3F4F6,
      ),
      child: Text(
        optionText,
        style: TextFontStyle.textStyle14w500c6A7282.copyWith(
          color: AppColors.c061426,
        ),
      ),
    );
  }

  Widget _usedItem() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.sp),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: AppColors.cF3F4F6.withOpacity(0.5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            optionText,
            style: TextFontStyle.textStyle14w500c6A7282.copyWith(
              color: AppColors.c061426.withOpacity(0.5),
            ),
          ),
          Icon(
            Icons.check_circle,
            color: Colors.green,
            size: 20.sp,
          ),
        ],
      ),
    );
  }
}