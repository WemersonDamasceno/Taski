import 'package:flutter/material.dart';
import 'package:nova_design_system/nova_design_system.dart';
import 'package:taski/src/core/constants/app_constants.dart';
import 'package:taski/src/core/constants/app_images.dart';
import 'package:taski/src/core/constants/app_strings.dart';
import 'package:taski/src/core/extensions/size_extension.dart';
import 'package:taski/src/features/create_task/view/create_task_view.dart';

class EmptyListTaskWidget extends StatelessWidget {
  const EmptyListTaskWidget({super.key, this.showButton = true});
  final bool showButton;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: context.mediaQuerySize.height * .1),
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
              Visibility(
                visible: showButton,
                child: UIButton.filled(
                  key: AppConstants.openCreateTask,
                  label: AppStrings.createTask,
                  iconData: Icons.add,
                  onPressed: () {
                    CreateTaskView.showBottomSheet(context);
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
