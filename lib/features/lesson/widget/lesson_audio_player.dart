import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leemcwest/assets_helper/app_colors.dart';

class LessonAudioPlayer extends StatelessWidget {
  final String currentTime;
  final String totalTime;

  const LessonAudioPlayer({
    super.key,
    required this.currentTime,
    required this.totalTime,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 10,
            spreadRadius: -2,
            color: AppColors.onboardingButtonColor.withOpacity(0.08),
          )
        ],
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [

          /// ---- SLIDER ----
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: AppColors.onboardingButtonColor,
              inactiveTrackColor: AppColors.onboardingButtonColor.withOpacity(0.25),
              thumbColor: AppColors.onboardingButtonColor,
              trackHeight: 2.h,
            ),
            child: Slider(
              value: 25,
              min: 0,
              max: 100,
              onChanged: (value) {},
            ),
          ),

          /// ---- TIME TEXTS ----
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(currentTime,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: AppColors.onboardingButtonColor.withOpacity(0.6),
                    )),
                Text(totalTime,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: AppColors.onboardingButtonColor.withOpacity(0.6),
                    )),
              ],
            ),
          ),

          SizedBox(height: 20.h),

          /// ---- BUTTONS ----
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.skip_previous,
                  size: 28.sp,
                  color: AppColors.onboardingButtonColor.withOpacity(0.2)),
              SizedBox(width: 30.w),

              /// PLAY / PAUSE BUTTON
              Container(
                height: 60.w,
                width: 60.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.onboardingButtonColor,
                ),
                child: Icon(Icons.pause, color: Colors.white, size: 30.sp),
              ),

              SizedBox(width: 30.w),
              Icon(Icons.skip_next,
                  size: 28.sp,
                  color: AppColors.c0A0E1A),
            ],
          ),
        ],
      ),
    );
  }
}
