import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tennis_court_scheduling/env/env.dart';
import 'package:tennis_court_scheduling/weather/weather.dart';

class WeatherDataProvider {
  final _dio = Dio();

  Future<Map<String, dynamic>?> fetchForecastData() async {
    debugPrint('API Weather Request');
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        Env.apiUrl,
        queryParameters: {
          'apikey': Env.apiKeyWeather,
          'details': true,
          // 'language': 'es-VE',
        },
      );
      return response.data;
    } catch (_) {
      return null;
    }
  }

  Future<List<WeatherModel>> readBox(String key) async {
    final box = await Hive.openBox<List<dynamic>>('weather');
    // final box = await Hive.openBox<List<dynamic>>('weather');
    return box.get(key, defaultValue: [])?.cast<WeatherModel>() ?? [];
  }

  Future<void> writeBox(String key, List<WeatherModel> data) async {
    final box = await Hive.openBox<List<dynamic>>('weather');
    return box.put(key, data);
  }

  Future<int> clearBox() async {
    final box = await Hive.openBox<List<dynamic>>('weather');
    return box.clear();
  }
}
