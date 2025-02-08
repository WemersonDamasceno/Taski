import 'package:get_it/get_it.dart';
import 'package:taski/src/core/bloc/update_task_bloc.dart';
import 'package:taski/src/core/widgets/button/bloc/button_cubit.dart';
import 'package:taski/src/data/repository/task_repository_impl.dart';
import 'package:taski/src/data/services/database_provider.dart';
import 'package:taski/src/data/services/local_datastorage.dart';
import 'package:taski/src/domain/repository/list_task_repository.dart';
import 'package:taski/src/domain/usecase/create_task_usecase.dart';
import 'package:taski/src/domain/usecase/delete_all_tasks_done_usecase.dart';
import 'package:taski/src/domain/usecase/delete_task_by_id_usecase.dart';
import 'package:taski/src/domain/usecase/get_all_tasks_usecase.dart';
import 'package:taski/src/domain/usecase/get_done_task_usecase.dart';
import 'package:taski/src/domain/usecase/get_quantity_uncompleted_tasks_usecase.dart';
import 'package:taski/src/domain/usecase/get_uncompleted_tasks_usecase.dart';
import 'package:taski/src/domain/usecase/search_task_by_title_usecase.dart';
import 'package:taski/src/domain/usecase/update_task_usecase.dart';
import 'package:taski/src/features/create_task/bloc/create_task_bloc.dart';
import 'package:taski/src/features/done_tasks/bloc/enable_buton/enable_button_cubit.dart';
import 'package:taski/src/features/done_tasks/bloc/list_done_task/list_done_task_bloc.dart';
import 'package:taski/src/features/list_task/bloc/get_quantity_tasks/get_quantity_tasks_bloc.dart';
import 'package:taski/src/features/list_task/bloc/list_tasks_uncompleted/list_task_bloc.dart';
import 'package:taski/src/features/search_task/bloc/search_task_bloc.dart';

final GetIt getIt = GetIt.instance;

Future<void> initDependency() async {
  //****** Database Provider ******//
  getIt.registerLazySingleton<DatabaseProvider>(
    () => DatabaseProviderImpl(),
  );

  //****** Services ******//
  getIt.registerLazySingleton<LocalDatabaseService>(
    () => LocalDatabaseServiceImpl(
      databaseProvider: getIt(),
    ),
  );

  //****** Repository ******//
  getIt.registerLazySingleton<TaskRepository>(() => TaskRepositoryImpl(
        databaseService: getIt(),
      ));

  //****** Usecases ******//
  getIt.registerLazySingleton<GetUncompletedTasksUsecase>(
    () => GetUncompletedTasksUsecase(repository: getIt()),
  );
  getIt.registerLazySingleton<GetDoneTaskUsecase>(
    () => GetDoneTaskUsecase(repository: getIt()),
  );
  getIt.registerLazySingleton<CreateTaskUsecase>(
    () => CreateTaskUsecase(repository: getIt()),
  );
  getIt.registerLazySingleton<UpdateTaskUsecase>(
    () => UpdateTaskUsecase(repository: getIt()),
  );
  getIt.registerLazySingleton<GetAllTasksUsecase>(
    () => GetAllTasksUsecase(repository: getIt()),
  );
  getIt.registerLazySingleton<DeleteTasksByIdUsecase>(
    () => DeleteTasksByIdUsecase(
      repository: getIt(),
    ),
  );
  getIt.registerLazySingleton<DeleteAllTasksDoneUsecase>(
    () => DeleteAllTasksDoneUsecase(
      repository: getIt(),
    ),
  );
  getIt.registerLazySingleton<SearchTasksByTitleUseCase>(
    () => SearchTasksByTitleUseCase(repository: getIt()),
  );

  getIt.registerLazySingleton<GetQuantityUncompltedTaskUsecase>(
    () => GetQuantityUncompltedTaskUsecase(repository: getIt()),
  );

  //****** Blocs ******//
  getIt.registerFactory<ButtonCubit>(() => ButtonCubit());
  getIt.registerFactory<ListTaskUncompletedBloc>(
    () => ListTaskUncompletedBloc(usecase: getIt()),
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

  getIt.registerFactory<UpdateTaskBloc>(
    () => UpdateTaskBloc(updateTaskUsecase: getIt()),
  );
  getIt.registerFactory<GetQuantityTaskUncompletedBloc>(
    () => GetQuantityTaskUncompletedBloc(usecase: getIt()),
  );
  getIt.registerFactory<EnableDeleteButtonCubit>(
    () => EnableDeleteButtonCubit(),
  );
  getIt.registerFactory<SearchTaskBloc>(
    () => SearchTaskBloc(
      getAllTasksUsecase: getIt(),
      searchTasksByTitleUseCase: getIt(),
    ),
  );
}
