import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:leemcwest/assets_helper/app_colors.dart';
import 'package:leemcwest/assets_helper/app_fonts.dart';
import 'package:leemcwest/assets_helper/app_icons.dart';
import 'package:leemcwest/helpers/navigation_service.dart';

class CustomCenterTitleAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const CustomCenterTitleAppbar({
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
          GestureDetector(
            onTap: () {
              NavigationService.goBack;
            },
            child: SvgPicture.asset(
              AppIcons.iconBack,
            ),
          ),
          Text(
            title,
            style: TextFontStyle.headlineCinzel24w700cFFFFFF.copyWith(
              color: AppColors.onboardingButtonColor,
              fontSize: 18.sp,
            ),
          ),
          SvgPicture.asset(
            AppIcons.iconBack,
            color: Colors.transparent,
          ),
        ],
      ),
    );
  }
  
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
