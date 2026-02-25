import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leemcwest/helpers/ui_helpers.dart';

class DragDropQuestionWidget extends StatefulWidget {
  final dynamic question;

  const DragDropQuestionWidget({
    Key? key,
    required this.question,
  }) : super(key: key);

  @override
  State<DragDropQuestionWidget> createState() =>
      _DragDropQuestionWidgetState();
}

class _DragDropQuestionWidgetState
    extends State<DragDropQuestionWidget> {

  late List<String?> dragAnswers;
  late List<String> tokens;
  late List<String> slots;

  @override
  void initState() {
    super.initState();

    tokens = List<String>.from(widget.question.options["tokens"]);
    slots = List<String>.from(widget.question.options["slots"]);

    dragAnswers = List.generate(slots.length, (_) => null);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        /// TOKENS (Draggable)
        Wrap(
          spacing: 10,
          children: List.generate(tokens.length, (index) {
            String token = tokens[index];

            return Draggable<String>(
              data: token,

              feedback: Material(
                color: Colors.transparent,
                child: _buildTokenContainer(
                  token,
                  Colors.blue,
                  Colors.white,
                ),
              ),

              childWhenDragging: _buildTokenContainer(
                token,
                Colors.grey.shade300,
                Colors.black,
              ),

              child: _buildTokenContainer(
                token,
                Colors.grey.shade200,
                Colors.black,
              ),
            );
          }),
        ),

        UIHelper.verticalSpace(16.h),

        /// SLOTS (DragTarget)
        Column(
          children: List.generate(slots.length, (slotIndex) {
            return DragTarget<String>(
              onAccept: (data) {
                setState(() {
                  dragAnswers[slotIndex] = data;
                });
              },
              builder: (context, candidateData, rejectedData) {
                return Container(
                  margin: EdgeInsets.only(bottom: 10.h),
                  padding: EdgeInsets.all(14.sp),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    dragAnswers[slotIndex] ?? "Drop here",
                    style: TextStyle(fontSize: 14.sp),
                  ),
                );
              },
            );
          }),
        ),
      ],
    );
  }

  Widget _buildTokenContainer(
      String text,
      Color bgColor,
      Color textColor,
      ) {
    return Container(
      padding: EdgeInsets.all(12.sp),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: TextStyle(color: textColor),
      ),
    );
  }
}