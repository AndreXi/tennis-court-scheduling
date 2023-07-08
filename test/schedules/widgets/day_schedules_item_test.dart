import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tennis_court_scheduling/schedules/schedules.dart';
import 'package:tennis_court_scheduling/weather/weather.dart';

import '../../helpers/helpers.dart';
import '../cubit/schedules_cubit_test.mocks.dart';

@GenerateMocks([WeatherRepository, SchedulesRepository])
void main() {
  group('DaySchedulesItem', () {
    late SchedulesCubit schedulesCubit;
    late MockWeatherRepository weatherRepository;
    late MockSchedulesRepository schedulesRepository;

    final testData = {
      '2023-09-23': {
        SchedulesConst.courtNames[1]: ['Andres Pereira'],
      },
      '2023-07-07': {
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
      '2023-07-09': {
        SchedulesConst.courtNames[2]: ['Sonia Perez']
      }
    };
    const testDateKey = '2023-07-07';

    setUp(() async {
      weatherRepository = MockWeatherRepository();
      schedulesRepository = MockSchedulesRepository();
      schedulesCubit = SchedulesCubit(
        weatherRepository: weatherRepository,
        schedulesRepository: schedulesRepository,
      );
      when(schedulesRepository.getAll()).thenAnswer((_) async => testData);
      when(weatherRepository.getData(any)).thenAnswer(
        (_) async => WeatherModel(
          date: DateTime.parse(testDateKey),
          precipitationProbabilityDay: 23,
          precipitationProbabilityNight: 0,
        ),
      );
      await schedulesCubit.fetchData();
    });

    testWidgets('renders the item', (tester) async {
      await tester.pumpApp(
        SizedBox(
          width: 420,
          height: 840,
          child: Scaffold(
            body: BlocProvider<SchedulesCubit>(
              create: (context) => schedulesCubit,
              child: DaySchedulesItem(
                courtSchedulingMap: testData[testDateKey]!,
                date: testDateKey,
              ),
            ),
          ),
        ),
      );
      expect(find.byType(DaySchedulesItem), findsWidgets);
      expect(find.byType(WeatherForecast), findsOneWidget);
      expect(find.text('23%'), findsOneWidget);

      verify(schedulesRepository.getAll()).called(1);
      verify(weatherRepository.getData(DateTime.parse(testDateKey))).called(1);
    });
  });
}
