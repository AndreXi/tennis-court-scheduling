// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tennis_court_scheduling/schedules/schedules.dart';
import 'package:tennis_court_scheduling/weather/weather.dart';

import '../../helpers/helpers.dart';
import 'create_schedule_dialog_test.mocks.dart';

@GenerateMocks([SchedulesRepository, WeatherRepository])
void main() {
  late MockSchedulesRepository schedulesRepository;
  late MockWeatherRepository weatherRepositoryMock;

  group('CreateSchedule Dialog and Form', () {
    setUpAll(() async {
      schedulesRepository = MockSchedulesRepository();
      weatherRepositoryMock = MockWeatherRepository();
      GetIt.I.registerSingleton<SchedulesRepository>(schedulesRepository);
      GetIt.I.registerSingleton<WeatherRepository>(weatherRepositoryMock);

      when(
        schedulesRepository.checkAvailability(
          SchedulesConst.courtNames,
          any,
          SchedulesConst.maxDailySchedulesByCourt,
        ),
      ).thenAnswer(
        (_) async => List.filled(SchedulesConst.maxDailySchedulesByCourt, false)
          ..[0] = true,
      );

      when(weatherRepositoryMock.getData(any)).thenAnswer(
        (_) async => WeatherModel(
          date: DateTime.now(),
          precipitationProbabilityDay: 23,
          precipitationProbabilityNight: 0,
        ),
      );
    });

    testWidgets('renders the widget', (tester) async {
      await tester.pumpApp(
        const SizedBox(
          width: 420,
          height: 840,
          child: Scaffold(
            body: CreateScheduleDialog(),
          ),
        ),
      );

      expect(find.byType(CreateScheduleDialog), findsOneWidget);
    });

    testWidgets('input the data and send the form', (tester) async {
      await tester.pumpApp(
        const SizedBox(
          width: 420,
          height: 840,
          child: Scaffold(
            body: CreateScheduleDialog(),
          ),
        ),
      );

      // Input the name
      expect(find.byType(NameField), findsOneWidget);
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Name'),
        'Andres',
      );
      expect(find.text('Andres'), findsOneWidget);

      // Select the court
      expect(find.byType(CourtField), findsOneWidget);
      await tester.tap(find.text(SchedulesConst.courtNames[0]));
      await tester.pumpAndSettle();

      // Send the form
      await tester.tap(find.text('Confirm'));
    });

    testWidgets('press confirm button with name empty', (tester) async {
      await tester.pumpApp(
        const SizedBox(
          width: 420,
          height: 840,
          child: Scaffold(
            body: CreateScheduleDialog(),
          ),
        ),
      );

      // Send the form
      await tester.tap(find.text('Confirm'));
      await tester.pumpAndSettle();

      expect(find.text('The name is required.'), findsOneWidget);
    });

    testWidgets('press cancel', (tester) async {
      await tester.pumpApp(
        const SizedBox(
          width: 420,
          height: 840,
          child: Scaffold(
            body: CreateScheduleDialog(),
          ),
        ),
      );

      // Send the form
      await tester.tap(find.text('Cancel'));
      await tester.pumpAndSettle();
    });
  });
}
