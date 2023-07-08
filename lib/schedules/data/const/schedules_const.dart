typedef SchedulesBoxType = Map<String, List<String>>;

abstract final class SchedulesConst {
  static String boxName = 'schedules';
  static int maxDailySchedulesByCourt = 3;
  static List<String> courtNames = [
    'Cancha A',
    'Cancha B',
    'Cancha C',
  ];
}
