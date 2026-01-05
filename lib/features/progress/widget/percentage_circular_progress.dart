import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leemcwest/assets_helper/app_colors.dart';
import 'package:leemcwest/assets_helper/app_fonts.dart';

class PercentageCircularProgress extends StatelessWidget {
  final double percentage; // 0 to 100
  final double size;
  final double strokeWidth;

  const PercentageCircularProgress({
    super.key,
    required this.percentage,
    this.size = 96,
    this.strokeWidth = 4,
  });

  @override
  Widget build(BuildContext context) {
    final progress = (percentage.clamp(0, 100)) / 100; // ensure between 0-100

    return SizedBox(
      width: size.w,
      height: size.w,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: Size(size.w, size.w),
            painter: _PercentageCircularPainter(
              progress: progress,
              strokeWidth: strokeWidth,
            ),
          ),
          Text(
            '${percentage.toStringAsFixed(0)}%',
            style: TextFontStyle.textStyle16w500c6A7282.copyWith(
              fontSize: 10.sp,
              color: AppColors.c134074,
            ),
          ),
        ],
      ),
    );
  }
}

class _PercentageCircularPainter extends CustomPainter {
  final double progress;
  final double strokeWidth;

  _PercentageCircularPainter({
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
  bool shouldRepaint(covariant _PercentageCircularPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
