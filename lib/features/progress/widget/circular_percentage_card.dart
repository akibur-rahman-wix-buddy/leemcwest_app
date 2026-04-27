import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class DonutPercentageCard extends StatelessWidget {
  final double percentage;
  final double size;
  final Color backgroundColor;
  final Color progressColor;

  const DonutPercentageCard({
    super.key,
    required this.percentage,
    this.size = 120,
    this.backgroundColor = Colors.white,
    this.progressColor = const Color(0xFF1E3A8A),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      //padding: EdgeInsets.all(16),
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: CircularPercentIndicator(
          radius: size / 2, // radius of the circle
          lineWidth: 16, // thickness of the progress bar
          percent: percentage / 100,
          backgroundColor: Colors.grey.shade300,
          progressColor: progressColor,
          circularStrokeCap: CircularStrokeCap.round, // rounded edges
          center: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Total",
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
              Text(
                "$percentage%",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
