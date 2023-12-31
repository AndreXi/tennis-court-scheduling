import 'package:hive_flutter/hive_flutter.dart';
import 'package:tennis_court_scheduling/schedules/schedules.dart';

class SchedulesDataProvider {
  SchedulesDataProvider({required this.hive});

  final HiveInterface hive;

  Future<Map<String, SchedulesBoxType>> readAllData() async {
    try {
      final box = await hive.openBox<SchedulesBoxType>(SchedulesConst.boxName);
      return box.toMap().cast();
    } catch (_) {
      return {};
    }
  }

  Future<SchedulesBoxType?> readData(String key) async {
    try {
      final box = await hive.openBox<SchedulesBoxType>(SchedulesConst.boxName);
      return box.get(key);
    } catch (_) {
      return null;
    }
  }

  Future<void> writeData(String key, SchedulesBoxType data) async {
    final box = await hive.openBox<SchedulesBoxType>(SchedulesConst.boxName);
    await box.put(key, data);
  }

  Future<void> deleteData(String key) async {
    final box = await hive.openBox<SchedulesBoxType>(SchedulesConst.boxName);
    await box.delete(key);
  }

  Future<void> deleteKeys(List<String> keys) async {
    final box = await hive.openBox<SchedulesBoxType>(SchedulesConst.boxName);
    await box.deleteAll(keys);
  }
}
