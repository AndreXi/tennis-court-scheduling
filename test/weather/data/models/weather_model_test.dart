import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tennis_court_scheduling/weather/data/models/weather_model.dart';

void main() async {
  Hive
    ..init('test')
    ..registerAdapter(WeatherModelAdapter());

  final date = DateTime.now();
  const precipitationProbabilityDay = 50;
  const precipitationProbabilityNight = 40;

  group('WeatherModel', () {
    test('WeatherModel can be created', () {
      final weatherModel = WeatherModel(
        date: date,
        precipitationProbabilityDay: precipitationProbabilityDay,
        precipitationProbabilityNight: precipitationProbabilityNight,
      );

      expect(weatherModel, isA<WeatherModel>());
    });

    test('WeatherModel properties are valid', () {
      final weatherModel = WeatherModel(
        date: date,
        precipitationProbabilityDay: precipitationProbabilityDay,
        precipitationProbabilityNight: precipitationProbabilityNight,
      );

      expect(weatherModel.date, equals(date));
      expect(
        weatherModel.precipitationProbabilityDay,
        equals(precipitationProbabilityDay),
      );
      expect(
        weatherModel.precipitationProbabilityNight,
        equals(precipitationProbabilityNight),
      );
    });

    test('WeatherModel can be read and write from Hive', () async {
      final box = await Hive.openBox<WeatherModel>('testBox');
      final key = await box.add(
        WeatherModel(
          date: date,
          precipitationProbabilityDay: precipitationProbabilityDay,
          precipitationProbabilityNight: precipitationProbabilityNight,
        ),
      );

      final readWeatherModel = box.get(key);

      expect(readWeatherModel, isA<WeatherModel>());
      expect(readWeatherModel?.date, equals(date));
      expect(
        readWeatherModel?.precipitationProbabilityDay,
        equals(precipitationProbabilityDay),
      );
      expect(
        readWeatherModel?.precipitationProbabilityNight,
        equals(precipitationProbabilityNight),
      );
    });
  });

  tearDownAll(() async {
    try {
      await Hive.box<List<dynamic>>('test').clear();
    } catch (_) {}
    await Hive.close();
  });
}
