import 'package:hive_flutter/hive_flutter.dart';

part 'schedules_model.g.dart';

@HiveType(typeId: 2)
class SchedulesModel extends HiveObject {
  SchedulesModel({
    required this.courts,
  });

  @HiveField(0)
  final Map<String, List<String>> courts;
}
