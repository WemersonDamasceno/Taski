import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:taski/src/core/constants/app_colors.dart';
import 'package:taski/src/core/constants/app_strings.dart';
import 'package:taski/src/core/enums/state_enum.dart';
import 'package:taski/src/core/enums/status_button_enum.dart';
import 'package:taski/src/core/widgets/app_input_text_widget.dart';
import 'package:taski/src/core/widgets/button/bloc/button_cubit.dart';
import 'package:taski/src/core/widgets/button/bloc/button_state.dart';
import 'package:taski/src/core/widgets/button/view/app_buttom_widget.dart';
import 'package:taski/src/core/widgets/snackbar/snackbar_mixin.dart';
import 'package:taski/src/create_task/presentation/bloc/create_task_bloc.dart';
import 'package:taski/src/create_task/presentation/bloc/create_task_event.dart';
import 'package:taski/src/create_task/presentation/bloc/create_task_state.dart';

class CreateTaskView extends StatefulWidget {
  const CreateTaskView({super.key});

  static void showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      useSafeArea: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => MultiBlocProvider(
        providers: [
          BlocProvider<CreateTaskBloc>(
            create: (_) => GetIt.I.get<CreateTaskBloc>(),
          ),
          BlocProvider<ButtonCubit>(
            create: (_) => GetIt.I.get<ButtonCubit>(),
          ),
        ],
        child: const CreateTaskView(),
      ),
    );
  }

  @override
  State<CreateTaskView> createState() => _CreateTaskViewState();
}

class _CreateTaskViewState extends State<CreateTaskView> with SnackbarMixin {
  final TextEditingController _taskController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  late ButtonCubit _buttonCubit;
  late CreateTaskBloc _createTaskBloc;

  @override
  void initState() {
    super.initState();
    _createTaskBloc = GetIt.I.get<CreateTaskBloc>();
    _buttonCubit = GetIt.I.get<ButtonCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreateTaskBloc, CreateTaskState>(
        bloc: _createTaskBloc,
        listener: (context, state) {
          switch (state.stateEnum) {
            case StateEnum.success:
              Navigator.pop(context);
              showSnackbar(
                context: context,
                message: AppStrings.successCreateTask,
                backgroundColor: AppColors.greenPure,
                iconData: Icons.check_circle_outline_rounded,
                fontColor: AppColors.white,
              );
              break;
            case StateEnum.error:
              Navigator.pop(context);
              showSnackbar(
                context: context,
                message: AppStrings.errorTitle,
                backgroundColor: AppColors.redLight,
                iconData: Icons.warning_amber_rounded,
                fontColor: AppColors.white,
              );
              break;
            default:
              _buttonCubit.changeStatusButton(StatusButtonEnum.loading);
          }
        },
        builder: (_, state) {
          return Container(
            height: MediaQuery.of(context).size.height * .5,
            padding: const EdgeInsets.only(top: 34, left: 42, right: 42),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Transform.scale(
                      scale: 1.33,
                      child:
                          Checkbox(value: false, onChanged: (bool? value) {}),
                    ),
                    AppInputTextWidget(
                      hintText: AppStrings.hintTask,
                      controller: _taskController,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(right: 16, left: 16, top: 12),
                      child: Icon(Icons.edit, color: AppColors.mutedAzure),
                    ),
                    AppInputTextWidget(
                      hintText: AppStrings.hintAddNote,
                      controller: _noteController,
                    ),
                  ],
                ),
                const SizedBox(height: 48),
                BlocBuilder<ButtonCubit, ButtonState>(
                  bloc: _buttonCubit,
                  builder: (context, state) {
                    return Align(
                      alignment: Alignment.centerRight,
                      child: AppButtonWidget.textButton(
                        onPressed: () => _createTaskBloc.add(CreateTask(
                          task: _taskController.text,
                          note: _noteController.text,
                        )),
                        statusButton: state.statusButton,
                        label: 'Create',
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        });
  }
}
