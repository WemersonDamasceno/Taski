import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:taski/src/list_task/presentation/bloc/list_task_bloc.dart';
import 'package:taski/src/list_task/presentation/view/list_task_view.dart';

class ListTaskPage extends StatelessWidget {
  const ListTaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ListTaskBloc>(
          create: (_) => GetIt.I.get<ListTaskBloc>(),
        ),
      ],
      child: const ListTaskView(),
    );
  }
}
