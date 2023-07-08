import 'package:tennis_court_scheduling/schedules/data/models/schedules_model.dart';

typedef SchedulesBoxType = SchedulesModel;

abstract final class SchedulesConst {
  static String boxName = 'schedules';
  static int maxDailySchedulesByCourt = 3;
  static List<String> courtNames = [
    'Cancha A',
    'Cancha B',
    'Cancha C',
  ];
}
