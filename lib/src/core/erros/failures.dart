import 'package:equatable/equatable.dart';

sealed class Failure extends Equatable {
  @override
  List<Object?> get props => [];
}

class LocalStorageFailure extends Failure {}

class GenericsFailure extends Failure {}
