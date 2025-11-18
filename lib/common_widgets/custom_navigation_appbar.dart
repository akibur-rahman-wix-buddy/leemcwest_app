import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:leemcwest/assets_helper/app_colors.dart';
import 'package:leemcwest/assets_helper/app_fonts.dart';
import 'package:leemcwest/assets_helper/app_icons.dart';
import 'package:leemcwest/assets_helper/app_image.dart';
class CustomNavigationAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const CustomNavigationAppbar({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: AppColors.cFFFFFF,
      automaticallyImplyLeading: false,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SvgPicture.asset(
            AppIcons.iconBack,
          ),
          Text(
            'Lesson',
            style: TextFontStyle.headlineCinzel24w700cFFFFFF.copyWith(
              color: AppColors.onboardingButtonColor,
              fontSize: 18.sp,
            ),
          ),
          Image.asset(
            AppImages.musicBook,
            width: 38.w,
          ),
        ],
      ),
    );
  }
  
  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
