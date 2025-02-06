import 'package:equatable/equatable.dart';
import 'package:taski/src/core/enums/state_enum.dart';

class GetQuantityTasksState extends Equatable {
  final int quantityOfTasks;
  final StateEnum stateEnum;

  const GetQuantityTasksState({
    this.stateEnum = StateEnum.initial,
    this.quantityOfTasks = 0,
  });

  GetQuantityTasksState copyWith({
    StateEnum? stateEnum,
    int? quantityOfTasks,
  }) {
    return GetQuantityTasksState(
      stateEnum: stateEnum ?? this.stateEnum,
      quantityOfTasks: quantityOfTasks ?? this.quantityOfTasks,
    );
  }

  @override
  List<Object?> get props => [quantityOfTasks, stateEnum];
}
