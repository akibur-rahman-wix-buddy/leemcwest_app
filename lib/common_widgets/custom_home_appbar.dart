import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leemcwest/assets_helper/app_colors.dart';
import 'package:leemcwest/assets_helper/app_fonts.dart';
import 'package:leemcwest/assets_helper/app_image.dart';

class CustomHomeAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
   CustomHomeAppbar({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.cFFFFFF,
      automaticallyImplyLeading: false,
      elevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            AppImages.menu,
            width: 38.w,
          ),
          Text(
            'Home FHT',
            style: TextFontStyle.headlineCinzel24w700cFFFFFF.copyWith(
              color: AppColors.onboardingButtonColor,
              fontSize: 18.sp,
            ),
          ),
          Image.asset(
            AppImages.notification,
            width: 24.w,
          ),
        ],
      ),
    );
  }
  
  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
