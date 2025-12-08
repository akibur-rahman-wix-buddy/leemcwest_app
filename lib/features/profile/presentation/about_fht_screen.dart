import 'package:flutter/material.dart';
import 'package:leemcwest/assets_helper/app_colors.dart';
import 'package:leemcwest/common_widgets/custom_center_title_appbar.dart';
class AboutFhtScreen extends StatefulWidget {
  const AboutFhtScreen({super.key});

  @override
  State<AboutFhtScreen> createState() => _AboutFhtScreenState();
}

class _AboutFhtScreenState extends State<AboutFhtScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cF9FAFB,
      appBar: const CustomCenterTitleAppbar(
        title: 'About FHT',
      ),
    );
  }
}