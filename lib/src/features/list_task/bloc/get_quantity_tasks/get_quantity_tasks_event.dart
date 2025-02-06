import 'package:equatable/equatable.dart';

abstract class GetQuantityTasksEvent extends Equatable {}

class GetQuantityUncompletedTasks extends GetQuantityTasksEvent {
  @override
  List<Object?> get props => [];
}
