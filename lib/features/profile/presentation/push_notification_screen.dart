import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leemcwest/assets_helper/app_colors.dart';
import 'package:leemcwest/assets_helper/app_fonts.dart';
import 'package:leemcwest/common_widgets/custom_center_title_appbar.dart';
import 'package:leemcwest/features/profile/widget/push_notification_widget.dart';
import 'package:leemcwest/helpers/ui_helpers.dart';
import 'package:leemcwest/networks/api_acess.dart';

class PushNotificationScreen extends StatefulWidget {
  const PushNotificationScreen({super.key});

  @override
  State<PushNotificationScreen> createState() => _PushNotificationScreenState();
}

class _PushNotificationScreenState extends State<PushNotificationScreen> {
  int emailNotification = 0;
  int pushNotification = 0;
  bool _isLoading = false;

  void _updateEmailNotification(bool value) async {
    setState(() {
      emailNotification = value ? 1 : 0;
      _isLoading = true;
    });

    try {
      await updateNotificationRxObj.updateNotificationRx(
        notification: {
          "email_notifications": emailNotification,
          "push_notifications": pushNotification,
        },
      );
      await getNotificationSettingsRxObj.getNotificationSettingsRx();
    } catch (e) {
      setState(() {
        emailNotification = value ? 0 : 1;
      });
      log('Error updating notification: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _updatePushNotification(bool value) async {
    setState(() {
      pushNotification = value ? 1 : 0;
      _isLoading = true;
    });

    try {
      await updateNotificationRxObj.updateNotificationRx(
        notification: {
          "email_notifications": emailNotification,
          "push_notifications": pushNotification,
        },
      );
      await getNotificationSettingsRxObj.getNotificationSettingsRx();
    } catch (e) {
      setState(() {
        pushNotification = value ? 0 : 1;
      });
      log('Error updating notification: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getNotificationSettingsRxObj.getNotificationSettingsRx();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cFFFFFF,
      appBar: const CustomCenterTitleAppbar(
        title: 'Notification',
      ),
      body: StreamBuilder(
        stream: getNotificationSettingsRxObj.dataFetcher,
        builder: (context, snapshot) {
          final data = snapshot.data;
          if (data?.data != null && !_isLoading) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (mounted) {
                setState(() {
                  emailNotification = (data!.data!.emailNotifications ?? false) ? 1 : 0;
                  pushNotification = (data.data!.pushNotifications ?? false) ? 1 : 0;
                });
              }
            });
          }
          
          return Padding(
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
                PushNotificationWidget(
                  text: 'Email Notifications',
                  value: emailNotification == 1,
                  onChanged:  _updateEmailNotification,
                ),
                UIHelper.verticalSpace(30.h),
                PushNotificationWidget(
                  text: 'Push Notifications',
                  value: pushNotification == 1,
                  onChanged:  _updatePushNotification,
                ),
              ],
            ),
          );
        }
      ),
    );
  }
}