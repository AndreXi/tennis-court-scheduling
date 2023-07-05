import 'package:hive/hive.dart';

part 'schedules_model.g.dart';

@HiveType(typeId: 0)
class SchedulesModel extends HiveObject {
  SchedulesModel({
    required this.courtName,
    required this.userName,
    required this.reservedDate,
  });

  @HiveField(0)
  String courtName;

  @HiveField(1)
  String userName;

  @HiveField(2)
  DateTime reservedDate;
}
