import 'package:tennis_court_scheduling/weather/weather.dart';

class WeatherRepository {
  WeatherRepository({required this.dataProvider});

  final WeatherDataProvider dataProvider;

  Future<List<WeatherModel>> getData(String date) async {
    final data = await dataProvider.readBox(date);

    if (data == null) {
      print('OK');
    }

    return [];
  }
}
