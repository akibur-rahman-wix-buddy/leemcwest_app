import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leemcwest/assets_helper/app_colors.dart';
import 'package:leemcwest/assets_helper/app_fonts.dart';
import 'package:leemcwest/common_widgets/custom_button.dart';
import 'package:leemcwest/common_widgets/custom_center_title_appbar.dart';
import 'package:leemcwest/helpers/all_routes.dart';
import 'package:leemcwest/helpers/navigation_service.dart';
import 'package:leemcwest/helpers/ui_helpers.dart';

class SupportScreen extends StatefulWidget {
  const SupportScreen({super.key});

  @override
  State<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cFFFFFF,
      appBar: const CustomCenterTitleAppbar(
        title: 'Support',
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            UIHelper.verticalSpace(16.h),
            Text(
              'Need to assistance or want to share feedback? our team is here to help you make the most of FHT',
              style: TextFontStyle.textStyle14w400c6A7282.copyWith(
                fontSize: 16.sp,
                color: AppColors.c1E2939,
              ),
            ),
            UIHelper.verticalSpace(120.h),
            CustomButton(
              name: 'Contact Support',
              onCallBack: () {
                NavigationService.navigateTo(Routes.contactSupport);
              },
              context: context,
              borderColor: AppColors.cB6C4D4,
              color: AppColors.cF3F4F6,
              textStyle: const TextStyle(
                color: AppColors.c6A7282,
              ),
            ),
            UIHelper.verticalSpace(18.h),
            CustomButton(
              name: 'Report A Bug',
              onCallBack: () {
                NavigationService.navigateTo(Routes.reportabug);
              },
              context: context,
              borderColor: AppColors.cB6C4D4,
              color: AppColors.cF3F4F6,
              textStyle: const TextStyle(
                color: AppColors.c6A7282,
              ),
            ),
            UIHelper.verticalSpace(18.h),
            CustomButton(
              name: 'Suggest A Feature',
              onCallBack: () {
                NavigationService.navigateTo(Routes.suggestafeature);
              },
              context: context,
              borderColor: AppColors.cB6C4D4,
              color: AppColors.cF3F4F6,
              textStyle: const TextStyle(
                color: AppColors.c6A7282,
              ),
            ),
          ],
        ),
      ),
    );
  }
}