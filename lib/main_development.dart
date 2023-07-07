import 'package:tennis_court_scheduling/app/app.dart';
import 'package:tennis_court_scheduling/bootstrap.dart';

void main() {
  bootstrap(() async {
    // final box = await Hive.openBox<SchedulesBoxType>(
    //   SchedulesConst.boxName,
    // );

    // await box.putAll({
    //   '2023-09-23': {
    //     SchedulesConst.courtNames[1]: ['Andres Pereira'],
    //   },
    //   '2023-07-07': {
    //     SchedulesConst.courtNames[2]: [
    //       'Maria Garcia',
    //       'Pedro Martinez',
    //       'Jose Torres',
    //     ],
    //     SchedulesConst.courtNames[0]: [
    //       'Daniela Pereira',
    //       'Tony Gutierrez',
    //     ]
    //   },
    //   '2023-07-09': {
    //     SchedulesConst.courtNames[2]: ['Sonia Perez']
    //   },
    //   '2002-03-09': {
    //     SchedulesConst.courtNames[2]: ['Pasado']
    //   },
    //   '2022-03-09': {
    //     SchedulesConst.courtNames[2]: ['Pasado']
    //   },
    // });

    return App();
  });
}
