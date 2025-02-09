import 'package:flutter/material.dart';
import 'package:taski/src/core/constants/app_images.dart';
import 'package:taski/src/core/constants/app_strings.dart';
import 'package:taski/src/core/extensions/size_extension.dart';
import 'package:taski/src/core/extensions/theme_extension.dart';
import 'package:taski/src/core/widgets/button/view/app_buttom_widget.dart';
import 'package:taski/src/features/create_task/view/create_task_view.dart';

class EmptyListTaskWidget extends StatelessWidget {
  final bool showButton;

  const EmptyListTaskWidget({super.key, this.showButton = true});

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
                child: AppButtonWidget.filled(
                  key: const ValueKey('create-task'),
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
