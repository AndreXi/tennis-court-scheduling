// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tennis_court_scheduling/schedules/schedules.dart';

import '../../helpers/helpers.dart';

void main() {
  group('NameConfirmDeleteDialog', () {
    final testInfo = ReservationInfo(
      userName: 'Andres Pereira',
      courtName: SchedulesConst.courtNames[1],
      date: '2023-09-23',
    );

    testWidgets('renders the widget and find the user name in it',
        (tester) async {
      await tester.pumpApp(
        SizedBox(
          width: 420,
          height: 840,
          child: Scaffold(
            body: NameConfirmDeleteDialog(info: testInfo),
          ),
        ),
      );

      expect(find.byType(NameConfirmDeleteDialog), findsOneWidget);
      expect(find.textContaining(testInfo.userName), findsOneWidget);
    });

    testWidgets('confirmed dialog returns true', (tester) async {
      var dialogResult = false;
      await tester.pumpApp(
        SizedBox(
          width: 420,
          height: 840,
          child: Scaffold(
            body: Builder(
              builder: (context) {
                return ElevatedButton(
                  child: const Text('Show Dialog Test'),
                  onPressed: () async {
                    final result = await showDialog<bool>(
                      context: context,
                      builder: (context) {
                        return NameConfirmDeleteDialog(info: testInfo);
                      },
                    );
                    dialogResult = result ?? false;
                  },
                );
              },
            ),
          ),
        ),
      );

      // Open the dialog and tap the button
      await tester.tap(find.text('Show Dialog Test'));
      await tester.pump();
      await tester.tap(find.text('Confirm'));
      expect(dialogResult, equals(true));
      await tester.pump();
    });

    testWidgets('confirmed dialog returns false', (tester) async {
      var dialogResult = false;
      await tester.pumpApp(
        SizedBox(
          width: 420,
          height: 840,
          child: Scaffold(
            body: Builder(
              builder: (context) {
                return ElevatedButton(
                  child: const Text('Show Dialog Test'),
                  onPressed: () async {
                    final result = await showDialog<bool>(
                      context: context,
                      builder: (context) {
                        return NameConfirmDeleteDialog(info: testInfo);
                      },
                    );
                    dialogResult = result ?? false;
                  },
                );
              },
            ),
          ),
        ),
      );

      // Open the dialog and tap the button
      await tester.tap(find.text('Show Dialog Test'));
      await tester.pump();
      await tester.tap(find.text('Cancel'));
      expect(dialogResult, equals(false));
      await tester.pump();
    });
  });
}
