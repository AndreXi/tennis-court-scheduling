import 'package:hive_flutter/hive_flutter.dart';
import 'package:tennis_court_scheduling/app/app.dart';
import 'package:tennis_court_scheduling/bootstrap.dart';
import 'package:tennis_court_scheduling/schedules/schedules.dart';

void main() {
  bootstrap(() async {
    final box = await Hive.openBox<SchedulesBoxType>(SchedulesConst.boxName);

    if (box.isEmpty) {
      await box.putAll({
        '2023-9-23': [
          SchedulesModel(
            courtName: SchedulesConst.courtNames[1],
            userName: 'Andres Pereira',
            reservedDate: DateTime(2023, 9, 23),
          ),
        ],
        '2023-7-5': [
          SchedulesModel(
            courtName: SchedulesConst.courtNames[0],
            userName: 'Maria Garcia',
            reservedDate: DateTime(2023, 7, 5),
          ),
          SchedulesModel(
            courtName: SchedulesConst.courtNames[0],
            userName: 'Pedro Martinez',
            reservedDate: DateTime(2023, 7, 5),
          ),
          SchedulesModel(
            courtName: SchedulesConst.courtNames[0],
            userName: 'Jose Torres',
            reservedDate: DateTime(2023, 7, 5),
          ),
          SchedulesModel(
            courtName: SchedulesConst.courtNames[1],
            userName: 'Daniela Pereira',
            reservedDate: DateTime(2023, 7, 5),
          ),
          SchedulesModel(
            courtName: SchedulesConst.courtNames[1],
            userName: 'Tony Gutierrez',
            reservedDate: DateTime(2023, 7, 5),
          ),
        ],
        '2023-7-6': [
          SchedulesModel(
            courtName: SchedulesConst.courtNames[2],
            userName: 'Sonia Perez',
            reservedDate: DateTime(2023, 7, 5),
          ),
        ],
      });
    }

    return App();
  });
}
