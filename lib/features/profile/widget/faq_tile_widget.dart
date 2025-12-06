import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leemcwest/assets_helper/app_colors.dart';
import 'package:leemcwest/assets_helper/app_fonts.dart';
class FaqTileWidget extends StatefulWidget {
  final String question;
  final String answer;

  const FaqTileWidget({
    super.key,
    required this.question,
    required this.answer,
  });

  @override
  State<FaqTileWidget> createState() => _FaqTileWidgetState();
}

class _FaqTileWidgetState extends State<FaqTileWidget> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
      padding: EdgeInsets.all(16.sp),
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        color: AppColors.cFFFFFF,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          /// --- Header Row ---
          InkWell(
            onTap: () => setState(() => isExpanded = !isExpanded),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    widget.question,
                    style: TextFontStyle.headlineCinzel24w500cFFFFFF.copyWith(
                      color: AppColors.c000000,
                      fontSize: 12.sp,
                    ),
                  ),
                ),
                Icon(isExpanded ? Icons.remove : Icons.add,
                    color: AppColors.c000000),
              ],
            ),
          ),

          /// --- Expand Content ---
          if (isExpanded) ...[
            SizedBox(height: 12.h),
            Text(
              widget.answer,
              style: TextFontStyle.textStyle12w400c64748B.copyWith(
                color: AppColors.c1E2939,
                fontSize: 12.sp,
              ),
            ),
          ]
        ],
      ),
    );
  }
}
