import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:taski/src/core/enums/state_enum.dart';
import 'package:taski/src/core/mixins/task_listener_mixin.dart';
import 'package:taski/src/core/models/task_event.dart';
import 'package:taski/src/core/widgets/state_pages/empty_list_task_widget.dart';
import 'package:taski/src/core/widgets/state_pages/error_list_task_widget.dart';
import 'package:taski/src/core/widgets/state_pages/loading_list_task_widget.dart';
import 'package:taski/src/core/widgets/state_pages/success_list_task_widget.dart';
import 'package:taski/src/features/search_task/bloc/search_task_bloc.dart';
import 'package:taski/src/features/search_task/bloc/search_task_event.dart';
import 'package:taski/src/features/search_task/bloc/search_task_state.dart';
import 'package:taski/src/features/search_task/widgets/not_found_list_task_widget.dart';
import 'package:taski/src/features/search_task/widgets/search_input_widget.dart'; // Importando o SearchInputWidget

class SearchTaskByTitleView extends StatefulWidget {
  const SearchTaskByTitleView({super.key});

  @override
  State<SearchTaskByTitleView> createState() => _SearchTaskByTitleViewState();
}

class _SearchTaskByTitleViewState extends State<SearchTaskByTitleView>
    with TaskListenerMixin {
  late SearchTaskBloc _searchTaskBloc;
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _searchTaskBloc = GetIt.I.get<SearchTaskBloc>();
    _searchTaskBloc.add(CleanInputEvent());
  }

  @override
  void onTaskModified(TaskEvent event) {
    if (event.operation == TaskOperation.createOrUpdate ||
        event.operation == TaskOperation.delete) {
      _searchTaskBloc.add(CleanInputEvent());
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchTaskBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SearchInputWidget(
          controller: _searchController,
          onClear: () async => await _onClearInput(),
          onChanged: (value) => _onChanged(value),
        ),
        Flexible(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 26.0),
            child: BlocBuilder<SearchTaskBloc, SearchTasksState>(
              bloc: _searchTaskBloc,
              builder: (context, state) {
                switch (state.stateEnum) {
                  case StateEnum.success:
                    return SuccessListTaskWidget(tasks: state.tasks);
                  case StateEnum.error:
                    return ErrorListTaskWidget(
                      onPressed: () => _searchTaskBloc.add(CleanInputEvent()),
                    );
                  case StateEnum.empty:
                    return const EmptyListTaskWidget(
                      showButton: false,
                    );
                  case StateEnum.notFound:
                    return const NotFoundTasksWidget();
                  default:
                    return const LoadingListTaskWidget();
                }
              },
            ),
          ),
        )
      ],
    );
  }

  Future<void> _onClearInput() async {
    _searchController.clear();
    await Future.delayed(const Duration(milliseconds: 300));
    _searchTaskBloc.add(CleanInputEvent());
  }

  void _onChanged(String value) {
    if (value.isNotEmpty) {
      _searchTaskBloc.add(SearchTaskByTitleEvent(value));
    } else {
      _searchTaskBloc.add(CleanInputEvent());
    }
  }
}
