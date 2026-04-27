import 'package:flutter/material.dart';
import 'package:leemcwest/client/presentation/app_screens.dart';
import 'package:leemcwest/client/presentation/builder_screen.dart';
import 'package:leemcwest/client/presentation/intro_onboarding_screen.dart';
import 'package:leemcwest/client/presentation/lesson_intro_screen.dart';
import 'package:leemcwest/client/presentation/menu_screens.dart';
import 'package:leemcwest/client/presentation/settings_screens.dart';
import 'package:leemcwest/client/presentation/test_screen.dart';

class MultiScreenPage extends StatefulWidget {
  const MultiScreenPage({super.key});

  @override
  State<MultiScreenPage> createState() => _MultiScreenPageState();
}

class _MultiScreenPageState extends State<MultiScreenPage> {
  int index = 0;

  final List<Widget> _pageList = [
    const IntroOnboardingScreen(),
    const HomeScreen(),
    const HomeNotificationsScreen(),
    const SavedWorkScreen(),
    const ProgressScreen(),
    const BuilderScreen(),
    const LessonIntroScreen(),
    const BurgerMenuOverlay(),
    const ProfileScreen(),
    const TestScreen(),
   
  ];

  void nextPage() {
    if (index < _pageList.length - 1) {
      setState(() {
        index++;
      });
    }
  }

  void previousPage() {
    if (index > 0) {
      setState(() {
        index--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          /// Screen Area
          Expanded(
            child: _pageList[index],
          ),

          /// Buttons
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: index == 0 ? null : previousPage,
                    icon: const Icon(Icons.skip_previous)),
                IconButton(
                    onPressed: index == _pageList.length - 1 ? null : nextPage,
                    icon: const Icon(Icons.skip_next)),
                // ElevatedButton(
                //   onPressed: index == 0 ? null : previousPage,
                //   child: const Text("Previous"),
                // ),
                // Text(
                //   "Page ${index + 1} / ${_pageList.length}",
                //   style: const TextStyle(fontSize: 16),
                // ),
                // ElevatedButton(
                //   onPressed: index == _pageList.length - 1 ? null : nextPage,
                //   child: const Text("Next"),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
