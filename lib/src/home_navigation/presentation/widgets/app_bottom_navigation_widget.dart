import 'package:flutter/material.dart';
import 'package:taski/src/core/constants/app_colors.dart';

class AppBottomNavigationWidget extends StatelessWidget {
  final int selectedIndex;
  final void Function(int index) onItemTapped;

  const AppBottomNavigationWidget({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      onTap: onItemTapped,
      enableFeedback: true,
      selectedItemColor: AppColors.blue,
      unselectedItemColor: AppColors.mutedAzure,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.ballot_outlined),
          backgroundColor: AppColors.white,
          label: "Todo",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add_box_outlined),
          backgroundColor: AppColors.white,
          label: "Create",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          backgroundColor: AppColors.white,
          label: "Search",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.check_box_outlined),
          backgroundColor: AppColors.white,
          label: "Done",
        ),
      ],
    );
  }
}
