import 'package:flutter/material.dart';
import 'package:taski/src/core/constants/app_colors.dart';
import 'package:taski/src/core/constants/app_strings.dart';

class HeaderPage extends StatelessWidget {
  const HeaderPage({required this.quantityTasks, super.key});
  final int quantityTasks;

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
                  text: 'John.',
                  style: TextStyle(
                    color: AppColors.blue,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            quantityTasks == 0
                ? AppStrings.emptyDescription
                : AppStrings.welcomeDescription(quantityTasks.toString()),
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
