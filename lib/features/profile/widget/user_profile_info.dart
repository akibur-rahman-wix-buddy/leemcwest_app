import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leemcwest/assets_helper/app_fonts.dart';
import 'package:leemcwest/common_widgets/cached_image_widget.dart';
import 'package:leemcwest/helpers/ui_helpers.dart';

class UserProfileInfo extends StatelessWidget {
  final String url;
  final String name;
  final String email;
  const UserProfileInfo({
    super.key,
    required this.url,
    required this.name,
    required this.email
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CachedImageWidget(
                url: url,
                width: 54.h,
                height: 54.h,
              ),
              UIHelper.horizontalSpace(12.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextFontStyle.textStyle16w400c141313,
                  ),
                  UIHelper.verticalSpace(4.h),
                  Text(
                    email,
                    style: TextFontStyle.headlinePublicSans40012,
                  ),
                ],
              ),
            ],
          ),
          const Icon(
            Icons.arrow_forward_ios,
          ),
        ],
      ),
    );
  }
}
