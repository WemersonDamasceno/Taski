import 'package:flutter/material.dart';
import 'package:taski/src/core/constants/app_colors.dart';
import 'package:taski/src/core/extensions/theme_extension.dart';

class AppButtomWidget extends StatelessWidget {
  final String label;
  final IconData iconData;
  final Function() onPressed;

  const AppButtomWidget({
    super.key,
    required this.label,
    required this.iconData,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ElevatedButton.icon(
        onPressed: () => onPressed(),
        icon: Icon(iconData),
        style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            elevation: 0,
            backgroundColor: AppColors.blueAccent,
            foregroundColor: AppColors.blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            )),
        label: Text(
          label,
          style: context.textTheme.titleSmall?.copyWith(
            color: AppColors.blue,
          ),
        ),
      ),
    );
  }
}
