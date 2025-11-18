// common_widget/pinput_field.dart

// ignore_for_file: use_super_parameters

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leemcwest/assets_helper/app_colors.dart';
import 'package:pinput/pinput.dart';

class PinputField extends StatefulWidget {
  final TextEditingController? controller;

  const PinputField({Key? key, this.controller}) : super(key: key);

  @override
  State<PinputField> createState() => _PinputFieldState();
}

class _PinputFieldState extends State<PinputField> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _pinController;
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _pinController = widget.controller ?? TextEditingController();
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _pinController.dispose();
    }
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const focusedBorderColor = AppColors.onboardingButtonColor;
    const defaultBorderColor = AppColors.cF3F4F6;

    // Background ALWAYS same
    final baseDecoration = BoxDecoration(
      color: AppColors.cF3F4F6,
      borderRadius: BorderRadius.circular(16.r),
    );

    // Default theme (same as before)
    final defaultPinTheme = PinTheme(
      width: 56.w,
      height: 56.h,
      textStyle: const TextStyle(
        fontSize: 20,
        color: AppColors.c000000,
      ),
      decoration: baseDecoration.copyWith(
        border: Border.all(color: defaultBorderColor),
      ),
    );

    // Focused theme (same as before)
    final focusedPinTheme = defaultPinTheme.copyWith(
      decoration: baseDecoration.copyWith(
        border: Border.all(color: focusedBorderColor),
      ),
    );

    // Submitted theme (same as before)
    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: baseDecoration.copyWith(
        border: Border.all(color: focusedBorderColor),
      ),
    );

    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Pinput(
            length: 4,
            controller: _pinController,
            focusNode: _focusNode,
            defaultPinTheme: defaultPinTheme,
            focusedPinTheme: focusedPinTheme,
            submittedPinTheme: submittedPinTheme,
            errorPinTheme: defaultPinTheme.copyBorderWith(
              border: Border.all(color: Colors.redAccent),
            ),
          ),
        ],
      ),
    );
  }
}
