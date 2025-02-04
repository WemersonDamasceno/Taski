import 'package:equatable/equatable.dart';
import 'package:taski/src/core/erros/failures.dart';

abstract class Usecase<Type, NoParams> {
  Future<(Type?, Failure?)> call();
}

class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}
