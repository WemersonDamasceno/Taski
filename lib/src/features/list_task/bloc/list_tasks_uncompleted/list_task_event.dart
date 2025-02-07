import 'package:equatable/equatable.dart';

abstract class ListTaskEvent extends Equatable {}

class GetPagedUncompletedTasksEvent extends ListTaskEvent {
  final int limit;
  final int offset;

  GetPagedUncompletedTasksEvent({required this.limit, required this.offset});

  @override
  List<Object?> get props => [limit, offset];
}
