import 'package:flutter_test/flutter_test.dart';
import 'package:taski/src/core/erros/exceptions.dart';

void main() {
  test('LocalStorageException should store the message correctly', () {
    const message = 'Local storage error';
    final exception = LocalStorageException(message);

    expect(exception.message, message);
  });

  test('GenericsException should store the message correctly', () {
    const message = 'Generic error';
    final exception = GenericsException(message);

    expect(exception.message, message);
  });
}
