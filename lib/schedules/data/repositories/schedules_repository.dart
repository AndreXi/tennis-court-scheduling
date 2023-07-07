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

    final names = data[info.courtName] as List<String>? ?? []
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
      if (dayData.keys.contains(courtName)) {
        r.add(dayData[courtName]!.length < stock as bool);
      } else {
        r.add(true);
      }
    }

    return r;
  }

  Future<void> createSchedule(ReservationInfo info) async {
    final data = await dataProvider.readData(info.date) ?? {};
    final names = data[info.courtName] as List<String>? ?? [];
    if (names.isEmpty) {
      data[info.courtName] = [info.userName];
    } else {
      names.add(info.userName);
    }
    await dataProvider.writeData(info.date, data);
  }

  Future<void> removePastSchedules() async {
    final dateTimeNow = DateTime.now();
    final formattedDate = DateFormat('yyyy-MM-dd').format(dateTimeNow);

    /// Get all the keys in order and add the current
    final keys = (await dataProvider.readAllData()).keys.toList()
      ..add(formattedDate)
      ..sort(
        (a, b) => a.compareTo(b),
      );

    /// Cut the keys list
    final cutIndex = keys.indexOf(formattedDate);
    final keysToDelete = keys.sublist(0, cutIndex);

    await dataProvider.deleteKeys(keysToDelete);
  }
}
