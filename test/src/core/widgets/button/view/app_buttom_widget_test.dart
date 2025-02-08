import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:taski/src/core/enums/status_button_enum.dart';
import 'package:taski/src/core/widgets/button/view/app_buttom_widget.dart';

void main() {
  testWidgets(
      'AppButtonWidget should display label and be tappable when enabled',
      (tester) async {
    bool buttonPressed = false;
    const label = 'Press Me';

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: AppButtonWidget.filled(
            label: label,
            onPressed: () {
              buttonPressed = true;
            },
          ),
        ),
      ),
    );

    // Assert the button label is shown
    expect(find.text(label), findsOneWidget);

    // Act
    await tester.tap(find.byType(AppButtonWidget));
    await tester.pump();

    // Assert the button was pressed
    expect(buttonPressed, true);
  });

  testWidgets(
      'AppButtonWidget should display a loading indicator when status is loading',
      (tester) async {
    // Arrange
    const label = 'Loading';
    bool buttonPressed = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: AppButtonWidget.filled(
            label: label,
            statusButton: StatusButtonEnum.loading,
            onPressed: () {
              buttonPressed = true;
            },
          ),
        ),
      ),
    );

    // Assert that the loading indicator is visible and label is hidden
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.text(label), findsNothing);

    // Act
    await tester.tap(find.byType(AppButtonWidget));
    await tester.pump();

    // Assert the button was not pressed since it's in loading state
    expect(buttonPressed, false);
  });

  testWidgets('AppButtonWidget should be disabled when status is disable',
      (tester) async {
    // Arrange
    bool buttonPressed = false;
    const label = 'Disabled';

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: AppButtonWidget.filled(
            label: label,
            statusButton: StatusButtonEnum.disable,
            onPressed: () {
              buttonPressed = true;
            },
          ),
        ),
      ),
    );

    // Assert the button label is shown
    expect(find.text(label), findsOneWidget);

    // Act
    await tester.tap(find.byType(AppButtonWidget));
    await tester.pump();

    // Assert the button was not pressed since it's disabled
    expect(buttonPressed, false);
  });
}
