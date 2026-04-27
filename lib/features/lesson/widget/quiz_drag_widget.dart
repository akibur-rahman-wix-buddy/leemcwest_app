import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leemcwest/common_widgets/custom_button.dart';
import 'package:leemcwest/helpers/ui_helpers.dart';

class DragDropQuestionWidget extends StatefulWidget {
  final dynamic question;
  final VoidCallback checkOntap;

  /// ✅ ADD CALLBACK
  final Function(int questionId, List<int> answer) onAnswer;

  const DragDropQuestionWidget({
    super.key,
    required this.question,
    required this.onAnswer,
    required this.checkOntap,
  });

  @override
  State<DragDropQuestionWidget> createState() => _DragDropQuestionWidgetState();
}

class _DragDropQuestionWidgetState extends State<DragDropQuestionWidget> {
  late List<String?> dragAnswers;
  late List<String> tokens;
  late List<String> slots;

  @override
  void initState() {
    super.initState();

    tokens = List<String>.from(widget.question.options?.tokens ?? []);

    slots = List<String>.from(widget.question.options?.slots ?? []);

    dragAnswers = List.generate(slots.length, (_) => null);
  }

  /// ✅ Convert token answers to index list
  void _updateParentAnswer() {
    List<int> answerIndexes = [];

    for (int i = 0; i < dragAnswers.length; i++) {
      String? selectedToken = dragAnswers[i];

      if (selectedToken != null) {
        int index = tokens.indexOf(selectedToken);
        answerIndexes.add(index);
      }
    }

    /// Send to parent screen
    widget.onAnswer(widget.question.id, answerIndexes);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// TOKENS (Draggable)
        Wrap(
          spacing: 10,
          runSpacing: 10,
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
              onAcceptWithDetails: (data) {
                // setState(() {
                //   dragAnswers[slotIndex] = data;
                // });

                /// ✅ Update parent after every drop
                _updateParentAnswer();
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
                    dragAnswers[slotIndex] ?? slots[slotIndex],
                    style: TextStyle(fontSize: 14.sp),
                  ),
                );
              },
            );
          }),
        ),
        UIHelper.verticalSpace(16.h),
        customButton(
          name: "Check Answer",
          onCallBack: widget.checkOntap,
          context: context,
        )
      ],
    );
  }

  Widget _buildTokenContainer(
    String text,
    Color bgColor,
    Color textColor,
  ) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 14.w,
        vertical: 10.h,
      ),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontSize: 14.sp,
        ),
      ),
    );
  }
}
