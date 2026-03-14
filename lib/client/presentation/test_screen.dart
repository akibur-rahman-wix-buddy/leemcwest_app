import 'package:flutter/material.dart';
import 'package:leemcwest/client/presentation/case_study_elements.dart';
import 'package:leemcwest/client/presentation/case_study_models.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final elements = [
      StudyElement(
        type: StudyElementType.text,
        text: "This is a text block",
      ),

      StudyElement(
        type: StudyElementType.keyPoint,
        title: "Key Idea",
        text: "Practice with metronome",
      ),

      StudyElement(
        type: StudyElementType.audioPlay,
        label: "Play groove example",
      ),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("Study")),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: elements
            .map((e) => StudyElementRenderer(element: e))
            .toList(),
      ),
    );
  }
}