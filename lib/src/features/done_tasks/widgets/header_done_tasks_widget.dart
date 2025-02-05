import 'package:flutter/material.dart';
import 'package:taski/src/core/constants/app_colors.dart';
import 'package:taski/src/core/constants/app_strings.dart';
import 'package:taski/src/core/extensions/theme_extension.dart';

class HeaderCompletedTasks extends StatelessWidget {
  final Function() onPressed;

  const HeaderCompletedTasks({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            AppStrings.titleDoneTasks,
            style: context.textTheme.titleMedium?.copyWith(
              color: AppColors.slatePurple,
            ),
          ),
          TextButton(
            onPressed: () => onPressed(),
            child: Text(AppStrings.deleteAllTasks,
                style: context.textTheme.bodyMedium?.copyWith(
                  color: AppColors.fireRed,
                )),
          ),
        ],
      ),
    );
  }
}
