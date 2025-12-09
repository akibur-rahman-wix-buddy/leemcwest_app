import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leemcwest/assets_helper/app_colors.dart';
import 'package:leemcwest/assets_helper/app_fonts.dart';
import 'package:leemcwest/features/profile/widget/subscription_btn.dart';
import 'package:leemcwest/features/profile/widget/subscription_title_widget.dart';
import 'package:leemcwest/helpers/ui_helpers.dart';

class SubscriptionStatusWidget extends StatelessWidget {
  final String plan;
  final String billingDate;
  final void Function() onTapSubscription;
  const SubscriptionStatusWidget({
    super.key,
    required this.plan,
    required this.billingDate,
    required this.onTapSubscription,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.sp),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        color: AppColors.cF3F4F6,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Subscription Status',
            style: TextFontStyle.textStyle14w400c6A7282.copyWith(
              color: AppColors.c134074,
            ),
          ),
          UIHelper.verticalSpace(24.h),
          SubscriptionTitleWidget(
            title: 'Current Plan:',
            info: plan,
          ),
          UIHelper.verticalSpace(16.h),
          SubscriptionTitleWidget(
            title: 'Next billing date:',
            info: billingDate,
          ),
          UIHelper.verticalSpace(21.h),
          SubscriptionBtn(
            onTap: onTapSubscription,
          )
        ],
      ),
    );
  }
}