import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:taski/src/core/widgets/loading_item_widget.dart';
import 'package:taski/src/core/widgets/state_pages/loading_list_task_widget.dart';

void main() {
  testWidgets('LoadingListTaskWidget displays loading items', (tester) async {
    // Arrange
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: LoadingListTaskWidget(),
        ),
      ),
    );

    // Assert
    expect(find.byType(LoadingItemWidget), findsNWidgets(3));
  });
}
