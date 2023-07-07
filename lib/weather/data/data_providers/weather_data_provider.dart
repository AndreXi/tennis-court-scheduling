import 'package:dio/dio.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tennis_court_scheduling/env/env.dart';

typedef TempType = dynamic;

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

  Future<TempType> readBox(String key) async {
    final box = await Hive.openBox<TempType>('weather');
    return box.get(key);
  }

  Future<void> writeBox(String key, TempType data) async {
    final box = await Hive.openBox<TempType>('weather');
    return box.put(key, data);
  }

  Future<int> clearBox(String key, TempType data) async {
    final box = await Hive.openBox<TempType>('weather');
    return box.clear();
  }
}
