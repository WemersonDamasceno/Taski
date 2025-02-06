import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:taski/src/features/list_task/bloc/get_quantity_tasks/get_quantity_tasks_bloc.dart';
import 'package:taski/src/features/list_task/bloc/list_tasks_uncompleted/list_task_bloc.dart';
import 'package:taski/src/features/list_task/view/list_task_view.dart';

class ListTaskPage extends StatelessWidget {
  const ListTaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ListTaskUncompletedBloc>(
          create: (_) => GetIt.I.get<ListTaskUncompletedBloc>(),
        ),
        BlocProvider<GetQuantityTaskUncompletedBloc>(
          create: (_) => GetIt.I.get<GetQuantityTaskUncompletedBloc>(),
        ),
      ],
      child: const ListTaskView(),
    );
  }
}
