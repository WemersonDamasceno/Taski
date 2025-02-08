import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:taski/src/core/widgets/snackbar/snackbar_mixin.dart';

class MockSnackbarMixin with SnackbarMixin {}

void main() {
  testWidgets('SnackbarMixin should display snackbar correctly',
      (tester) async {
    // Arrange
    const label = 'Test Snackbar';
    const icon = Icons.info;
    const backgroundColor = Colors.green;
    const fontColor = Colors.white;
    final mockSnackbarMixin = MockSnackbarMixin();

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) => ElevatedButton(
              onPressed: () {
                mockSnackbarMixin.showSnackbar(
                  context: context,
                  message: label,
                  backgroundColor: backgroundColor,
                  fontColor: fontColor,
                  iconData: icon,
                );
              },
              child: const Text('Show Snackbar'),
            ),
          ),
        ),
      ),
    );

    // Act
    await tester.tap(find.text('Show Snackbar'));
    await tester.pumpAndSettle();

    // Assert
    expect(find.text(label), findsOneWidget);
    expect(find.byIcon(icon), findsOneWidget);
  });
}
