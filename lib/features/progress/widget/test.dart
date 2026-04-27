import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HeightPickerWidget extends StatefulWidget {
  const HeightPickerWidget({super.key});

  @override
  State<HeightPickerWidget> createState() => _HeightPickerWidgetState();
}

class _HeightPickerWidgetState extends State<HeightPickerWidget> {
  late FixedExtentScrollController _controller;

  // Height range in cm
  final int minHeight = 140;
  final int maxHeight = 220;

  int selectedHeight = 176;

  @override
  void initState() {
    super.initState();
    _controller = FixedExtentScrollController(
      initialItem: selectedHeight - minHeight,
    );
  }

  @override
  void dispose() {
    _controller.dispose(); // important to prevent memory leak
    super.dispose();
  }

  /// Convert cm to feet & inches
  String cmToFeetInches(int cm) {
    double inches = cm / 2.54;
    int feet = inches ~/ 12;
    int inch = inches.round() % 12;
    return "$feet' $inch\" ($cm cm)";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Select Height")),
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              height: 250,
              child: CupertinoPicker.builder(
                scrollController: _controller,
                itemExtent: 50,
                diameterRatio: 1.2,
                selectionOverlay: const SizedBox(),
                useMagnifier: true,
                magnification: 1.2,
                onSelectedItemChanged: (index) {
                  setState(() {
                    selectedHeight = minHeight + index;
                  });
                },
                childCount: maxHeight - minHeight + 1,
                itemBuilder: (context, index) {
                  final height = minHeight + index;
                  final isSelected = height == selectedHeight;

                  return Container(
                    margin: EdgeInsets.all(8.sp),
                    padding: const EdgeInsets.symmetric(horizontal: 26).w,
                    color: isSelected ? Colors.tealAccent : Colors.transparent,
                    child: Text(
                      cmToFeetInches(height),
                      style: TextStyle(
                        fontSize: isSelected ? 24 : 18,
                        fontWeight:
                            isSelected ? FontWeight.bold : FontWeight.normal,
                        color: isSelected ? Colors.purpleAccent : Colors.red,
                      ),
                    ),
                  );
                },
              ),
            ),

            /// Center highlight lines
            IgnorePointer(
              child: Container(
                height: 50,
                decoration: const BoxDecoration(
                  border: Border.symmetric(
                    horizontal: BorderSide(
                      color: Colors.pink,
                      width: 1.5,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
