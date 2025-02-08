import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:taski/src/core/constants/app_strings.dart';
import 'package:taski/src/core/widgets/button/view/app_buttom_widget.dart';
import 'package:taski/src/core/widgets/state_pages/empty_list_task_widget.dart';

void main() {
  testWidgets('EmptyListTaskWidget shows button when showButton is true',
      (tester) async {
    // Arrange
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: EmptyListTaskWidget(showButton: true),
        ),
      ),
    );

    // Assert
    expect(find.text(AppStrings.emptyTitle), findsOneWidget);
    expect(find.byType(AppButtonWidget), findsOneWidget);
    expect(find.text(AppStrings.createTask), findsOneWidget);
    expect(find.byIcon(Icons.add), findsOneWidget);
  });

  testWidgets(
      'EmptyListTaskWidget does not show button when showButton is false',
      (tester) async {
    // Arrange
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: EmptyListTaskWidget(showButton: false),
        ),
      ),
    );

    // Assert
    expect(find.text(AppStrings.emptyTitle), findsOneWidget);
    expect(find.byType(AppButtonWidget), findsNothing);
  });
}
