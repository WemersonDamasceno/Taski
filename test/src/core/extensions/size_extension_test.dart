import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:taski/src/core/extensions/size_extension.dart';

void main() {
  testWidgets('mediaQuerySize should return correct screen size',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (BuildContext context) {
            final size = context.mediaQuerySize;

            expect(size.width, 800);
            expect(size.height, 600);

            return Container();
          },
        ),
      ),
    );

    expect(find.byType(Container), findsOneWidget);
  });
}
