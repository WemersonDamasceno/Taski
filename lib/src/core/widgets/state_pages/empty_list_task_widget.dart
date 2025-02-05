import 'package:flutter/material.dart';
import 'package:taski/src/core/constants/app_colors.dart';
import 'package:taski/src/core/constants/app_images.dart';
import 'package:taski/src/core/constants/app_strings.dart';
import 'package:taski/src/core/extensions/theme_extension.dart';
import 'package:taski/src/core/widgets/button/view/app_buttom_widget.dart';
import 'package:taski/src/features/create_task/view/create_task_view.dart';

class EmptyListTaskWidget extends StatelessWidget {
  const EmptyListTaskWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
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
        const Text(
          AppStrings.emptyDescription,
          style: TextStyle(
            color: AppColors.slateBlue,
            fontSize: 16,
          ),
        ),
        SizedBox(height: size.height * .15),
        Center(
          child: Column(
            children: [
              Image.asset(AppImages.emptyImage),
              const SizedBox(height: 24),
              Text(
                AppStrings.emptyTitle,
                style: context.textTheme.bodyMedium,
              ),
              const SizedBox(height: 24),
              AppButtonWidget.filled(
                label: AppStrings.createTask,
                iconData: Icons.add,
                onPressed: () {
                  CreateTaskView.showBottomSheet(context);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
