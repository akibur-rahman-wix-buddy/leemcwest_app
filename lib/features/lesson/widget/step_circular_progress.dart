import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leemcwest/assets_helper/app_colors.dart';
import 'package:leemcwest/assets_helper/app_fonts.dart';

class StepCircularProgress extends StatelessWidget {
  final int currentStep;
  final int totalSteps;
  final double size;
  final double strokeWidth;

  const StepCircularProgress({
    super.key,
    required this.currentStep,
    required this.totalSteps,
    this.size = 96,
    this.strokeWidth = 8,
  });

  @override
  Widget build(BuildContext context) {
    final progress = currentStep / totalSteps;

    return SizedBox(
      width: size.w,
      height: size.w,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: Size(size.w, size.w),
            painter: _StepCircularPainter(
              progress: progress,
              strokeWidth: strokeWidth,
            ),
          ),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                TextSpan(
                  text: '$currentStep',
                  style: TextFontStyle.textStyle16w500c6A7282.copyWith(
                    fontSize: 22.sp,
                    color: AppColors.c134074,
                  ),
                ),
                TextSpan(
                  text: '/$totalSteps',
                  style: TextFontStyle.textStyle14w400c6A7282.copyWith(
                    color: AppColors.c6A7282,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StepCircularPainter extends CustomPainter {
  final double progress;
  final double strokeWidth;

  _StepCircularPainter({
    required this.progress,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = (size.width - strokeWidth) / 2;

    final backgroundPaint = Paint()
      ..color = AppColors.cE5E7EB
      ..strokeWidth = strokeWidth.w
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final progressPaint = Paint()
      ..color = AppColors.c134074
      ..strokeWidth = strokeWidth.w
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, backgroundPaint);

    // Progress arc
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2,
      2 * pi * progress,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _StepCircularPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
