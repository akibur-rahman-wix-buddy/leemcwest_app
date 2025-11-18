import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:leemcwest/assets_helper/app_colors.dart';
import 'package:leemcwest/assets_helper/app_fonts.dart';
import 'package:leemcwest/assets_helper/app_image.dart';
import 'package:leemcwest/common_widgets/onboarding_button.dart';
import 'package:leemcwest/helpers/all_routes.dart';
import 'package:leemcwest/helpers/navigation_service.dart';
import 'package:leemcwest/helpers/ui_helpers.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, dynamic>> _onboardingData = [
    {
      "image": AppImages.splashLogo,
      "title": "Learn Music Theory".tr,
      "subtitle":
          "Master functional harmonic theory with interactive lessons designed for musicians of all levels."
              .tr,
    },
    {
      "image": AppImages.splashLogo,
      "title": "Practice & Build".tr,
      "subtitle":
          "Create your own functional progressions with the harmonic composition builder"
              .tr,
    },
    {
      "image": AppImages.splashLogo,
      "title": "Track Progress".tr,
      "subtitle":
          "Track your progress of completed lessons and quizzes, and watch your skills grow with FHT."
              .tr,
    },
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cFFFFFF,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage(AppImages.splashScreen)),
        ),
        child: SafeArea(
          // 👈 prevent status bar overlap
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // >>>>>>>>>>>>>>> SKIP BUTTON >>>>>>>>>>>>>>>
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 20.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (_currentPage != _onboardingData.length - 1)
                      GestureDetector(
                        onTap: () {
                          // NavigationService.navigateTo(Routes.loginSignup);
                        },
                        child: GestureDetector(
                          onTap: () {
                            NavigationService.navigateTo(Routes.signIn);
                          },
                          child: Text(
                            'Skip'.tr,
                            style: TextFontStyle.headlinePoppins60014.copyWith(
                              color: AppColors.onboardingButtonColor,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),

              // >>>>>>>>>>>>>>> PAGE VIEW >>>>>>>>>>>>>>>
              Expanded(
                child: PageView.builder(
                  physics: const BouncingScrollPhysics(),
                  controller: _pageController,
                  itemCount: _onboardingData.length,
                  onPageChanged: (int page) {
                    setState(() {
                      _currentPage = page;
                    });
                  },
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            _onboardingData[index]['image'],
                            height: 200.h,
                            width: 185.h,
                            fit: BoxFit.cover,
                          ),
                          UIHelper.verticalSpace(24.h),
                          Text(
                            _onboardingData[index]['title'],
                            textAlign: TextAlign.center,
                            style: TextFontStyle.headlineCinzel24w700cFFFFFF.copyWith(
                              fontSize: 24.sp,
                              color: AppColors.onboardingButtonColor,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          UIHelper.verticalSpace(12.h),
                          Text(
                            _onboardingData[index]['subtitle'],
                            textAlign: TextAlign.center,
                            style: TextFontStyle.headlinePoppins60014.copyWith(
                              fontWeight: FontWeight.w400,
                              color: AppColors.c99A1AF,
                            ),
                            maxLines: 2,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),

              // >>>>>>>>>>>>>>> INDICATORS >>>>>>>>>>>>>>>
              UIHelper.verticalSpace(20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  _onboardingData.length,
                  (index) => AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: _currentPage == index ? 24.w : 8.w,
                    height: 5.h,
                    margin: EdgeInsets.symmetric(horizontal: 4.w),
                    decoration: BoxDecoration(
                      color: _currentPage == index
                          ? AppColors.onboardingButtonColor
                          : AppColors.cC4CDD5,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                ),
              ),

              // >>>>>>>>>>>>>>> BUTTON >>>>>>>>>>>>>>>
              UIHelper.verticalSpace(40.h),
              Row(
                mainAxisAlignment: _currentPage >= _onboardingData.length -2 ? MainAxisAlignment.spaceBetween : MainAxisAlignment.end,
                children: [
                  if(_currentPage >= _onboardingData.length - 2)
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: GestureDetector(
                      onTap: () {
                        if(_currentPage >= _onboardingData.length -2)
                        {
                          _pageController.previousPage(
                            duration: const Duration(microseconds: 300),
                            curve: Curves.easeInOut
                          );
                        }
                      },
                      child: Text(
                        'Back'.tr,
                        style: TextFontStyle.headlinePoppins60014.copyWith(
                          color: AppColors.onboardingButtonColor,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: OnboardingButton(
                        text: _currentPage < _onboardingData.length - 1 ? 'Continue' : 'Get Started',
                        onTap: () {
                          if (_currentPage < _onboardingData.length - 1) {
                            _pageController.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          } else {
                             NavigationService.navigateTo(Routes.signUp);
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
              UIHelper.verticalSpace(40.h),
            ],
          ),
        ),
      ),
    );
  }
}
