import 'package:get_it/get_it.dart';
import 'package:taski/src/list_task/domain/usecase/get_uncompleted_tasks_usecase.dart';
import 'package:taski/src/list_task/presentation/bloc/list_task_bloc.dart';

final GetIt getIt = GetIt.instance;

Future<void> initDependency() async {
  //****** Usecases ******//
  getIt.registerLazySingleton<FetchTasksUseCase>(() => FetchTasksUseCase());

  //****** List Task ******//
  getIt.registerFactory<ListTaskBloc>(
    () => ListTaskBloc(fetchTasksUseCase: getIt()),
  );
}
