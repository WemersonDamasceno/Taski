import 'package:equatable/equatable.dart';

abstract class SearchTaskEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class CleanInputEvent extends SearchTaskEvent {}

class SearchTaskByTitleEvent extends SearchTaskEvent {
  final String title;

  SearchTaskByTitleEvent(this.title);

  @override
  List<Object> get props => [title];
}
