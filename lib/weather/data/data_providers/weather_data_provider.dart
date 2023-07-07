import 'package:dio/dio.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tennis_court_scheduling/env/env.dart';
import 'package:tennis_court_scheduling/weather/weather.dart';

class WeatherDataProvider {
  final _dio = Dio();

  Future<Map<String, dynamic>?> fetchForecastData() async {
    final response = await _dio.get<Map<String, dynamic>>(
      Env.apiUrl,
      queryParameters: {
        'apikey': Env.apiKeyWeather,
        'details': true,
        // 'language': 'es-VE',
      },
    );
    return response.data;
  }

  Future<List<WeatherModel>?> readBox(String key) async {
    final box = await Hive.openBox<List<WeatherModel>>('weather');
    return box.get(key);
  }

  Future<void> writeBox(String key, List<WeatherModel> data) async {
    final box = await Hive.openBox<List<WeatherModel>>('weather');
    return box.put(key, data);
  }

  Future<int> clearBox(String key, List<WeatherModel> data) async {
    final box = await Hive.openBox<List<WeatherModel>>('weather');
    return box.clear();
  }
}
