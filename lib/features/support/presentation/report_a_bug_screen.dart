import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:leemcwest/assets_helper/app_colors.dart';
import 'package:leemcwest/assets_helper/app_fonts.dart';
import 'package:leemcwest/assets_helper/app_icons.dart';
import 'package:leemcwest/common_widgets/custom_button.dart';
import 'package:leemcwest/common_widgets/custom_center_title_appbar.dart';
import 'package:leemcwest/common_widgets/custom_textfeild.dart';
import 'package:leemcwest/helpers/navigation_service.dart';
import 'package:leemcwest/helpers/ui_helpers.dart';

class ReportABugScreen extends StatefulWidget {
  const ReportABugScreen({super.key});

  @override
  State<ReportABugScreen> createState() => _ReportABugScreenState();
}

class _ReportABugScreenState extends State<ReportABugScreen> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cFFFFFF,
      appBar: const CustomCenterTitleAppbar(
        title: 'Report A bug',
      ),
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              UIHelper.verticalSpace(12.h),
              Center(
                child: Text(
                  'Help us improve by describing issue',
                  style: TextFontStyle.textStyle14w400c6A7282.copyWith(
                    color: AppColors.c1E2939,
                    fontSize: 16.sp,
                  ),
                ),
              ),
              UIHelper.verticalSpace(18.h),
              Text(
                'Issue Title',
                style: TextFontStyle.textStyle14w500c6A7282.copyWith(
                  color: AppColors.c0A2340,
                ),
              ),
              UIHelper.verticalSpace(8.h),
              CustomTextField(
                controller: titleController,
                fillColor: AppColors.cF3F4F6,
                borderRadius: 8.r,
                hintText: 'Issue Title',
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
                hintText: 'Description of the bug',
                inputAction: TextInputAction.next,
              ),
              UIHelper.verticalSpace(20.h),
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
              ),
              UIHelper.verticalSpace(20.h),
              Row(
                children: [
                  SvgPicture.asset(AppIcons.upload),
                  UIHelper.horizontalSpace(20.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Upload Screenshot',
                        style: TextFontStyle.textStyle14w500c6A7282.copyWith(
                          color: AppColors.c1E2939,
                          fontSize: 16.sp,
                        ),
                      ),
                      UIHelper.verticalSpace(8.h),
                      Text(
                        '(Optional)',
                        style: TextFontStyle.textStyle14w400c6A7282,
                      ),
                    ],
                  ),
                ],
              ),
              UIHelper.verticalSpace(32.h),
              CustomButton(
                name: 'Submit Report',
                onCallBack: () {
                  NavigationService.goBack;
                },
                context: context,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
