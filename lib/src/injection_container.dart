import 'package:get_it/get_it.dart';
import 'package:taski/src/core/widgets/button/bloc/button_cubit.dart';
import 'package:taski/src/create_task/domain/usecase/create_task_usecase.dart';
import 'package:taski/src/create_task/presentation/bloc/create_task_bloc.dart';
import 'package:taski/src/list_task/domain/usecase/get_uncompleted_tasks_usecase.dart';
import 'package:taski/src/list_task/presentation/bloc/list_task_bloc.dart';

final GetIt getIt = GetIt.instance;

Future<void> initDependency() async {
  //****** Usecases ******//
  getIt.registerLazySingleton<FetchTasksUseCase>(() => FetchTasksUseCase());
  getIt.registerLazySingleton<CreateTaskUsecase>(() => CreateTaskUsecase());

  //****** List Task ******//
  getIt.registerFactory<ListTaskBloc>(
    () => ListTaskBloc(fetchTasksUseCase: getIt()),
  );
  getIt.registerFactory<CreateTaskBloc>(
    () => CreateTaskBloc(createTaskUsecase: getIt()),
  );
  getIt.registerFactory<ButtonCubit>(() => ButtonCubit());
}
