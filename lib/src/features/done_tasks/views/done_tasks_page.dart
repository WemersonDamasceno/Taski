import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:taski/src/features/done_tasks/bloc/list_done_task_bloc.dart';
import 'package:taski/src/features/done_tasks/views/done_tasks_view.dart';

class DoneTasksPage extends StatelessWidget {
  const DoneTasksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ListDoneTaskBloc>(
          create: (_) => GetIt.I.get<ListDoneTaskBloc>(),
        ),
      ],
      child: const CompletedTasksView(),
    );
  }
}
