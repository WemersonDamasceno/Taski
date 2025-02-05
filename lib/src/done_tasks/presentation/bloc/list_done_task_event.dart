import 'package:equatable/equatable.dart';

abstract class ListDoneTaskEvent extends Equatable {}

class GetCompletedTasksEvent extends ListDoneTaskEvent {
  @override
  List<Object?> get props => [];
}

class DeleteAllTasksDone extends ListDoneTaskEvent {
  @override
  List<Object?> get props => [];
}

class DeleteTasksById extends ListDoneTaskEvent {
  final int id;

  DeleteTasksById({required this.id});
  @override
  List<Object?> get props => [id];
}
