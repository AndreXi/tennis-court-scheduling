// ignore_for_file: avoid_dynamic_calls

import 'package:dio/dio.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tennis_court_scheduling/env/env.dart';
import 'package:tennis_court_scheduling/weather/weather.dart';
import 'package:test/test.dart';

import 'weather_data_provider_test.mocks.dart';

@GenerateMocks([Dio])
void main() {
  group('WeatherDataProvider', () {
    late Dio mockDio;
    late WeatherDataProvider weatherDataProvider;
    late List<WeatherModel> weatherData;

    Hive.registerAdapter(WeatherModelAdapter());

    setUp(() {
      mockDio = MockDio();
      weatherDataProvider = WeatherDataProvider(dio: mockDio);
      weatherData = [
        WeatherModel(
          precipitationProbabilityDay: 12,
          precipitationProbabilityNight: 21,
          date: DateTime(2023, 1, 2),
        ),
        WeatherModel(
          precipitationProbabilityDay: 34,
          precipitationProbabilityNight: 43,
          date: DateTime(2023, 1, 3),
        ),
      ];
      Hive.init('test');
    });

    test('fetchForecastData returns null if Dio throws an exception', () async {
      when(
        mockDio.get<dynamic>(
          Env.apiUrl,
          queryParameters: {
            'apikey': Env.apiKeyWeather,
            'details': true,
          },
        ),
      ).thenThrow(DioException(requestOptions: RequestOptions()));

      final result = await weatherDataProvider.fetchForecastData();

      expect(result, isNull);
      verify(
        mockDio.get<dynamic>(
          Env.apiUrl,
          queryParameters: {
            'apikey': Env.apiKeyWeather,
            'details': true,
          },
        ),
      ).called(1);
    });

    test('fetchForecastData returns data if Dio call succeeds', () async {
      final response = Response(
        requestOptions: RequestOptions(
          baseUrl: Env.apiUrl,
          queryParameters: {
            'apikey': Env.apiKeyWeather,
            'details': true,
          },
        ),
        data: {
          'DailyForecasts': [
            {
              'Date': '2023-07-06T07:00:00-04:00',
              'Day': {'PrecipitationProbability': 12},
              'Night': {'PrecipitationProbability': 21},
            },
            {
              'Date': '2023-07-07T07:00:00-04:00',
              'Day': {'PrecipitationProbability': 34},
              'Night': {'PrecipitationProbability': 43},
            },
          ],
        },
        statusCode: 200,
      );

      when(
        mockDio.get<dynamic>(
          Env.apiUrl,
          queryParameters: {
            'apikey': Env.apiKeyWeather,
            'details': true,
          },
        ),
      ).thenAnswer((_) async => response);

      final result = await weatherDataProvider.fetchForecastData();

      expect(result, isNotNull);
      expect(result!.containsKey('DailyForecasts'), isTrue);
      expect(result['DailyForecasts'].length, equals(2));
      expect(result['DailyForecasts'][0].containsKey('Date'), isTrue);
      expect(result['DailyForecasts'][0].containsKey('Day'), isTrue);
      expect(result['DailyForecasts'][0].containsKey('Night'), isTrue);

      verify(
        mockDio.get<dynamic>(
          Env.apiUrl,
          queryParameters: {
            'apikey': Env.apiKeyWeather,
            'details': true,
          },
        ),
      ).called(1);
    });

    test('readBox returns empty list if box does not have data', () async {
      final result = await weatherDataProvider.readBox('non_existent_key');
      expect(result, isEmpty);
    });

    test('readBox returns data stored in box', () async {
      final box = await Hive.openBox<List<dynamic>>('weather');
      final data = weatherData;
      await box.put('2023-01-02', data);

      final result = await weatherDataProvider.readBox('2023-01-02');

      expect(result, equals(data));
    });

    test('writeBox stores data in box', () async {
      final box = await Hive.openBox<List<dynamic>>('weather');
      final data = weatherData;

      await weatherDataProvider.writeBox('key', data);
      final result = box.get('key');

      expect(result, equals(data));
    });

    test('clearBox clears the box', () async {
      final box = await Hive.openBox<List<dynamic>>('weather');
      final data = weatherData;
      await box.put('key', data);

      final result = await weatherDataProvider.clearBox();
      final boxIsEmpty = box.isEmpty;

      expect(result, greaterThan(0));
      expect(boxIsEmpty, isTrue);
    });

    tearDown(() async {
      await Hive.close();
    });
  });
}
