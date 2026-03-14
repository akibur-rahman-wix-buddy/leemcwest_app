import 'package:flutter/material.dart';
import 'package:leemcwest/assets_helper/app_colors.dart';
import 'package:leemcwest/assets_helper/app_image.dart';
import 'package:leemcwest/client/presentation/app_screens.dart';


class ClientNavigationsBarScreen extends StatefulWidget {
  final int? pageNum;
  const ClientNavigationsBarScreen({super.key, this.pageNum});

  @override
  State<ClientNavigationsBarScreen> createState() => _ClientNavigationsBarScreenState();
}

class _ClientNavigationsBarScreenState extends State<ClientNavigationsBarScreen> {
  
  int index = 0; // Corrected variable name
  final List _pageList = [
    const HomeScreen(),
    const HomeNotificationsScreen(),
    const SavedWorkScreen(),
    const ProgressScreen(),
  ];
  @override
  void initState() {
    super.initState();
    index = widget.pageNum ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pageList[index],
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.transparent,
        showUnselectedLabels: true, // Show labels for unselected items
        type: BottomNavigationBarType.fixed, // Fixed type for equal spacing
        selectedItemColor: Colors.blue, // Selected icon and label color
        selectedLabelStyle: const TextStyle(
            color: Colors.blue, fontSize: 14), // Selected label style
        unselectedItemColor: const Color(0xFF192A48), // Unselected icon color
        unselectedLabelStyle: const TextStyle(
            color: Color(0xFF192A48), fontSize: 14), // Unselected label style
        enableFeedback: false, // Enable feedback (true for haptic feedback)

        elevation: 0,
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(AppImages.home,
                height: 24, color: index == 0 ? AppColors.onboardingButtonColor : AppColors.c798090),
            label: 'Home',
            
            backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
            icon: Image.asset(AppImages.lesson,
                height: 24, color: index == 1 ? AppColors.onboardingButtonColor : AppColors.c798090),
            label: 'Lesson',
            backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
            icon: Image.asset(AppImages.progress,
                height: 23, color: index == 2 ? AppColors.onboardingButtonColor : AppColors.c798090),
            label: 'Progress',
            backgroundColor: Colors.black,
          ),
          BottomNavigationBarItem(
            icon: Image.asset(AppImages.user,
                height: 24, color: index == 3 ? AppColors.onboardingButtonColor : AppColors.c798090),
            label: 'Profile',
            backgroundColor: Colors.white,
          ),
        ],
        currentIndex: index,
        onTap: (int selectedIndex) {
          setState(() {
            index = selectedIndex; // Update the index when a tab is selected
          });
        },
      ),
    );
  }
}
