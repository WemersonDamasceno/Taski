import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:taski/src/core/constants/app_colors.dart';
import 'package:taski/src/core/extensions/theme_extension.dart';

class AppInputTextWidget extends StatelessWidget {
  const AppInputTextWidget({
    super.key,
    required this.controller,
    required this.hintText,
    this.maxLength = 100,
  });

  final TextEditingController controller;
  final int maxLength;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextField(
        cursorColor: AppColors.slateBlue,
        controller: controller,
        style: context.textTheme.titleSmall?.copyWith(
          color: AppColors.slatePurple,
        ),
        maxLines: 4,
        minLines: 1,
        inputFormatters: [
          LengthLimitingTextInputFormatter(maxLength),
        ],
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: context.textTheme.titleSmall?.copyWith(
            color: AppColors.slateBlue,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
