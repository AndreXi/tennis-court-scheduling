import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tennis_court_scheduling/app/app.dart';

void main() {
  group('App', () {
    testWidgets('renders MaterialApp', (tester) async {
      await tester.pumpWidget(App());
      expect(find.byType(MaterialApp), findsOneWidget);
    });
  });
}
