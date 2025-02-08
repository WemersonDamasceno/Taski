import 'package:flutter/material.dart';
import 'package:taski/src/core/constants/app_images.dart';
import 'package:taski/src/core/constants/app_strings.dart';
import 'package:taski/src/core/extensions/size_extension.dart';
import 'package:taski/src/core/extensions/theme_extension.dart';

class NotFoundTasksWidget extends StatelessWidget {
  const NotFoundTasksWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: context.mediaQuerySize.height * .15),
        Center(
          child: Column(
            children: [
              Image.asset(AppImages.emptyImage),
              const SizedBox(height: 24),
              Text(
                AppStrings.notFoundTaks,
                style: context.textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
