import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:taski/src/core/enums/state_enum.dart';
import 'package:taski/src/core/models/task_model.dart';
import 'package:taski/src/core/widgets/header_page.dart';
import 'package:taski/src/core/widgets/state_pages/empty_list_task_widget.dart';
import 'package:taski/src/core/widgets/state_pages/loading_list_task_widget.dart';
import 'package:taski/src/core/widgets/task_item_widget.dart';
import 'package:taski/src/features/list_task/bloc/get_quantity_tasks/get_quantity_tasks_bloc.dart';
import 'package:taski/src/features/list_task/bloc/get_quantity_tasks/get_quantity_tasks_event.dart';
import 'package:taski/src/features/list_task/bloc/get_quantity_tasks/get_quantity_tasks_state.dart';
import 'package:taski/src/features/list_task/bloc/list_tasks_uncompleted/list_task_bloc.dart';
import 'package:taski/src/features/list_task/bloc/list_tasks_uncompleted/list_task_event.dart';
import 'package:taski/src/features/list_task/bloc/list_tasks_uncompleted/list_task_state.dart';

class ListTaskView extends StatefulWidget {
  const ListTaskView({super.key});

  @override
  State<ListTaskView> createState() => _ListTaskViewState();
}

class _ListTaskViewState extends State<ListTaskView> {
  static const _pageSize = 10;
  late final ListTaskUncompletedBloc _tasksUncompletedBloc;
  late GetQuantityTaskUncompletedBloc _quantityTasksBloc;
  late final PagingController<int, TaskModel> _pagingController;

  bool _isFirstFetch = true;

  @override
  void initState() {
    super.initState();

    _quantityTasksBloc = GetIt.I.get<GetQuantityTaskUncompletedBloc>();
    _tasksUncompletedBloc = GetIt.I.get<ListTaskUncompletedBloc>();
    _pagingController = PagingController(firstPageKey: 0);

    _pagingController.refresh();
    _pagingController.addPageRequestListener((pageKey) {
      if (_isFirstFetch || pageKey > 0) {
        _fetchTasks(pageKey);
        _isFirstFetch = false;
      }
    });
    _quantityTasksBloc.add(GetQuantityUncompletedTasks());
  }

  void _fetchTasks(int pageKey) {
    _tasksUncompletedBloc.add(
      GetPagedUncompletedTasksEvent(limit: _pageSize, offset: pageKey),
    );
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 26.0),
      child: BlocListener<ListTaskUncompletedBloc, StateListTask>(
        bloc: _tasksUncompletedBloc,
        listener: (context, state) {
          if (state.stateEnum == StateEnum.success) {
            final isLastPage = state.tasks!.length < _pageSize;
            final currentItems = _pagingController.itemList ?? [];
            final newItems = state.tasks!;

            if (isLastPage) {
              _pagingController.appendLastPage(newItems);
            } else {
              final nextPageKey = currentItems.length + newItems.length;
              _pagingController.appendPage(newItems, nextPageKey);
            }
          } else if (state.stateEnum == StateEnum.error) {
            _pagingController.error = 'Erro ao carregar tarefas';
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Erro ao carregar tarefas!')),
            );
          }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlocBuilder<GetQuantityTaskUncompletedBloc, GetQuantityTasksState>(
              bloc: _quantityTasksBloc,
              builder: (context, quantityState) {
                return HeaderPage(quantityTasks: quantityState.quantityOfTasks);
              },
            ),
            Flexible(
              child: PagedListView<int, TaskModel>(
                pagingController: _pagingController,
                builderDelegate: PagedChildBuilderDelegate<TaskModel>(
                  itemBuilder: (context, item, index) => TaskItemWidget(
                    onToggle: () {},
                    task: item,
                  ),
                  firstPageProgressIndicatorBuilder: (_) =>
                      const LoadingListTaskWidget(),
                  newPageProgressIndicatorBuilder: (_) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  noItemsFoundIndicatorBuilder: (_) =>
                      const EmptyListTaskWidget(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
