// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:leemcwest/assets_helper/app_colors.dart';
// import 'package:leemcwest/assets_helper/app_fonts.dart';
// import 'package:leemcwest/helpers/ui_helpers.dart';

// Widget buildQuestionWidget(dynamic question, int index) {
//   return Container(
//     margin: EdgeInsets.only(bottom: 16.h),
//     padding: EdgeInsets.all(16.sp),
//     decoration: BoxDecoration(
//       color: Colors.white,
//       borderRadius: BorderRadius.circular(12.r),
//     ),
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         /// Question Text
//         Text(
//           "${index + 1}. ${question.questionText ?? ""}",
//           style: TextFontStyle.textStyle14w500c6A7282.copyWith(
//             fontSize: 16.sp,
//             color: AppColors.c364153,
//           ),
//         ),

//         UIHelper.verticalSpace(12.h),

//         /// ✅ Render Based On Type
//         if (question.type == "mcq")
//           buildMCQ(question)
//         else if (question.type == "tap_order")
//           buildTapOrder(question)
//         else if (question.type == "drag_drop")
//           buildDragDrop(question),
//       ],
//     ),
//   );
// }