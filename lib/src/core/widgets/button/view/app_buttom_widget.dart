import 'package:flutter/material.dart';
import 'package:taski/src/core/constants/app_colors.dart';
import 'package:taski/src/core/enums/status_button_enum.dart';
import 'package:taski/src/core/extensions/theme_extension.dart';

class AppButtonWidget extends StatelessWidget {
  final String label;
  final IconData? iconData;
  final Color? colorLabel;
  final Function() onPressed;
  final bool isFilled;
  final StatusButtonEnum statusButton;

  const AppButtonWidget._({
    required this.label,
    required this.onPressed,
    required this.isFilled,
    required this.statusButton,
    this.iconData,
    this.colorLabel,
  });

  factory AppButtonWidget.filled({
    required String label,
    required Function() onPressed,
    StatusButtonEnum? statusButton,
    IconData? iconData,
  }) {
    return AppButtonWidget._(
      label: label,
      statusButton: statusButton ?? StatusButtonEnum.enable,
      onPressed: onPressed,
      iconData: iconData,
      isFilled: true,
    );
  }

  factory AppButtonWidget.textButton({
    required String label,
    required Function() onPressed,
    Color? colorLabel,
    StatusButtonEnum? statusButton,
    IconData? iconData,
  }) {
    return AppButtonWidget._(
      label: label,
      isFilled: false,
      iconData: iconData,
      onPressed: onPressed,
      colorLabel: colorLabel,
      statusButton: statusButton ?? StatusButtonEnum.enable,
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isLoading = statusButton == StatusButtonEnum.loading;
    bool isDisabled = statusButton == StatusButtonEnum.disable;
    return SizedBox(
      height: 50,
      child: ElevatedButton.icon(
        onPressed: () => isDisabled || isLoading ? null : onPressed(),
        icon: iconData != null && !isLoading ? Icon(iconData) : null,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          elevation: 0,
          backgroundColor: isFilled ? AppColors.blueAccent : Colors.transparent,
          foregroundColor: AppColors.blue,
          shape: isFilled
              ? RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: isFilled
                      ? BorderSide.none
                      : const BorderSide(color: AppColors.blueAccent),
                )
              : null,
        ),
        label: Visibility(
          visible: isLoading,
          replacement: Text(
            label,
            style: context.textTheme.titleSmall?.copyWith(
              color: isDisabled
                  ? AppColors.mutedAzure
                  : colorLabel ?? AppColors.blue,
              fontWeight: isFilled ? FontWeight.w600 : FontWeight.w700,
            ),
          ),
          child: const SizedBox(
            height: 24,
            width: 24,
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
