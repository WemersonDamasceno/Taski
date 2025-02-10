import 'package:flutter/material.dart';
import 'package:taski/src/core/constants/app_colors.dart';
import 'package:taski/src/core/enums/status_button_enum.dart';
import 'package:taski/src/core/extensions/theme_extension.dart';

class AppButtonWidget extends StatelessWidget {
  const AppButtonWidget._({
    required this.label,
    required this.onPressed,
    required this.isFilled,
    required this.statusButton,
    super.key,
    this.iconData,
    this.colorLabel,
  });

  factory AppButtonWidget.filled({
    required String label,
    required Function() onPressed,
    Key? key,
    StatusButtonEnum? statusButton,
    IconData? iconData,
  }) {
    return AppButtonWidget._(
      key: key,
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
    Key? key,
    Color? colorLabel,
    StatusButtonEnum? statusButton,
    IconData? iconData,
  }) {
    return AppButtonWidget._(
      key: key,
      label: label,
      isFilled: false,
      iconData: iconData,
      onPressed: onPressed,
      colorLabel: colorLabel,
      statusButton: statusButton ?? StatusButtonEnum.enable,
    );
  }
  final String label;
  final IconData? iconData;
  final Color? colorLabel;
  final Function() onPressed;
  final bool isFilled;
  final StatusButtonEnum statusButton;

  @override
  Widget build(BuildContext context) {
    final bool isLoading = statusButton == StatusButtonEnum.loading;
    final bool isDisabled = statusButton == StatusButtonEnum.disable;

    return SizedBox(
      child: ElevatedButton.icon(
        key: key,
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
