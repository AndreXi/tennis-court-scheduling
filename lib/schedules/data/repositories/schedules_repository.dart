import 'package:intl/intl.dart';
import 'package:tennis_court_scheduling/schedules/schedules.dart';

class SchedulesRepository {
  SchedulesRepository({required this.dataProvider});

  final SchedulesDataProvider dataProvider;

  Future<Map<String, SchedulesBoxType>> getAll() async {
    return dataProvider.readAllData();
  }

  Future<bool> removeReservation(ReservationInfo info) async {
    final data = await dataProvider.readData(info.date) ?? {};
    if (data.isEmpty || !data.containsKey(info.courtName)) return false;

    final names = data[info.courtName] ?? []
      ..remove(info.userName);

    /// If the list is empty remove the courtData completely
    if (names.isEmpty) {
      data.remove(info.courtName);
    }

    /// If all courts were removed delete the [info.date] key completely
    if (data.isEmpty) {
      await dataProvider.deleteData(info.date);
      return true;
    }

    /// Write the updated data
    await dataProvider.writeData(info.date, data);
    return true;
  }

  Future<List<bool>> checkAvailability(
    List<String> courtNames,
    DateTime date,
    int stock,
  ) async {
    final r = <bool>[];
    final formattedDate = DateFormat('yyyy-MM-dd').format(date);
    final dayData = await dataProvider.readData(formattedDate) ?? {};

    for (final courtName in courtNames) {
      if (dayData.keys.contains(courtName) &&
          dayData[courtName]!.length < stock) {
        r.add(true);
      }
      r.add(false);
    }

    return r;
  }
}
