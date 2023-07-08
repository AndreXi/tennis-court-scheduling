// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mockito/annotations.dart';
import 'package:tennis_court_scheduling/schedules/schedules.dart';
import 'package:tennis_court_scheduling/weather/weather.dart';

import '../../helpers/helpers.dart';
import 'date_picker_test.mocks.dart';

@GenerateMocks([WeatherRepository])
void main() {
  late CreateScheduleCubit createScheduleCubit;
  late SchedulesRepository schedulesRepository;
  late MockWeatherRepository weatherRepositoryMock;

  Hive.init('testBox');

  group('DatePicker', () {
    setUp(() async {
      schedulesRepository =
          SchedulesRepository(dataProvider: SchedulesDataProvider(hive: Hive));
      weatherRepositoryMock = MockWeatherRepository();
      createScheduleCubit = CreateScheduleCubit(
        schedulesRepository: schedulesRepository,
        weatherRepository: weatherRepositoryMock,
      );
    });

    testWidgets('renders the widget', (tester) async {
      await tester.pumpApp(
        SizedBox(
          width: 420,
          height: 840,
          child: Scaffold(
            body: BlocProvider<CreateScheduleCubit>(
              create: (context) => createScheduleCubit,
              child: const DatePicker(),
            ),
          ),
        ),
      );

      expect(find.byType(DatePicker), findsOneWidget);
    });

    testWidgets(
        'open the selector on Tap and select a new date 1 from next month',
        (tester) async {
      await tester.pumpApp(
        SizedBox(
          width: 420,
          height: 840,
          child: Scaffold(
            body: BlocProvider<CreateScheduleCubit>(
              create: (context) => createScheduleCubit,
              child: const DatePicker(),
            ),
          ),
        ),
      );

      final formField = find.byType(TextFormField);
      await tester.tap(formField);
      await tester.pumpAndSettle();
      expect(find.byType(DatePickerDialog), findsOneWidget);
      await tester.tap(find.byTooltip('Next month'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('1'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Confirm'));
    });
  });
}
