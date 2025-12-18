import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leemcwest/assets_helper/app_colors.dart';
import 'package:leemcwest/assets_helper/app_fonts.dart';
import 'package:leemcwest/assets_helper/app_image.dart';
import 'package:leemcwest/constants/app_list.dart';
import 'package:leemcwest/helpers/all_routes.dart';
import 'package:leemcwest/helpers/navigation_service.dart';
import 'package:leemcwest/helpers/ui_helpers.dart';

class EarTrainingScreen extends StatefulWidget {
  const EarTrainingScreen({super.key});

  @override
  State<EarTrainingScreen> createState() => _EarTrainingScreenState();
}

class _EarTrainingScreenState extends State<EarTrainingScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<Animation<double>> _animations;
 

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    );

    _animations = List.generate(items.length, (index) {
      final start = 0.15 + (index * 0.06);
      return CurvedAnimation(
        parent: _controller,
        curve: Interval(start, start + 0.25, curve: Curves.easeIn),
      );
    });

    _controller.forward();

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Future.delayed(const Duration(milliseconds: 500), () {
          NavigationService.navigateTo(Routes.navigation);
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cFFFFFF,
      body: SafeArea(
        child: Column(
          children: [
            UIHelper.verticalSpace(50.h),
            FadeTransition(
              opacity: CurvedAnimation(
                parent: _controller,
                curve: const Interval(0.0, 0.2, curve: Curves.easeIn),
              ),
              child: Image.asset(
                AppImages.python,
                width: 88.w,
              ),
            ),

            UIHelper.verticalSpace(30.h),
            Expanded(
              child: SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: Column(
                  children: List.generate(items.length, (index) {
                    final item = items[index];

                    return FadeTransition(
                      opacity: _animations[index],
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.w,
                          vertical: item.isTitle ? 12.h : 6.h,
                        ),
                        child: Text(
                          item.text,
                          textAlign: TextAlign.center,
                          style: item.isBlue
                              ? TextFontStyle.headlineCinzel24w700cFFFFFF
                                  .copyWith(
                                      color:
                                          AppColors.onboardingButtonColor,
                                      fontSize: item.isTitle ? 18.sp : 16.sp)
                              : TextFontStyle.textStyle14w400c6A7282.copyWith(
                                  color: AppColors.c4A5565,
                                ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

