// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tennis_court_scheduling/schedules/schedules.dart';
import 'package:tennis_court_scheduling/weather/weather.dart';

import '../../helpers/helpers.dart';
import 'schedules_page_test.mocks.dart';

@GenerateMocks([SchedulesRepository, WeatherRepository])
void main() {
  late MockSchedulesRepository schedulesRepository;
  late MockWeatherRepository weatherRepositoryMock;

  group('SchedulesPage', () {
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
            body: SchedulesPage(),
          ),
        ),
      );

      expect(find.byType(SchedulesPage), findsOneWidget);
    });

    testWidgets('tap the create schedule button', (tester) async {
      await tester.pumpApp(
        const SizedBox(
          width: 420,
          height: 840,
          child: Scaffold(
            body: SchedulesPage(),
          ),
        ),
      );

      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle();

      expect(find.byType(CreateScheduleDialog), findsOneWidget);
    });
  });
}
