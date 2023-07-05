import 'package:tennis_court_scheduling/schedules/schedules.dart';

typedef SchedulesBoxType = List<SchedulesModel>;

abstract final class SchedulesConst {
  static String boxName = 'schedules';
  static List<String> courtNames = [
    'Cancha A',
    'Cancha B',
    'Cancha C',
  ];
}
