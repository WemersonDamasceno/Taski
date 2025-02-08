import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:taski/src/core/constants/app_strings.dart';
import 'package:taski/src/core/widgets/button/view/app_buttom_widget.dart';
import 'package:taski/src/core/widgets/state_pages/error_list_task_widget.dart';

void main() {
  testWidgets('ErrorListTaskWidget displays error message and button',
      (tester) async {
    // Arrange
    bool buttonPressed = false;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ErrorListTaskWidget(
            onPressed: () {
              buttonPressed = true;
            },
          ),
        ),
      ),
    );

    // Assert
    expect(find.text(AppStrings.errorTitle), findsOneWidget);
    expect(find.text(AppStrings.errorDescription), findsOneWidget);
    expect(find.byType(AppButtonWidget), findsOneWidget);
    expect(find.byIcon(Icons.refresh), findsOneWidget);

    // Act
    await tester.tap(find.byType(AppButtonWidget));
    await tester.pump();

    // Assert
    expect(buttonPressed, true);
  });
}
