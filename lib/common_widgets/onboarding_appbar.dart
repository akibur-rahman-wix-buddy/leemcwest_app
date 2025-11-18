import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:leemcwest/assets_helper/app_colors.dart';
import 'package:leemcwest/assets_helper/app_fonts.dart';
import 'package:leemcwest/assets_helper/app_icons.dart';
import 'package:leemcwest/helpers/navigation_service.dart';

class OnboardingAppbar extends StatelessWidget implements PreferredSizeWidget {
  const OnboardingAppbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              NavigationService.goBack;
            },
            child: SvgPicture.asset(
              AppIcons.arrowLeft,
            ),
          ),
          Text(
            '건너뛰기',
            style: TextFontStyle.textStyle16w600c000A15ColorPretendard.copyWith(
              color: AppColors.cC2C4C8,
            ),
          ),
        ],
      ),
    );
  }
  
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
