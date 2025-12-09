import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:leemcwest/assets_helper/app_colors.dart';
import 'package:leemcwest/assets_helper/app_fonts.dart';

class PushNotificationWidget extends StatefulWidget {
  final String text;
  const PushNotificationWidget({
    super.key,
    required this.text,
  });

  @override
  State<PushNotificationWidget> createState() => _PushNotificationWidgetState();
}

class _PushNotificationWidgetState extends State<PushNotificationWidget> {
  bool _isSwitchOn = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          widget.text,
          style: TextFontStyle.textStyle14w400c6A7282.copyWith(
            color: AppColors.c141313,
            fontSize: 16.sp,
          ),
        ),
        FlutterSwitch(
          activeColor: AppColors.c134074,
          inactiveColor: Colors.grey,
          value: _isSwitchOn,
          onToggle: (value) {
            setState(() {
              _isSwitchOn = value;
            });
          },
        )
      ],
    );
  }
}
