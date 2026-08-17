import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Smoke test — Flutter test runner works', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: Text('Siam Portfolio'),
        ),
      ),
    );
    expect(find.text('Siam Portfolio'), findsOneWidget);
  });
}
