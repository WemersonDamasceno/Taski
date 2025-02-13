import 'package:equatable/equatable.dart';
import 'package:taski/src/core/erros/failures.dart';

abstract class Usecase<Type, NoParams> {
  Future<(Type?, Failure?)> call(NoParams params);
}

abstract class UseCaseStream<Type, Params> {
  Stream<Type> call(Params params);
}

class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}
