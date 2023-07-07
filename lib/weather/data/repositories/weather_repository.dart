import 'package:tennis_court_scheduling/weather/data/data_providers/weather_data_provider.dart';

class WeatherRepository {
  WeatherRepository({required this.dataProvider});

  final WeatherDataProvider dataProvider;

  dynamic getData() {}
}
