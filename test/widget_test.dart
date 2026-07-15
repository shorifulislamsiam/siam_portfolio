import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:siam_portfolio/app/app/siam_portfolio_app.dart';

void main() {
  testWidgets('App starts without crashing', (WidgetTester tester) async {
    await tester.pumpWidget(const SiamPortfolioApp());
    expect(find.byType(MaterialApp), findsNothing); // GetMaterialApp is used
  });
}
