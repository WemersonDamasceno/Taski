import 'package:get_it/get_it.dart';
import 'package:taski/src/core/widgets/button/bloc/button_cubit.dart';
import 'package:taski/src/data/repository/list_task_repository_impl.dart';
import 'package:taski/src/data/services/local_datastorage.dart';
import 'package:taski/src/domain/repository/list_task_repository.dart';
import 'package:taski/src/domain/usecase/create_task_usecase.dart';
import 'package:taski/src/domain/usecase/delete_all_tasks_done_usecase.dart';
import 'package:taski/src/domain/usecase/delete_task_by_id_usecase.dart';
import 'package:taski/src/domain/usecase/get_all_tasks_usecase.dart';
import 'package:taski/src/domain/usecase/get_done_task_usecase.dart';
import 'package:taski/src/domain/usecase/get_uncompleted_tasks_usecase.dart';
import 'package:taski/src/domain/usecase/search_task_by_title_usecase.dart';
import 'package:taski/src/features/create_task/bloc/create_task_bloc.dart';
import 'package:taski/src/features/done_tasks/bloc/list_done_task_bloc.dart';
import 'package:taski/src/features/list_task/bloc/list_task_bloc.dart';
import 'package:taski/src/features/search_task/bloc/search_task_bloc.dart';

final GetIt getIt = GetIt.instance;

Future<void> initDependency() async {
  //****** Services ******//
  getIt.registerLazySingleton<LocalDatabaseService>(
    () => LocalDatabaseServiceImpl(),
  );

  //****** Repository ******//
  getIt.registerLazySingleton<TaskRepository>(() => TaskRepositoryImpl(
        databaseService: getIt(),
      ));

  //****** Usecases ******//
  getIt.registerLazySingleton<FetchTasksUseCase>(
    () => FetchTasksUseCase(repository: getIt()),
  );
  getIt.registerLazySingleton<GetDoneTaskUsecase>(
    () => GetDoneTaskUsecase(repository: getIt()),
  );
  getIt.registerLazySingleton<GetAllTasksUsecase>(() => GetAllTasksUsecase());
  getIt.registerLazySingleton<CreateTaskUsecase>(() => CreateTaskUsecase());
  getIt.registerLazySingleton<DeleteTasksByIdUsecase>(
    () => DeleteTasksByIdUsecase(),
  );
  getIt.registerLazySingleton<DeleteAllTasksDoneUsecase>(
    () => DeleteAllTasksDoneUsecase(),
  );
  getIt.registerLazySingleton<SearchTasksByTitleUseCase>(
    () => SearchTasksByTitleUseCase(),
  );

  //****** Blocs ******//
  getIt.registerFactory<ButtonCubit>(() => ButtonCubit());
  getIt.registerFactory<ListTaskBloc>(
    () => ListTaskBloc(fetchTasksUseCase: getIt()),
  );
  getIt.registerFactory<ListDoneTaskBloc>(
    () => ListDoneTaskBloc(
      getDoneTasksUseCase: getIt(),
      deleteAllTasksDoneUseCase: getIt(),
      deleteTasksByIdUsecase: getIt(),
    ),
  );
  getIt.registerFactory<CreateTaskBloc>(
    () => CreateTaskBloc(createTaskUsecase: getIt()),
  );
  getIt.registerFactory<SearchTaskBloc>(
    () => SearchTaskBloc(
      fetchTasksUseCase: getIt(),
      searchTasksByTitleUseCase: getIt(),
    ),
  );
}
