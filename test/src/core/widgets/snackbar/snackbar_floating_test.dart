import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:taski/src/core/widgets/snackbar/snackbar_floating.dart';

void main() {
  testWidgets('SnackbarFloating should display correctly with label and icon',
      (tester) async {
    // Arrange
    const label = 'Snackbar Message';
    const icon = Icons.info;
    const backgroundColor = Colors.blue;
    const fontColor = Colors.white;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) => ElevatedButton(
              onPressed: () {
                SnackbarFloating(
                  context: context,
                  labelSnackbar: label,
                  snackbarBackgroundColor: backgroundColor,
                  snackbarFontColor: fontColor,
                  margin: EdgeInsets.zero,
                  iconData: icon,
                ).show();
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
    expect(find.byType(SnackBar), findsOneWidget);
  });

  testWidgets('SnackbarFloating should display the correct text color',
      (tester) async {
    // Arrange
    const label = 'Snackbar Message';
    const icon = Icons.info;
    const backgroundColor = Colors.green;
    const fontColor = Colors.black;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) => ElevatedButton(
              onPressed: () {
                SnackbarFloating(
                  context: context,
                  labelSnackbar: label,
                  snackbarBackgroundColor: backgroundColor,
                  snackbarFontColor: fontColor,
                  margin: EdgeInsets.zero,
                  iconData: icon,
                ).show();
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
    final text = tester.widget<Text>(find.text(label));
    expect(text.style?.color, fontColor);
  });

  testWidgets(
      'SnackbarFloating should hide the previous snackbar before showing new one',
      (tester) async {
    // Arrange
    const label1 = 'First Snackbar';
    const label2 = 'Second Snackbar';
    const icon = Icons.info;
    const backgroundColor = Colors.red;
    const fontColor = Colors.white;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) => ElevatedButton(
              onPressed: () {
                SnackbarFloating(
                  context: context,
                  labelSnackbar: label1,
                  snackbarBackgroundColor: backgroundColor,
                  snackbarFontColor: fontColor,
                  margin: EdgeInsets.zero,
                  iconData: icon,
                ).show();
                Future.delayed(const Duration(seconds: 1), () {
                  SnackbarFloating(
                    context: context,
                    labelSnackbar: label2,
                    snackbarBackgroundColor: backgroundColor,
                    snackbarFontColor: fontColor,
                    margin: EdgeInsets.zero,
                    iconData: icon,
                  ).show();
                });
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
    expect(find.text(label1), findsOneWidget);

    await tester.pumpAndSettle(const Duration(seconds: 1));
    expect(find.text(label2), findsOneWidget);
    expect(find.text(label1), findsNothing); // First snackbar should be hidden
  });
}
