import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leemcwest/assets_helper/app_colors.dart';
import 'package:leemcwest/assets_helper/app_fonts.dart';

class CustomTitleAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const CustomTitleAppbar({
    super.key,
    required this.title
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: AppColors.cFFFFFF,
      automaticallyImplyLeading: false,
      title: Center(
        child: Text(
          title,
          style: TextFontStyle.headlineCinzel24w700cFFFFFF.copyWith(
            color: AppColors.onboardingButtonColor,
            fontSize: 18.sp,
          ),
        ),
      ),
    );
  }
  
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}