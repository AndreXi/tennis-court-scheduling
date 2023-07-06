import 'package:hive_flutter/hive_flutter.dart';
import 'package:tennis_court_scheduling/schedules/schedules.dart';

class SchedulesDataProvider {
  Future<Map<String, SchedulesBoxType>> readAllData() async {
    final box = await Hive.openBox<SchedulesBoxType>(SchedulesConst.boxName);
    return box.toMap().cast();
  }

  Future<SchedulesBoxType?> readData(String key) async {
    final box = await Hive.openBox<SchedulesBoxType>(SchedulesConst.boxName);
    return box.get(key);
  }

  Future<void> writeData(String key, SchedulesBoxType data) async {
    final box = await Hive.openBox<SchedulesBoxType>(SchedulesConst.boxName);
    await box.put(key, data);
  }

  Future<void> deleteData(String key) async {
    final box = await Hive.openBox<SchedulesBoxType>(SchedulesConst.boxName);
    await box.delete(key);
  }
}
