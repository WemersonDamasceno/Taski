import 'package:flutter/material.dart';
import 'package:taski/src/core/constants/app_colors.dart';

import 'snackbar_floating.dart';

mixin SnackbarMixin {
  void showSnackbarSuccess({
    required BuildContext context,
    required String message,
  }) {
    return SnackbarFloating(
      context: context,
      snackbarFontColor: AppColors.white,
      snackbarBackgroundColor: AppColors.greenPure,
      iconData: Icons.check_circle_outline_rounded,
      labelSnackbar: message,
      margin: const EdgeInsets.only(
        bottom: 82,
        left: 24,
        right: 24,
      ),
    ).show();
  }

  void showSnackbarError({
    required BuildContext context,
    required String message,
  }) {
    return SnackbarFloating(
      context: context,
      snackbarBackgroundColor: AppColors.redLight,
      iconData: Icons.warning_amber_rounded,
      snackbarFontColor: AppColors.white,
      labelSnackbar: message,
      margin: const EdgeInsets.only(
        bottom: 82,
        left: 24,
        right: 24,
      ),
    ).show();
  }
}
