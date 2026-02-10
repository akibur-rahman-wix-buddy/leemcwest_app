import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:leemcwest/assets_helper/app_colors.dart';
import 'package:leemcwest/assets_helper/app_fonts.dart';
import 'package:leemcwest/assets_helper/app_icons.dart';
import 'package:leemcwest/common_widgets/custom_button.dart';
import 'package:leemcwest/helpers/navigation_service.dart';
import 'package:leemcwest/helpers/ui_helpers.dart';

class RatingAppWidget extends StatefulWidget {
  final ValueChanged<int> onRatingChanged;
  final ValueChanged<int> onTapSubmit;
  const RatingAppWidget({
    super.key,
    required this.onTapSubmit,
    required this.onRatingChanged,
  });

  @override
  State<RatingAppWidget> createState() => _RatingAppWidgetState();
}

class _RatingAppWidgetState extends State<RatingAppWidget> {
  int selectedRating = 0;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          UIHelper.verticalSpace(12.r),
          Container(
            //padding: EdgeInsets.all(20.sp),
            decoration: BoxDecoration(
              color: AppColors.cFFFFFF,
              borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
            ),
            child: Padding(
              padding: EdgeInsets.all(20.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          NavigationService.goBack;
                        },
                        child: const Icon(
                          Icons.close,
                        ),
                      ),
                    ],
                  ),
                  UIHelper.verticalSpace(16.h),
                  Center(
                    child: Text(
                      'Rate your experience with us!',
                      style: TextFontStyle.textStyle16w600c6A7282.copyWith(
                        color: AppColors.c020617,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  UIHelper.verticalSpace(16.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(5, (index) {
                      final starIndex = index + 1;

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedRating = starIndex;
                          });
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.w),
                          child: SvgPicture.asset(
                            selectedRating >= starIndex
                                ? AppIcons.starr2
                                : AppIcons.starr,
                          ),
                        ),
                      );
                    }),
                  ),
                  UIHelper.verticalSpace(16.h),
                  CustomButton(
                    name: 'Submit',
                    context: context,
                    onCallBack: () {
                      if (selectedRating == 0) return;
                      widget.onTapSubmit(selectedRating);
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
