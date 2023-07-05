import 'package:tennis_court_scheduling/schedules/schedules.dart';

class SchedulesRepository {
  SchedulesRepository({required this.dataProvider});

  final SchedulesDataProvider dataProvider;

  Future<Map<String, List<SchedulesModel>>> getAll() async {
    return dataProvider.readData();
  }
}
