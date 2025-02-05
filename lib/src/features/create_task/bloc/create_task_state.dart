import 'package:equatable/equatable.dart';
import 'package:taski/src/core/enums/state_enum.dart';

class CreateTaskState extends Equatable {
  final StateEnum stateEnum;

  const CreateTaskState({this.stateEnum = StateEnum.initial});

  @override
  List<Object> get props => [stateEnum];

  CreateTaskState copyWith({
    StateEnum? stateEnum,
  }) {
    return CreateTaskState(
      stateEnum: stateEnum ?? this.stateEnum,
    );
  }
}
