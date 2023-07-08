// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  late SchedulesCubit schedulesCubit;

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

    setUp(() {
      schedulesCubit = SchedulesCubit(
        schedulesRepository: schedulesRepository,
        weatherRepository: weatherRepositoryMock,
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
      await tester.pumpAndSettle();
    });

    testWidgets('shows empty list message', (tester) async {
      await tester.pumpApp(
        SizedBox(
          width: 420,
          height: 840,
          child: BlocProvider(
            create: (context) => schedulesCubit,
            child: const SchedulesView(),
          ),
        ),
      );

      await tester.pumpAndSettle();
      schedulesCubit.emit(
        const SchedulesEmpty(
          data: SchedulesData(schedules: {}, weatherForecasts: {}),
        ),
      );
      await tester.pumpAndSettle();

      // Find the column
      final columnFinder = find.byType(Column);
      expect(columnFinder, findsOneWidget);

      // Find the button
      final buttonFinder = find.descendant(
        of: columnFinder,
        matching: find.byIcon(Icons.add),
      );
      expect(buttonFinder, findsOneWidget);

      // Find the message
      expect(find.text('There are no schedules right now'), findsOneWidget);

      // Tap the button
      await tester.tap(buttonFinder);
      await tester.pumpAndSettle();

      expect(find.byType(CreateScheduleDialog), findsOneWidget);
    });

    testWidgets('shows a loading button when state is SchedulesFetching',
        (tester) async {
      await tester.pumpApp(
        SizedBox(
          width: 420,
          height: 840,
          child: Scaffold(
            body: BlocProvider(
              create: (context) => schedulesCubit,
              child: const SchedulesView(),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();
      schedulesCubit.emit(
        const SchedulesFetching(
          data: SchedulesData(schedules: {}, weatherForecasts: {}),
        ),
      );
      await tester.pump(
        const Duration(milliseconds: 1),
      ); // No and Settle or will be infinite

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
  });
}
