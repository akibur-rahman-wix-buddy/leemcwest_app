import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leemcwest/assets_helper/app_colors.dart';
import 'package:leemcwest/assets_helper/app_fonts.dart';
import 'package:leemcwest/common_widgets/custom_center_title_appbar.dart';
import 'package:leemcwest/features/profile/widget/push_notification_widget.dart';
import 'package:leemcwest/helpers/ui_helpers.dart';

class PushNotificationScreen extends StatefulWidget {
  const PushNotificationScreen({super.key});

  @override
  State<PushNotificationScreen> createState() => _PushNotificationScreenState();
}

class _PushNotificationScreenState extends State<PushNotificationScreen> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cFFFFFF,
      appBar: const CustomCenterTitleAppbar(
        title: 'Notification',
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UIHelper.verticalSpace(14.h),
            Text(
              'Notification',
              style: TextFontStyle.headlinePublicSans50018,
            ),
            UIHelper.verticalSpace(20.h),
            const PushNotificationWidget(
              text: 'Email Notifications',
            ),
            UIHelper.verticalSpace(30.h),
            const PushNotificationWidget(
              text: 'Push Notifications',
            ),
          ],
        ),
      ),
    );
  }
}