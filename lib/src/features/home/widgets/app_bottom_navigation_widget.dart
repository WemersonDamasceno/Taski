import 'package:flutter/material.dart';
import 'package:nova_design_system/nova_design_system.dart';
import 'package:taski/src/core/constants/app_images.dart';
import 'package:taski/src/core/constants/app_strings.dart';
import 'package:taski/src/features/home/widgets/icon_bottom_navigation_widget.dart';

class AppBottomNavigationWidget extends StatelessWidget {
  const AppBottomNavigationWidget({
    required this.selectedIndex,
    required this.onItemTapped,
    super.key,
  });
  final int selectedIndex;
  final void Function(int index) onItemTapped;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      onTap: onItemTapped,
      enableFeedback: true,
      selectedItemColor: UIAppColors.blue,
      unselectedItemColor: UIAppColors.mutedAzure,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      items: [
        BottomNavigationBarItem(
          icon: IconBottomNavigationWidget(
            image: AppImages.todo,
            isSelected: selectedIndex == 0,
          ),
          backgroundColor: UIAppColors.white,
          label: AppStrings.todoBottomNavigator,
        ),
        BottomNavigationBarItem(
          icon: IconBottomNavigationWidget(
            image: AppImages.create,
            isSelected: selectedIndex == 1,
          ),
          backgroundColor: UIAppColors.white,
          label: AppStrings.createBottomNavigator,
        ),
        BottomNavigationBarItem(
          icon: IconBottomNavigationWidget(
            image: AppImages.searchImage,
            isSelected: selectedIndex == 2,
          ),
          backgroundColor: UIAppColors.white,
          label: AppStrings.searchBottomNavigator,
        ),
        BottomNavigationBarItem(
          icon: IconBottomNavigationWidget(
            image: AppImages.done,
            isSelected: selectedIndex == 3,
          ),
          backgroundColor: UIAppColors.white,
          label: AppStrings.doneBottomNavigator,
        ),
      ],
    );
  }
}
