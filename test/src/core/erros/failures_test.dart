import 'package:flutter_test/flutter_test.dart';
import 'package:taski/src/core/erros/failures.dart';

void main() {
  test('LocalStorageFailure should be equal when instantiated', () {
    final failure1 = LocalStorageFailure();
    final failure2 = LocalStorageFailure();

    expect(failure1, equals(failure2));
  });

  test('GenericsFailure should be equal when instantiated', () {
    final failure1 = GenericsFailure();
    final failure2 = GenericsFailure();

    expect(failure1, equals(failure2));
  });

  test('LocalStorageFailure and GenericsFailure should not be equal', () {
    final failure1 = LocalStorageFailure();
    final failure2 = GenericsFailure();

    expect(failure1, isNot(equals(failure2)));
  });

  test('Failure subclasses should have the correct props', () {
    final failure = LocalStorageFailure();
    expect(failure.props, isEmpty);
  });
}
