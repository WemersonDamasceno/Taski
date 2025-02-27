import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:nova_design_system/nova_design_system.dart';
import 'package:taski/src/core/constants/app_constants.dart';
import 'package:taski/src/core/constants/app_strings.dart';
import 'package:taski/src/core/enums/state_enum.dart';
import 'package:taski/src/core/extensions/size_extension.dart';
import 'package:taski/src/core/mixins/task_notifier_mixin.dart';
import 'package:taski/src/core/models/task_event.dart';
import 'package:taski/src/core/widgets/button/bloc/button_cubit.dart';
import 'package:taski/src/core/widgets/button/bloc/button_state.dart';
import 'package:taski/src/features/create_task/bloc/create_task_bloc.dart';
import 'package:taski/src/features/create_task/bloc/create_task_event.dart';
import 'package:taski/src/features/create_task/bloc/create_task_state.dart';

class CreateTaskView extends StatefulWidget {
  const CreateTaskView({super.key});

  static void showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      constraints: BoxConstraints(
        minHeight: context.mediaQuerySize.height * .5,
      ),
      useSafeArea: true,
      backgroundColor: UIAppColors.white,
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

class _CreateTaskViewState extends State<CreateTaskView>
    with UISnackbarMixin, TaskNotifierMixin {
  final TextEditingController _taskController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  late ButtonCubit _buttonCubit;
  late CreateTaskBloc _createTaskBloc;

  @override
  void initState() {
    super.initState();
    _createTaskBloc = GetIt.I.get<CreateTaskBloc>();
    _buttonCubit = GetIt.I.get<ButtonCubit>();

    _buttonCubit.changeStatusButton(UIStatusButton.disable);

    _taskController.addListener(() {
      if (_taskController.text.isNotEmpty) {
        _buttonCubit.changeStatusButton(UIStatusButton.enable);
        return;
      }
      _buttonCubit.changeStatusButton(UIStatusButton.disable);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreateTaskBloc, CreateTaskState>(
      bloc: _createTaskBloc,
      listener: (context, state) {
        switch (state.stateEnum) {
          case StateEnum.success:
            notifyTaskModification(
              state.taskCreated,
              TaskOperation.createOrUpdate,
            );
            Navigator.pop(context);

            showSnackbarSuccess(
              context: context,
              message: AppStrings.successCreateTask,
            );
            break;
          case StateEnum.error:
            Navigator.pop(context);
            showSnackbarError(
              context: context,
              message: AppStrings.errorTitle,
            );
            break;
          default:
            _buttonCubit.changeStatusButton(UIStatusButton.loading);
        }
      },
      builder: (_, state) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            right: 26,
            left: 26,
            top: 32,
          ),
          child: SingleChildScrollView(
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
                    UITextInput(
                      key: AppConstants.taskInput,
                      hintText: AppStrings.hintTask,
                      controller: _taskController,
                      maxLength: 40,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(right: 16, left: 16, top: 12),
                      child: Icon(Icons.edit, color: UIAppColors.mutedAzure),
                    ),
                    UITextInput(
                      key: AppConstants.noteInput,
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
                      child: UIButton.textButton(
                        key: AppConstants.createTaskButton,
                        label: AppStrings.create,
                        statusButton: state.statusButton,
                        onPressed: () => _createTaskBloc.add(
                          CreateTask(
                            task: _taskController.text,
                            note: _noteController.text,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
