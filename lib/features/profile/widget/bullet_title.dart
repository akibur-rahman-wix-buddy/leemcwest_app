import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leemcwest/assets_helper/app_fonts.dart';

class BulletTitle extends StatelessWidget {
  final String text;

  const BulletTitle({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("• ",style: TextStyle(fontSize: 20.sp),),
        Expanded(
          child: Text(
            text,
            style: TextFontStyle.headlineCinzel18w600c141313,
          ),
        ),
      ],
    );
  }
}
