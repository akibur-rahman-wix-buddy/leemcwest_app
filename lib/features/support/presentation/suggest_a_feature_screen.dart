import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leemcwest/assets_helper/app_colors.dart';
import 'package:leemcwest/assets_helper/app_fonts.dart';
import 'package:leemcwest/common_widgets/common_navigation_appbar.dart';
import 'package:leemcwest/common_widgets/custom_button.dart';
import 'package:leemcwest/common_widgets/custom_textfeild.dart';
import 'package:leemcwest/helpers/navigation_service.dart';
import 'package:leemcwest/helpers/ui_helpers.dart';

class SuggestAFeatureScreen extends StatefulWidget {
  const SuggestAFeatureScreen({super.key});

  @override
  State<SuggestAFeatureScreen> createState() => _SuggestAFeatureScreenState();
}

class _SuggestAFeatureScreenState extends State<SuggestAFeatureScreen> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final improveController = TextEditingController();
  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cFFFFFF,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CommonNavigationAppbar(
              title: 'Suggest A Feature',
            ),
            UIHelper.verticalSpace(16.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      'Help us make our app even better',
                      style: TextFontStyle.textStyle14w400c6A7282.copyWith(
                        color: AppColors.c1E2939,
                        fontSize: 16.sp,
                      ),
                    ),
                  ),
                  UIHelper.verticalSpace(18.h),
                  Text(
                    'Feature Title',
                    style: TextFontStyle.textStyle14w500c6A7282.copyWith(
                      color: AppColors.c0A2340,
                    ),
                  ),
                  UIHelper.verticalSpace(8.h),
                  CustomTextField(
                    controller: titleController,
                    fillColor: AppColors.cF3F4F6,
                    borderRadius: 8.r,
                    hintText: 'Feature Title',
                    inputAction: TextInputAction.next,
                  ),
                  UIHelper.verticalSpace(20.h),
                  Text(
                    'Description',
                    style: TextFontStyle.textStyle14w500c6A7282.copyWith(
                      color: AppColors.c0A2340,
                    ),
                  ),
                  UIHelper.verticalSpace(8.h),
                  CustomTextField(
                    controller: descriptionController,
                    fillColor: AppColors.cF3F4F6,
                    borderRadius: 8.r,
                    hintText: 'Description of the suggest feature',
                    inputAction: TextInputAction.next,
                  ),
                  UIHelper.verticalSpace(20.h),
                  Text(
                    'Improve',
                    style: TextFontStyle.textStyle14w500c6A7282.copyWith(
                      color: AppColors.c0A2340,
                    ),
                  ),
                  UIHelper.verticalSpace(8.h),
                  CustomTextField(
                    controller: improveController,
                    fillColor: AppColors.cF3F4F6,
                    borderRadius: 8.r,
                    hintText: 'how would this improve the app?',
                    inputAction: TextInputAction.next,
                  ),
                  UIHelper.verticalSpace(32.h),
                  Text(
                    'Email',
                    style: TextFontStyle.textStyle14w500c6A7282.copyWith(
                      color: AppColors.c0A2340,
                    ),
                  ),
                  UIHelper.verticalSpace(8.h),
                  CustomTextField(
                    controller: emailController,
                    fillColor: AppColors.cF3F4F6,
                    borderRadius: 8.r,
                    hintText: 'Your Email ( Optional)',                    
                    inputAction: TextInputAction.done,
                  ),
                  UIHelper.verticalSpace(32.h),
                  CustomButton(
                    name: 'Send Suggestion',
                    onCallBack: () {
                      NavigationService.goBack;
                    },
                    context: context,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
