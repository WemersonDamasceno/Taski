import 'package:flutter/material.dart';
import 'package:taski/src/core/constants/app_colors.dart';
import 'package:taski/src/core/extensions/theme_extension.dart';

class SnackbarFloating extends StatefulWidget {
  final BuildContext context;
  final String labelSnackbar;
  final Color snackbarBackgroundColor;
  final Color snackbarFontColor;
  final EdgeInsets margin;
  final IconData iconData;

  const SnackbarFloating({
    super.key,
    required this.context,
    required this.labelSnackbar,
    required this.snackbarBackgroundColor,
    required this.snackbarFontColor,
    required this.margin,
    required this.iconData,
  });

  void show() {
    if (!context.mounted) return;
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    scaffoldMessenger.hideCurrentSnackBar();
    scaffoldMessenger.showSnackBar(
      SnackBar(
        content: this,
        backgroundColor: Colors.transparent,
        elevation: 0,
        behavior: SnackBarBehavior.fixed,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  State<SnackbarFloating> createState() => _SnackbarFloatingState();
}

class _SnackbarFloatingState extends State<SnackbarFloating> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: widget.snackbarBackgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              widget.labelSnackbar,
              style: context.textTheme.labelMedium?.copyWith(
                color: widget.snackbarFontColor,
              ),
            ),
          ),
          Icon(
            widget.iconData,
            color: AppColors.white,
          ),
        ],
      ),
    );
  }
}
