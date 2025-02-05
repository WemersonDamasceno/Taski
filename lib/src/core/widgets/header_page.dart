import 'package:flutter/material.dart';
import 'package:taski/src/core/constants/app_colors.dart';
import 'package:taski/src/core/constants/app_strings.dart';
import 'package:taski/src/core/models/task_model.dart';

class HeaderPage extends StatelessWidget {
  final List<TaskModel> tasks;

  const HeaderPage({super.key, required this.tasks});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: const TextSpan(
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              children: [
                TextSpan(
                  text: AppStrings.welcomeTitle,
                  style: TextStyle(
                    color: AppColors.slatePurple,
                  ),
                ),
                TextSpan(
                  text: "John.",
                  style: TextStyle(
                    color: AppColors.blue,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            tasks.isEmpty
                ? AppStrings.emptyDescription
                : AppStrings.welcomeDescription(tasks.length.toString()),
            style: const TextStyle(
              color: AppColors.slateBlue,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
