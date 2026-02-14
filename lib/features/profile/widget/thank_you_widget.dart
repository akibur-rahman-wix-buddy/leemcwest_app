import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:leemcwest/assets_helper/app_colors.dart';
import 'package:leemcwest/assets_helper/app_fonts.dart';
import 'package:leemcwest/assets_helper/app_icons.dart';
import 'package:leemcwest/helpers/ui_helpers.dart';

class ThankYouWidget extends StatelessWidget {
  final int rating;

  const ThankYouWidget({super.key, required this.rating});

  @override
  Widget build(BuildContext context) {
    String message;
    switch (rating) {
      case 5:
        message = 'Excellent';
        break;
      case 4:
        message = 'Very Good';
        break;
      case 3:
        message = 'Good';
        break;
      case 2:
        message = 'Fair';
        break;
      default:
        message = 'Thanks';
    }

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.cFFFFFF,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
        ),
        child: Padding(
          padding: EdgeInsets.all(20.sp),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              UIHelper.verticalSpace(12.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.close),
                  ),
                ],
              ),
              UIHelper.verticalSpace(16.h),
              Text(
                message,
                style: TextFontStyle.headlinePoppins60016.copyWith(
                  color: AppColors.c020617,
                ),
                textAlign: TextAlign.center,
              ),
              UIHelper.verticalSpace(16.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 6.w),
                    child: SvgPicture.asset(
                      index < rating ? AppIcons.starr2 : AppIcons.starr,
                    ),
                  );
                }),
              ),
              UIHelper.verticalSpace(16.h),
              Text(
                '‘Thanks for loving us!’',
                style: TextFontStyle.textStyle16w600c6A7282.copyWith(
                  color: AppColors.c020617,
                ),
                textAlign: TextAlign.center,
              ),
              UIHelper.verticalSpace(8.h),
              Text(
                'Spread the word by rating us on PayStcre',
                style: TextFontStyle.textStyle14w400c6A7282.copyWith(
                  color: AppColors.c020617,
                ),
                textAlign: TextAlign.center,
              ),
              // UIHelper.verticalSpace(20.h),
              // SizedBox(
              //   width: double.infinity,
              //   child: ElevatedButton(
              //     style: ElevatedButton.styleFrom(
              //       backgroundColor: AppColors.primaryColor2,
              //       shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(12.r),
              //       ),
              //       padding: EdgeInsets.symmetric(vertical: 14.h),
              //     ),
              //     onPressed: () => Navigator.pop(context),
              //     child: Text(
              //       'Close',
              //       style: TextFontStyle.textStyle16w600cFFFFFF,
              //     ),
              //   ),
              // ),
              // UIHelper.verticalSpace(12.h),
            ],
          ),
        ),
      ),
    );
  }
}

// Function to show the Thank You modal
void showThankYouModal(BuildContext context, int rating) {
  showModalBottomSheet(
    backgroundColor: Colors.transparent,
    context: context,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
    ),
    builder: (context) => ThankYouWidget(rating: rating),
  );
}
