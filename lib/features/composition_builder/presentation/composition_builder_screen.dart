import 'package:flutter/material.dart';
import 'package:piano/piano.dart';

class CompositionBuilderScreen extends StatefulWidget {
  const CompositionBuilderScreen({super.key});

  @override
  State<CompositionBuilderScreen> createState() =>
      _CompositionBuilderScreenState();
}

class _CompositionBuilderScreenState extends State<CompositionBuilderScreen> {
  String lastNote = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("COMPOSITION BUILDER"),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: Column(
        children: [
          /// Notes Grid
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(10),
              child: GridView.builder(
                itemCount: 32,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 8,
                  childAspectRatio: 1.2,
                ),
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      color: Colors.white,
                    ),
                    child: const Center(
                      child: Text(
                        "",
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          /// Piano Keyboard
          Container(
              height: 140,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Center(
                child: InteractivePiano(
                  highlightedNotes: [
                    NotePosition(note: Note.C, octave: 3)],
                  naturalColor: Colors.white,
                  accidentalColor: Colors.black,
                  keyWidth: 40,
                  noteRange: NoteRange.forClefs([
                    Clef.Treble,
                  ]),
                  onNotePositionTapped: (position) {
                    // Use an audio library like flutter_midi to play the sound
                  },
                ),
              )),

          const SizedBox(height: 10),

          /// Controls
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.skip_previous),
                onPressed: () {},
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(16),
                ),
                child: const Icon(Icons.play_arrow),
              ),
              IconButton(
                icon: const Icon(Icons.skip_next),
                onPressed: () {},
              ),
            ],
          ),

          const SizedBox(height: 10),

          /// Last pressed note display
          Text(
            "Last Note: $lastNote",
            style: const TextStyle(fontSize: 16),
          ),

          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
