import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taski/src/core/constants/app_colors.dart';
import 'package:taski/src/core/constants/app_strings.dart';
import 'package:taski/src/core/extensions/theme_extension.dart';
import 'package:taski/src/features/done_tasks/bloc/enable_buton/enable_button_cubit.dart';
import 'package:taski/src/features/done_tasks/bloc/enable_buton/enable_button_state.dart';

class HeaderCompletedTasks extends StatelessWidget {
  const HeaderCompletedTasks({
    required this.onPressed,
    required this.enableDeleteButton,
    super.key,
  });
  final Function() onPressed;
  final EnableDeleteButtonCubit enableDeleteButton;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            AppStrings.titleDoneTasks,
            style: context.textTheme.titleMedium?.copyWith(
              color: AppColors.slatePurple,
            ),
          ),
          BlocBuilder<EnableDeleteButtonCubit, EnableButtonState>(
            bloc: enableDeleteButton,
            builder: (__, state) {
              return TextButton(
                onPressed: () => state.enable ? onPressed() : null,
                child: Text(
                  AppStrings.deleteAllTasks,
                  style: context.textTheme.bodyMedium?.copyWith(
                    color:
                        state.enable ? AppColors.fireRed : AppColors.mutedAzure,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
