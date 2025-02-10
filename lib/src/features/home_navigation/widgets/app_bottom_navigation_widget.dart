import 'package:flutter/material.dart';
import 'package:taski/src/core/constants/app_colors.dart';
import 'package:taski/src/core/constants/app_images.dart';
import 'package:taski/src/core/constants/app_strings.dart';
import 'package:taski/src/features/home_navigation/widgets/icon_bottom_navigation_widget.dart';

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
      items: [
        BottomNavigationBarItem(
          icon: IconBottomNavigationWidget(
            image: AppImages.todo,
            isSelected: selectedIndex == 0,
          ),
          backgroundColor: AppColors.white,
          label: AppStrings.todoBottomNavigator,
        ),
        BottomNavigationBarItem(
          icon: IconBottomNavigationWidget(
            image: AppImages.create,
            isSelected: selectedIndex == 1,
          ),
          backgroundColor: AppColors.white,
          label: AppStrings.createBottomNavigator,
        ),
        BottomNavigationBarItem(
          icon: IconBottomNavigationWidget(
            image: AppImages.searchImage,
            isSelected: selectedIndex == 2,
          ),
          backgroundColor: AppColors.white,
          label: AppStrings.searchBottomNavigator,
        ),
        BottomNavigationBarItem(
          icon: IconBottomNavigationWidget(
            image: AppImages.done,
            isSelected: selectedIndex == 3,
          ),
          backgroundColor: AppColors.white,
          label: AppStrings.doneBottomNavigator,
        ),
      ],
    );
  }
}
