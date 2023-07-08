// ignore_for_file: lines_longer_than_80_chars

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tennis_court_scheduling/schedules/data/models/schedules_model.dart';
import 'package:tennis_court_scheduling/schedules/schedules.dart';
import 'package:tennis_court_scheduling/weather/weather.dart';

import 'schedules_cubit_test.mocks.dart';

@GenerateMocks([SchedulesRepository, WeatherRepository])
void main() {
  group('SchedulesCubit', () {
    late MockSchedulesRepository schedulesRepository;
    late MockWeatherRepository weatherRepository;
    late SchedulesCubit cubit;

    final schedulesTestData = {
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

    // final schedulesTestData = {
    //   '2023-09-23': {
    //     SchedulesConst.courtNames[1]: ['Andres Pereira'],
    //   },
    //   '2023-07-07': {
    //     SchedulesConst.courtNames[2]: [
    //       'Maria Garcia',
    //       'Pedro Martinez',
    //       'Jose Torres',
    //     ],
    //     SchedulesConst.courtNames[0]: [
    //       'Daniela Pereira',
    //       'Tony Gutierrez',
    //     ]
    //   },
    //   '2023-07-09': {
    //     SchedulesConst.courtNames[2]: ['Sonia Perez']
    //   }
    // };

    final cubitStateTestNoWeather = SchedulesData(
      schedules: schedulesTestData,
      weatherForecasts: const {},
    );

    const reservationInfo = ReservationInfo(
      userName: 'John Doe',
      courtName: 'Court A',
      date: '2023-07-08',
    );

    setUp(() {
      schedulesRepository = MockSchedulesRepository();
      weatherRepository = MockWeatherRepository();
      cubit = SchedulesCubit(
        schedulesRepository: schedulesRepository,
        weatherRepository: weatherRepository,
      );
    });

    tearDown(() {
      cubit.close();
    });

    test('initial state is SchedulesFetch', () {
      expect(cubit.state, isA<SchedulesFetch>());
    });

    blocTest<SchedulesCubit, SchedulesState>(
      'fetchData emits SchedulesSuccess when getAll returns data',
      build: () {
        final schedulesData = cubitStateTestNoWeather;

        when(schedulesRepository.getAll())
            .thenAnswer((_) async => schedulesData.schedules);
        when(weatherRepository.getData(any)).thenAnswer(
          (_) async => WeatherModel(
            date: DateTime.now(),
            precipitationProbabilityDay: 0,
            precipitationProbabilityNight: 0,
          ),
        );

        return SchedulesCubit(
          schedulesRepository: schedulesRepository,
          weatherRepository: weatherRepository,
        );
      },
      act: (cubit) => cubit.fetchData(),
      expect: () => [
        isA<SchedulesFetching>(),
        isA<SchedulesSuccess>(),
      ],
    );

    blocTest<SchedulesCubit, SchedulesState>(
      'fetchData emits SchedulesEmpty when getAll returns empty',
      build: () {
        const schedulesData = SchedulesData(
          schedules: {},
          weatherForecasts: {},
        );

        when(schedulesRepository.getAll())
            .thenAnswer((_) async => schedulesData.schedules);

        return SchedulesCubit(
          schedulesRepository: schedulesRepository,
          weatherRepository: weatherRepository,
        );
      },
      act: (cubit) => cubit.fetchData(),
      expect: () => [
        isA<SchedulesFetching>(),
        isA<SchedulesEmpty>(),
      ],
    );

    blocTest<SchedulesCubit, SchedulesState>(
      'fetchData emits SchedulesError when getAll throws an error',
      build: () {
        when(schedulesRepository.getAll()).thenThrow(Exception('Error'));

        return SchedulesCubit(
          schedulesRepository: schedulesRepository,
          weatherRepository: weatherRepository,
        );
      },
      act: (cubit) => cubit.fetchData(),
      expect: () => [
        isA<SchedulesFetching>(),
        isA<SchedulesError>(),
      ],
    );

    blocTest<SchedulesCubit, SchedulesState>(
      'deleteReservation emits SchedulesFetch when removeReservation returns true',
      build: () {
        when(schedulesRepository.removeReservation(reservationInfo))
            .thenAnswer((_) async => true);

        return SchedulesCubit(
          schedulesRepository: schedulesRepository,
          weatherRepository: weatherRepository,
        );
      },
      act: (cubit) => cubit.deleteReservation(reservationInfo),
      expect: () => [
        isA<SchedulesFetch>(),
      ],
      verify: (_) {
        verify(schedulesRepository.removeReservation(any)).called(1);
      },
    );

    blocTest<SchedulesCubit, SchedulesState>(
      'deleteReservation emits SchedulesError when removeReservation returns false',
      build: () {
        when(schedulesRepository.removeReservation(reservationInfo))
            .thenAnswer((_) async => false);

        return SchedulesCubit(
          schedulesRepository: schedulesRepository,
          weatherRepository: weatherRepository,
        );
      },
      act: (cubit) => cubit.deleteReservation(reservationInfo),
      expect: () => [
        isA<SchedulesError>(),
      ],
      verify: (_) {
        verify(schedulesRepository.removeReservation(any)).called(1);
      },
    );
  });
}
