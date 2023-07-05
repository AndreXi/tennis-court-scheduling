import 'package:tennis_court_scheduling/schedules/schedules.dart';

class SchedulesRepository {
  SchedulesRepository({required this.dataProvider});

  final SchedulesDataProvider dataProvider;

  Future<Map<String, SchedulesBoxType>> getAll() async {
    return dataProvider.readData();
  }
}
