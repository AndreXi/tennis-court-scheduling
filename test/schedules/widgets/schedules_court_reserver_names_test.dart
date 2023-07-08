// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tennis_court_scheduling/schedules/schedules.dart';

import '../../helpers/helpers.dart';
import 'schedules_court_reserver_names_test.mocks.dart';

@GenerateMocks([SchedulesCubit])
void main() {
  group('SchedulesCourtReserverNames', () {
    late MockSchedulesCubit schedulesCubit;

    final testData = {
      '2023-09-23': SchedulesModel(
        courts: {
          SchedulesConst.courtNames[1]: ['Andres Pereira'],
        },
      ),
      '2023-07-07': SchedulesModel(
        courts: {
          SchedulesConst.courtNames[2]: [
            'Maria Garcia',
            'Pedro Martinez',
            'Jose Torres',
          ],
          SchedulesConst.courtNames[0]: [
            'Daniela Pereira',
            'Tony Gutierrez',
          ]
        },
      ),
      '2023-07-09': SchedulesModel(
        courts: {
          SchedulesConst.courtNames[2]: ['Sonia Perez']
        },
      ),
    };

    final testInfo = ReservationInfo(
      userName: 'Andres Pereira',
      courtName: SchedulesConst.courtNames[1],
      date: '2023-09-23',
    );
    const testDateKey = '2023-09-23';

    setUp(() async {
      schedulesCubit = MockSchedulesCubit();
      when(schedulesCubit.deleteReservation(testInfo)).thenAnswer((_) async {});
      when(schedulesCubit.stream).thenAnswer((_) => const Stream.empty());
    });

    testWidgets('renders the widget', (tester) async {
      await tester.pumpApp(
        SizedBox(
          width: 420,
          height: 840,
          child: Scaffold(
            body: BlocProvider<SchedulesCubit>(
              create: (context) => schedulesCubit,
              child: SchedulesCourtReserverNames(
                date: testDateKey,
                courtName: SchedulesConst.courtNames[1],
                names: testData[testDateKey]!
                    .courts[SchedulesConst.courtNames[1]]!,
              ),
            ),
          ),
        ),
      );

      expect(find.byType(SchedulesCourtReserverNames), findsOneWidget);
      expect(find.text(testInfo.userName), findsOneWidget);
    });

    testWidgets('renders all names', (tester) async {
      const testDateKey = '2023-07-07';
      await tester.pumpApp(
        SizedBox(
          width: 420,
          height: 840,
          child: Scaffold(
            body: BlocProvider<SchedulesCubit>(
              create: (context) => schedulesCubit,
              child: SchedulesCourtReserverNames(
                date: testDateKey,
                courtName: SchedulesConst.courtNames[2],
                names: testData[testDateKey]!
                    .courts[SchedulesConst.courtNames[2]]!,
              ),
            ),
          ),
        ),
      );

      expect(find.byType(SchedulesCourtReserverNames), findsOneWidget);
      expect(find.text('Maria Garcia'), findsOneWidget);
      expect(find.text('Pedro Martinez'), findsOneWidget);
      expect(find.text('Jose Torres'), findsOneWidget);

      // verify(schedulesRepository.getAll()).called(1);
      // verify(weatherRepository.getData(DateTime.parse(testDateKey))).called(1);
    });

    testWidgets(
        'find and tap the delete button, confirm the dialog and verify delete was called',
        (tester) async {
      await tester.pumpApp(
        SizedBox(
          width: 420,
          height: 840,
          child: Scaffold(
            body: BlocProvider<SchedulesCubit>(
              create: (context) => schedulesCubit,
              child: SchedulesCourtReserverNames(
                date: testDateKey,
                courtName: SchedulesConst.courtNames[1],
                names: testData[testDateKey]!
                    .courts[SchedulesConst.courtNames[1]]!,
              ),
            ),
          ),
        ),
      );

      final button = find.byType(IconButton);
      expect(button, findsOneWidget);

      // Open the confirm dialog and tap confirm
      await tester.tap(button);
      await tester.pump();
      final confirmButton = find.text('Confirm');
      expect(confirmButton, findsOneWidget);
      await tester.tap(confirmButton);
    });
  });
}
