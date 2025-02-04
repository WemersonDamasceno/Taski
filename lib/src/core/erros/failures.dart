import 'package:equatable/equatable.dart';

sealed class Failure extends Equatable {
  final String message;

  const Failure({required this.message});

  @override
  List<Object?> get props => [message];
}

class LocalStorageFailure extends Failure {
  const LocalStorageFailure({required super.message});
}

class GenericsFailure extends Failure {
  const GenericsFailure({required super.message});
}
