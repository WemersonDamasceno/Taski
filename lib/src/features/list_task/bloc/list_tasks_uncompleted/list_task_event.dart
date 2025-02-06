import 'package:equatable/equatable.dart';

abstract class ListTaskEvent extends Equatable {}

class GetUncompletedTasksEvent extends ListTaskEvent {
  @override
  List<Object?> get props => [];
}
