import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:taski/src/features/search_task/bloc/search_task_bloc.dart';
import 'package:taski/src/features/search_task/views/search_task_view.dart';

class SearchTaskPage extends StatelessWidget {
  const SearchTaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => GetIt.I.get<SearchTaskBloc>()),
      ],
      child: const SearchTaskByTitleView(),
    );
  }
}
