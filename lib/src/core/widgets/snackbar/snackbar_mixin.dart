import 'package:flutter/material.dart';

import 'snackbar_floating.dart';

mixin SnackbarMixin {
  showSnackbar({
    required BuildContext context,
    required String message,
    required Color backgroundColor,
    required Color fontColor,
    required IconData iconData,
  }) {
    return SnackbarFloating(
      context: context,
      iconData: iconData,
      labelSnackbar: message,
      snackbarBackgroundColor: backgroundColor,
      snackbarFontColor: fontColor,
      margin: const EdgeInsets.only(
        bottom: 82,
        left: 24,
        right: 24,
      ),
    ).show();
  }
}
