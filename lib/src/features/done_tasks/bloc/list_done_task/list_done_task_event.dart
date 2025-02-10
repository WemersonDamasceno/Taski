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
  DeleteTasksById({required this.id});
  final int id;
  @override
  List<Object?> get props => [id];
}
