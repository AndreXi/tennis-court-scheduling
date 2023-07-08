import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tennis_court_scheduling/schedules/schedules.dart';

import 'schedules_data_provider_test.mocks.dart';

@GenerateMocks([HiveInterface, Box<SchedulesBoxType>])
void main() {
  late Box<SchedulesBoxType> box;

  late MockHiveInterface mockHive;

  late SchedulesDataProvider mockProvider;
  late SchedulesDataProvider provider;

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

  Hive.init(SchedulesConst.boxName);

  setUp(() async {
    mockHive = MockHiveInterface();
    box = await Hive.openBox<SchedulesBoxType>(SchedulesConst.boxName);
    mockProvider = SchedulesDataProvider(hive: mockHive);
    provider = SchedulesDataProvider(hive: Hive);
  });

  tearDown(() async {
    try {
      await Hive.box<List<dynamic>>(SchedulesConst.boxName).clear();
    } catch (_) {}
    await Hive.close();
  });

  group('SchedulesDataProvider', () {
    test('readAllData returns all data as a Map in order', () async {
      await box.putAll(testData);
      final result = await provider.readAllData();

      expect(result.length, equals(3));
      expect(
        result.keys.toList(),
        equals([
          '2023-07-07',
          '2023-07-09',
          '2023-09-23',
        ]),
      );
    });

    test('readAllData error returns an empty Map', () async {
      when(mockHive.openBox<SchedulesBoxType>(SchedulesConst.boxName))
          .thenThrow(Error.new);

      final result = await mockProvider.readAllData();

      expect(result.isEmpty, equals(true));
    });

    test('readData return correct data', () async {
      const key = '2023-07-09';
      await box.putAll(testData);
      final result = await provider.readData(key);

      expect(result, equals(testData[key]));
    });

    test('readData error returns an empty Map', () async {
      when(mockHive.openBox<SchedulesBoxType>(SchedulesConst.boxName))
          .thenThrow(Error.new);

      final result = await mockProvider.readData('2023-07-09');

      expect(result?.isEmpty, equals(true));
    });

    test('writeData write data in the box', () async {
      const key = '2023-07-09';
      final value = {
        SchedulesConst.courtNames[0]: [
          'Daniela Pereira',
          'Tony Gutierrez',
        ]
      };

      await provider.writeData(key, value);
      final dataWritted = box.get(key);

      expect(dataWritted, equals(value));
    });

    test('deleteData deletes the key', () async {
      const key = '2023-07-09';
      await provider.deleteData(key);
      expect(box.get(key), isNull);
    });

    test('deleteKeys deletes many keys', () async {
      final keys = ['2023-07-09', '2023-07-06'];
      await provider.deleteKeys(keys);
      expect(box.get(keys[0]), isNull);
      expect(box.get(keys[1]), isNull);
    });
  });
}
