import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:leemcwest/assets_helper/app_colors.dart';
import 'package:leemcwest/assets_helper/app_fonts.dart';
import 'package:leemcwest/assets_helper/app_icons.dart';
import 'package:leemcwest/assets_helper/app_image.dart';
import 'package:leemcwest/helpers/all_routes.dart';
import 'package:leemcwest/helpers/navigation_service.dart';
import 'package:leemcwest/helpers/ui_helpers.dart';

class EarTrainingScreen extends StatefulWidget {
  const EarTrainingScreen({super.key});

  @override
  State<EarTrainingScreen> createState() => _EarTrainingScreenState();
}

class _EarTrainingScreenState extends State<EarTrainingScreen> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _targetKey = GlobalKey();

  bool _scrolling = false;

  double pythonHeight = 88.h;
  double titleHeight = 50.h; // approx, will position correctly

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startAutoScroll();
    });
  }

  Future<void> _startAutoScroll() async {
    await Future.delayed(const Duration(milliseconds: 300));

    if (!mounted) return;

    final screenHeight = MediaQuery.of(context).size.height;

    final targetInfo = _measure(_targetKey);
    if (targetInfo == null) return;

    final targetCenter = targetInfo.globalTop + targetInfo.height / 2;
    final screenCenter = screenHeight / 2;

    final move = targetCenter - screenCenter;

    double finalOffset = _scrollController.offset + move;
    finalOffset = finalOffset.clamp(
      _scrollController.position.minScrollExtent,
      _scrollController.position.maxScrollExtent,
    );

    final distance = (finalOffset - _scrollController.offset).abs();
    final duration = (distance / 70).clamp(1, 20);

    _scrolling = true;
    await _scrollController.animateTo(
      finalOffset,
      duration: Duration(seconds: duration.toInt()),
      curve: Curves.linear,
    );
    _scrolling = false;
  }

  _RenderData? _measure(GlobalKey key) {
    final ctx = key.currentContext;
    if (ctx == null) return null;
    final box = ctx.findRenderObject() as RenderBox?;
    if (box == null) return null;

    final pos = box.localToGlobal(Offset.zero);

    return _RenderData(height: box.size.height, globalTop: pos.dy);
  }

  @override
  Widget build(BuildContext context) {
    final screenW = MediaQuery.of(context).size.width;

    final fixedTopPadding = 60.h;

    final pythonTop = fixedTopPadding + titleHeight + 30.h;

    return Scaffold(
      backgroundColor: AppColors.cFFFFFF,
      body: SafeArea(
        child: Stack(
          children: [
            // ------------- SCROLLING CONTENT (under python) -----------------
            Positioned.fill(
              top: pythonTop + pythonHeight, // scrolling starts IMMEDIATELY below python
              child: ShaderMask(
                shaderCallback: (rect) {
                  return LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent, // fades at the top (under python)
                      Colors.black,
                      Colors.black,
                      Colors.black,
                    ],
                    stops: const [0.0, 0.12, 0.5, 1.0],
                  ).createShader(rect);
                },
                blendMode: BlendMode.dstIn,
                child: SingleChildScrollView(
                  controller: _scrollController,
                  physics: const NeverScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      _p('You’ve just stepped into a new era of music education a living framework that teaches harmony through flow, not formula.'),
                      UIHelper.verticalSpace(8.h),
                      _p('Functional Harmonic Theory is a new living framework that reveals the natural gravitational movement of sound.'),
                      UIHelper.verticalSpace(8.h),
                      _p('Removing the confusion that, for centuries, traditional theory had left behind endless rules, contradictions, and unanswered questions.'),
                      UIHelper.verticalSpace(10.h),
                      _p('Here, you’ll learn harmony as it truly exists in motion. Expanding, contracting, and resolving through pure functional gravity.'),
                      UIHelper.verticalSpace(12.h),
                      _p('Learn through structured lessons. Create freely in the Composition Builder. Go deeper with Case Study Analysis, Advanced Insights, and develop your instinct through Functional Ear Training a unique approach that helps you feel harmonic direction rather than memorise intervals.'),
                      UIHelper.verticalSpace(10.h),
                      _p('Whether you’re a musician, producer, composer, or curious learner, FHT will reshape how you hear, write, and understand music.'),
                      UIHelper.verticalSpace(12.h),
                      _p('Explore at your own pace.'),
                      UIHelper.verticalSpace(8.h),
                      _p('Learn the logic and feel the flow.'),
                      UIHelper.verticalSpace(10.h),
                      _p('Learn the logic and feel the flow.'),
                      UIHelper.verticalSpace(8.h),
                      _p('Intuitive. Logical. Complete.'),
                      UIHelper.verticalSpace(54.h),

                      // ===== FINAL TARGET BLOCK =====
                      Container(
                        key: _targetKey,
                        width: screenW,
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            Text(
                              'Welcome to Functional Harmonic Theory where music finally makes sense.',
                              style: TextFontStyle.headlineCinzel24w700cFFFFFF
                                  .copyWith(
                                      color: AppColors.onboardingButtonColor,
                                      fontSize: 18.sp),
                              textAlign: TextAlign.center,
                            ),
                            UIHelper.verticalSpace(12.h),
                            GestureDetector(
                              onTap: () {
                                NavigationService.navigateTo(Routes.navigation);
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20.w),
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 16.h, horizontal: 24.w),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.r),
                                    color: AppColors.onboardingButtonColor,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Enter F.H.T',
                                        style: TextFontStyle
                                            .headlinePoppins60016
                                            .copyWith(
                                          color: AppColors.cFFFFFF,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      UIHelper.horizontalSpace(8.w),
                                      SvgPicture.asset(AppIcons.forward)
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 200.h),
                    ],
                  ),
                ),
              ),
            ),

            // ---------------- FIXED TOP TITLE ----------------
            Positioned(
              top: fixedTopPadding,
              left: 0,
              right: 0,
              child: Center(
                child: Text(
                  'Welcome to Functional Harmonic Theory',
                  style: TextFontStyle.headlineCinzel24w700cFFFFFF.copyWith(
                    color: AppColors.onboardingButtonColor,
                    fontSize: 18.sp,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),

            // ---------------- FIXED PYTHON IMAGE ----------------
            Positioned(
              top: pythonTop,
              left: 0,
              right: 0,
              child: Center(
                child: Image.asset(
                  AppImages.python,
                  width: 88.w,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _p(String text) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Text(
        text,
        style: TextFontStyle.textStyle14w400c6A7282.copyWith(
          color: AppColors.c4A5565,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class _RenderData {
  final double globalTop;
  final double height;
  _RenderData({required this.globalTop, required this.height});
}
