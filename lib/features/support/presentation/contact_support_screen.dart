import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leemcwest/assets_helper/app_colors.dart';
import 'package:leemcwest/assets_helper/app_fonts.dart';
import 'package:leemcwest/common_widgets/custom_button.dart';
import 'package:leemcwest/common_widgets/custom_center_title_appbar.dart';
import 'package:leemcwest/common_widgets/custom_textfeild.dart';
import 'package:leemcwest/helpers/navigation_service.dart';
import 'package:leemcwest/helpers/ui_helpers.dart';

class ContactSupportScreen extends StatefulWidget {
  const ContactSupportScreen({super.key});

  @override
  State<ContactSupportScreen> createState() => _ContactSupportScreenState();
}

class _ContactSupportScreenState extends State<ContactSupportScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cFFFFFF,
      appBar: const CustomCenterTitleAppbar(
        title: 'Contact Support',
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              UIHelper.verticalSpace(12.h),
              Text(
                'Name',
                style: TextFontStyle.textStyle14w500c6A7282.copyWith(
                  color: AppColors.c0A2340,
                ),
              ),
              UIHelper.verticalSpace(8.h),
              CustomTextField(
                  controller: nameController,
                  fillColor: AppColors.cF3F4F6,
                  borderRadius: 8.r,
                  hintText: 'Enter Name',
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
                  hintText: 'Enter Email',
                  inputAction: TextInputAction.next,
                ),
              UIHelper.verticalSpace(20.h),
              Text(
                'Messages',
                style: TextFontStyle.textStyle14w500c6A7282.copyWith(
                  color: AppColors.c0A2340,
                ),
              ),
              UIHelper.verticalSpace(8.h),
              CustomTextField(
                  controller: messageController,
                  fillColor: AppColors.cF3F4F6,
                  borderRadius: 8.r,
                  hintText: 'Enter Messages',
                  maxlines: 5,
                ),
                UIHelper.verticalSpace(20.h),
                CustomButton(
                  name: 'Submit',
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
