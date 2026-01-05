import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leemcwest/assets_helper/app_colors.dart';
import 'package:leemcwest/assets_helper/app_fonts.dart';
import 'package:leemcwest/common_widgets/cached_image_widget.dart';
import 'package:leemcwest/common_widgets/custom_button.dart';
import 'package:leemcwest/common_widgets/custom_center_title_appbar.dart';
import 'package:leemcwest/common_widgets/custom_textfeild.dart';
import 'package:leemcwest/helpers/ui_helpers.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cF9FAFB,
      appBar: const CustomCenterTitleAppbar(
        title: 'Edit Profile',
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UIHelper.verticalSpace(32.h),
            Center(
              child: CachedImageWidget(
                url:
                    'https://img.freepik.com/premium-vector/young-man-avatar-character-due-avatar-man-vector-icon-cartoon-illustration_1186924-4438.jpg?semt=ais_hybrid&w=740&q=80',
                height: 104.h,
                width: 104.w,
              ),
            ),
            UIHelper.verticalSpace(32.h),
            Text(
              'Your Name',
              style: TextFontStyle.textStyle14w400c6A7282.copyWith(
                fontSize: 16.sp,
                color: AppColors.c141313,
              ),
            ),
            UIHelper.verticalSpace(8.h),
            CustomTextField(
              controller: nameController,
              hintText: 'Enter your name',
            ),
            UIHelper.verticalSpace(20.h),
            Text(
              'Your Email',
              style: TextFontStyle.textStyle14w400c6A7282.copyWith(
                fontSize: 16.sp,
                color: AppColors.c141313,
              ),
            ),
            UIHelper.verticalSpace(8.h),
            CustomTextField(
              controller: nameController,
              hintText: 'Enter your email',
            ),
            UIHelper.verticalSpace(20.h),
            Text(
              'Phone Number',
              style: TextFontStyle.textStyle14w400c6A7282.copyWith(
                fontSize: 16.sp,
                color: AppColors.c141313,
              ),
            ),
            UIHelper.verticalSpace(8.h),
            CustomTextField(
              controller: nameController,
              hintText: 'Enter your number',
            ),
            UIHelper.verticalSpace(32.h),
            CustomButton(
              name: 'Update',
              onCallBack: () {},
              context: context,
            ),
          ],
        ),
      ),
    );
  }
}
