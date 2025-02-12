import 'package:flutter/material.dart';
import 'package:nova_design_system/nova_design_system.dart';
import 'package:taski/src/core/constants/app_constants.dart';
import 'package:taski/src/core/constants/app_images.dart';
import 'package:taski/src/core/constants/app_strings.dart';
import 'package:taski/src/core/extensions/size_extension.dart';

class ErrorListTaskWidget extends StatelessWidget {
  const ErrorListTaskWidget({required this.onPressed, super.key});
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(height: context.mediaQuerySize.height * .15),
          Image.asset(
            AppImages.errorImage,
            width: 80,
            height: 80,
          ),
          const SizedBox(height: 24),
          Text(
            AppStrings.errorTitle,
            style: context.textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Text(
            AppStrings.errorDescription,
            style: context.textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          UIButton.filled(
            key: AppConstants.refresh,
            label: AppStrings.tryAgain,
            onPressed: onPressed,
            iconData: Icons.refresh,
          ),
        ],
      ),
    );
  }
}
