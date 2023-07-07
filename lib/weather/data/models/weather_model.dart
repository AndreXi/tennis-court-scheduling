import 'package:hive/hive.dart';

part 'weather_model.g.dart';

@HiveType(typeId: 0)
class WeatherModel extends HiveObject {
  WeatherModel({
    required this.date,
    required this.precipitationProbabilityDay,
    required this.precipitationProbabilityNight,
  });

  @HiveField(0)
  final DateTime date;

  @HiveField(1)
  final int precipitationProbabilityDay;

  @HiveField(2)
  final int precipitationProbabilityNight;
}
