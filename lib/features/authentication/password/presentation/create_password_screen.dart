import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:leemcwest/assets_helper/app_colors.dart';
import 'package:leemcwest/assets_helper/app_fonts.dart';
import 'package:leemcwest/assets_helper/app_icons.dart';
import 'package:leemcwest/assets_helper/app_image.dart';
import 'package:leemcwest/common_widgets/custom_button.dart';
import 'package:leemcwest/common_widgets/custom_textfeild.dart';
import 'package:leemcwest/features/authentication/password/widget/change_password_dialogue.dart';
import 'package:leemcwest/helpers/navigation_service.dart';
import 'package:leemcwest/helpers/ui_helpers.dart';

class CreatePasswordScreen extends StatefulWidget {
  const CreatePasswordScreen({super.key});

  @override
  State<CreatePasswordScreen> createState() => _CreatePasswordScreenState();
}

class _CreatePasswordScreenState extends State<CreatePasswordScreen> {
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cFFFFFF,
      appBar: AppBar(
        backgroundColor: AppColors.cFFFFFF,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: GestureDetector(
          onTap: () {
            NavigationService.goBack;
          },
          child: SvgPicture.asset(
            AppIcons.back,
          ),
        ),
      ),
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              UIHelper.verticalSpace(36.h),
              Center(
                child: Image.asset(
                  AppImages.splashLogo,
                  width: 140.w,
                ),
              ),
              UIHelper.verticalSpace(8.h),
              Center(
                child: Text(
                  'Create New Password',
                  style: TextFontStyle.headlineCinzel24w700cFFFFFF.copyWith(
                    fontSize: 20.sp,
                    color: AppColors.onboardingButtonColor,
                  ),
                ),
              ),
              UIHelper.verticalSpace(8.h),
              Center(
                child: Text(
                  'Set a strong password to secure access',
                  style: TextFontStyle.textStyle14w400c6A7282,
                  textAlign: TextAlign.center,
                ),
              ),
              UIHelper.verticalSpace(32.h),
              Text(
                'New Password',
                style: TextFontStyle.textStyle14w500c0A2340,
              ),
              UIHelper.verticalSpace(8.h),
              CustomTextField(
                controller: newPasswordController,
                hintText: 'New Password',
                fillColor: AppColors.cF3F4F6,
                borderRadius: 8.r,
                inputAction: TextInputAction.next,
              ),
              UIHelper.verticalSpace(16.h),
              Text(
                'Confirm Password',
                style: TextFontStyle.textStyle14w500c0A2340,
              ),
              UIHelper.verticalSpace(8.h),
              CustomTextField(
                controller: confirmPasswordController,
                hintText: 'Confirm Password',
                fillColor: AppColors.cF3F4F6,
                borderRadius: 8.r,
              ),
              UIHelper.verticalSpace(24.h),
              CustomButton(
                name: 'Reset Password',
                onCallBack: (){
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) {
                      return const ChangePasswordDialogue();
                    },
                  );
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
