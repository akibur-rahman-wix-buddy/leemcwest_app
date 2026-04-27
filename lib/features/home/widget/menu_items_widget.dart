import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:leemcwest/assets_helper/app_fonts.dart';

class MenuItemWidget extends StatelessWidget {
  final String icon;
  final String title;
  final VoidCallback onTap;

  const MenuItemWidget(String homeMenu, {
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          SvgPicture.asset(icon, width: 20, height: 20),
          const SizedBox(width: 12),
          Text(
            title,
            style: TextFontStyle.textStyle14w400c0A2340,
          ),
        ],
      ),
    );
  }
}