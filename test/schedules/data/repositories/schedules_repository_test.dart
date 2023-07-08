// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tennis_court_scheduling/schedules/schedules.dart';

import 'schedules_repository_test.mocks.dart';

@GenerateMocks([SchedulesDataProvider])
void main() {
  group('SchedulesRepository', () {
    late SchedulesRepository repository;
    late SchedulesDataProvider dataProvider;

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

    setUp(() {
      dataProvider = MockSchedulesDataProvider();
      repository = SchedulesRepository(dataProvider: dataProvider);
    });

    test('getAll() calls readAllData() of SchedulesDataProvider', () async {
      when(dataProvider.readAllData()).thenAnswer((_) async => testData);

      final result = await repository.getAll();

      expect(result, equals(testData));
      verify(dataProvider.readAllData()).called(1);
    });

    test(
        'removeReservation() removes the date key because there are no courts left',
        () async {
      const info = ReservationInfo(
        userName: 'John Doe',
        courtName: 'Court A',
        date: '2023-07-08',
      );
      final data = {
        'Court A': ['John Doe'],
      };

      when(dataProvider.readData(info.date)).thenAnswer((_) async => data);
      when(dataProvider.deleteData(info.date)).thenAnswer((_) async {});

      final result = await repository.removeReservation(info);

      expect(result, isTrue);
      verify(dataProvider.readData(info.date)).called(1);
      verify(dataProvider.deleteData(info.date)).called(1);
    });

    test('removeReservation() removes the target name only', () async {
      const info = ReservationInfo(
        userName: 'John Doe',
        courtName: 'Court A',
        date: '2023-07-08',
      );
      final data = {
        'Court A': ['John Doe', 'Foo Bar'],
        'Court B': ['Other Person'],
      };
      final newData = {
        'Court A': ['Foo Bar'],
        'Court B': ['Other Person'],
      };

      when(dataProvider.readData(info.date)).thenAnswer((_) async => data);
      when(dataProvider.writeData(info.date, newData)).thenAnswer((_) async {});

      final result = await repository.removeReservation(info);

      expect(result, isTrue);
      verify(dataProvider.readData(info.date)).called(1);
      verify(dataProvider.writeData(info.date, newData)).called(1);
    });

    test('checkAvailability() returns a bool list', () async {
      final courtNames = ['Court A', 'Court B'];
      final date = DateTime(2023, 7, 8);
      const stock = 2;
      final formattedDate = DateFormat('yyyy-MM-dd').format(date);
      final data = {
        'Court A': ['John Doe', 'Jane Smith'],
        'Court C': ['Bob Johnson'],
      };

      when(dataProvider.readData(formattedDate)).thenAnswer((_) async => data);

      final result =
          await repository.checkAvailability(courtNames, date, stock);

      expect(result, equals([false, true]));
      verify(dataProvider.readData(formattedDate)).called(1);
    });

    test('createSchedule() creates a schedule', () async {
      const info = ReservationInfo(
        userName: 'John Doe',
        courtName: 'Court A',
        date: '2023-07-08',
      );
      final data = {
        'Court A': ['John Doe'],
      };

      when(dataProvider.readData(info.date)).thenAnswer((_) async => data);
      when(dataProvider.writeData(info.date, data)).thenAnswer((_) async {});

      await repository.createSchedule(info);

      verify(dataProvider.readData(info.date)).called(1);
      verify(dataProvider.writeData(info.date, data)).called(1);
    });

    test('createSchedule() creates a schedule and create the court key',
        () async {
      const info = ReservationInfo(
        userName: 'John Doe',
        courtName: 'Court A',
        date: '2023-07-08',
      );
      final data = <String, List<String>>{};
      final newData = {
        'Court A': ['John Doe'],
      };

      when(dataProvider.readData(info.date)).thenAnswer((_) async => data);
      when(dataProvider.writeData(info.date, newData)).thenAnswer((_) async {});

      await repository.createSchedule(info);

      verify(dataProvider.readData(info.date)).called(1);
      verify(dataProvider.writeData(info.date, newData)).called(1);
    });

    test('removePastSchedules() removes old date keys from today', () async {
      final formatter = DateFormat('yyyy-MM-dd').format;
      final dateTimeNow = formatter(DateTime.now());
      final dateTimeYesterday =
          formatter(DateTime.now().subtract(const Duration(days: 1)));
      final dateTimeYesterday2 =
          formatter(DateTime.now().subtract(const Duration(days: 2)));

      final data = {
        dateTimeNow: <String, List<String>>{},
        dateTimeYesterday: <String, List<String>>{},
        dateTimeYesterday2: <String, List<String>>{},
      };

      when(dataProvider.readAllData()).thenAnswer((_) async => data);
      when(dataProvider.deleteKeys([dateTimeYesterday2, dateTimeYesterday]))
          .thenAnswer((_) async {});

      await repository.removePastSchedules();

      verify(dataProvider.readAllData()).called(1);
      verify(dataProvider.deleteKeys([dateTimeYesterday2, dateTimeYesterday]))
          .called(1);
    });
  });
}
