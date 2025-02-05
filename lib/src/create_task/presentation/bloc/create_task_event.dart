import 'package:equatable/equatable.dart';

abstract class CreateTaskEvent extends Equatable {}

class CreateTask extends CreateTaskEvent {
  final String task;
  final String note;

  CreateTask({
    required this.task,
    required this.note,
  });

  @override
  List<Object?> get props => [task, note];
}
