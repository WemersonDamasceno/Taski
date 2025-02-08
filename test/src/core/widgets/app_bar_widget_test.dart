import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:taski/src/core/widgets/app_bar_widget.dart';

void main() {
  testWidgets('AppBarWidget deve exibir logo, nome e avatar',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(56.0),
            child: AppBarWidget(),
          ),
        ),
      ),
    );

    expect(find.text('John'), findsOneWidget);
    expect(find.byType(Image), findsOneWidget);
  });
}
