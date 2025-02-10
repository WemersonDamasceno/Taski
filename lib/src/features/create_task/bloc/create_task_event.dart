import 'package:equatable/equatable.dart';

abstract class CreateTaskEvent extends Equatable {}

class CreateTask extends CreateTaskEvent {
  CreateTask({
    required this.task,
    required this.note,
  });
  final String task;
  final String note;

  @override
  List<Object?> get props => [task, note];
}
