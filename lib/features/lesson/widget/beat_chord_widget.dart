import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leemcwest/assets_helper/app_colors.dart';
import 'package:leemcwest/assets_helper/app_fonts.dart';
import 'package:leemcwest/helpers/ui_helpers.dart';

class BeatChordWidget extends StatelessWidget {
  final String chords;
  final String? droppedValue;
  final Function(String) onDrop;
  final Function onRemove;

  const BeatChordWidget({
    super.key,
    required this.chords,
    required this.droppedValue,
    required this.onDrop,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return DragTarget<String>(
      // ignore: unnecessary_null_comparison
      onWillAcceptWithDetails: (data) => data != null,
      onAcceptWithDetails: (value) {
        //onDrop(value);
      },
      builder: (context, candidateData, rejectedData) {
        final bool isDragOver = candidateData.isNotEmpty;

        return GestureDetector(
          onTap: droppedValue != null
              ? () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Remove $droppedValue?'),
                      content: Text('Do you want to remove $droppedValue from $chords?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            onRemove();
                            Navigator.pop(context);
                          },
                          child: const Text('Remove', style: TextStyle(color: Colors.red)),
                        ),
                      ],
                    ),
                  );
                }
              : null,
          child: DottedBorder(
            color: isDragOver
                ? Colors.green
                : AppColors.c99A1AF,
            dashPattern: const [6, 4],
            strokeWidth: isDragOver ? 2 : 1,
            borderType: BorderType.RRect,
            radius: Radius.circular(10.r),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                horizontal: 20.w,
                vertical: 12.h,
              ),
              decoration: BoxDecoration(
                color: isDragOver ? Colors.green.withValues(alpha: .1) : AppColors.cE7ECF1,
                borderRadius: BorderRadius.circular(10.r),
              ),
              alignment: Alignment.center,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (droppedValue != null)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          droppedValue!,
                          style: TextFontStyle.textStyle14w500c6A7282.copyWith(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Icon(
                          Icons.check_circle,
                          color: Colors.green,
                          size: 16.sp,
                        ),
                      ],
                    )
                  else
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          chords,
                          style: TextFontStyle.textStyle14w500c6A7282.copyWith(
                            color: AppColors.c061426,
                          ),
                        ),
                        UIHelper.verticalSpace(4.h),
                        Text(
                          isDragOver ? 'Release to drop' : 'Drop chord here',
                          style: TextFontStyle.textStyle12w400c64748B.copyWith(
                            color: isDragOver ? Colors.green : AppColors.c6A7282,
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}