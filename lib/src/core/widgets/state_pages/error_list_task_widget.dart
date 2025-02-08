import 'package:flutter/material.dart';
import 'package:taski/src/core/constants/app_images.dart';
import 'package:taski/src/core/constants/app_strings.dart';
import 'package:taski/src/core/extensions/size_extension.dart';
import 'package:taski/src/core/extensions/theme_extension.dart';
import 'package:taski/src/core/widgets/button/view/app_buttom_widget.dart';

class ErrorListTaskWidget extends StatelessWidget {
  final Function() onPressed;

  const ErrorListTaskWidget({super.key, required this.onPressed});

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
          AppButtonWidget.filled(
            key: const ValueKey('refresh'),
            label: AppStrings.tryAgain,
            onPressed: onPressed,
            iconData: Icons.refresh,
          )
        ],
      ),
    );
  }
}
