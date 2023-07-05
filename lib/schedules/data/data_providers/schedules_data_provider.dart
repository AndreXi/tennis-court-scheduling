import 'package:hive_flutter/hive_flutter.dart';
import 'package:tennis_court_scheduling/schedules/schedules.dart';

class SchedulesDataProvider {
  Future<Map<String, SchedulesBoxType>> readData() async {
    final box = await Hive.openBox<SchedulesBoxType>(SchedulesConst.boxName);
    return box.toMap().cast();
  }
}
