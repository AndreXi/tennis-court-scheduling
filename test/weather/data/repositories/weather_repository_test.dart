import 'dart:ffi';

import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tennis_court_scheduling/weather/weather.dart';

import 'weather_repository_test.mocks.dart';

@GenerateMocks([WeatherDataProvider])
void main() {
  group('WeatherRepository', () {
    late MockWeatherDataProvider mockDataProvider;
    late WeatherRepository weatherRepository;

    setUp(() {
      mockDataProvider = MockWeatherDataProvider();
      weatherRepository = WeatherRepository(dataProvider: mockDataProvider);
    });

    test(
        '''getData gets the cache data from today and return the weather for tomorrow''',
        () async {
      final now = DateTime.now();
      final tomorrow = now.add(const Duration(days: 1));
      final expectedData = [
        WeatherModel(
          date: now,
          precipitationProbabilityDay: 50,
          precipitationProbabilityNight: 40,
        ),
        WeatherModel(
          date: tomorrow,
          precipitationProbabilityDay: 60,
          precipitationProbabilityNight: 30,
        ),
      ];

      // Setup the mock
      final formattedDate = DateFormat('yyyy-MM-dd').format(now);
      when(mockDataProvider.readBox(formattedDate))
          .thenAnswer((_) async => expectedData);
      when(mockDataProvider.fetchForecastData()).thenAnswer(
        (_) async => {
          'DailyForecasts': [
            {
              'Date': now.toIso8601String(),
              'Day': {'PrecipitationProbability': 50},
              'Night': {'PrecipitationProbability': 40},
            },
            {
              'Date': tomorrow.toIso8601String(),
              'Day': {'PrecipitationProbability': 60},
              'Night': {'PrecipitationProbability': 30},
            },
          ]
        },
      );

      // Try to get the weather for tomorrow
      final result = await weatherRepository.getData(tomorrow);

      // Check the requested data is the weather from tomorrow.
      expect(result, equals(expectedData[1]));

      // Verify the box was read one time
      verify(mockDataProvider.readBox(formattedDate)).called(1);

      /// Verify the fetch method was not called
      verifyNever(mockDataProvider.fetchForecastData());
    });

    test(
        '''getData clean the box and fetch data from today and return the weather for tomorrow''',
        () async {
      final now = DateTime.now();
      final tomorrow = now.add(const Duration(days: 1));
      final expectedData = [
        WeatherModel(
          date: now,
          precipitationProbabilityDay: 50,
          precipitationProbabilityNight: 40,
        ),
        WeatherModel(
          date: tomorrow,
          precipitationProbabilityDay: 60,
          precipitationProbabilityNight: 30,
        ),
      ];

      // Setup the mock
      final formattedDate = DateFormat('yyyy-MM-dd').format(now);
      when(mockDataProvider.clearBox()).thenAnswer((_) async => 0);
      when(mockDataProvider.readBox(formattedDate)).thenAnswer((_) async => []);
      when(mockDataProvider.fetchForecastData()).thenAnswer(
        (_) async => {
          'DailyForecasts': [
            {
              'Date': now.toIso8601String(),
              'Day': {'PrecipitationProbability': 50},
              'Night': {'PrecipitationProbability': 40},
            },
            {
              'Date': tomorrow.toIso8601String(),
              'Day': {'PrecipitationProbability': 60},
              'Night': {'PrecipitationProbability': 30},
            },
          ]
        },
      );

      // Try to get the weather for tomorrow
      final result = await weatherRepository.getData(tomorrow);

      // Check the requested data is the weather from tomorrow.
      expect(result?.date == expectedData[1].date, equals(true));

      // Verify the box was read one time
      verify(mockDataProvider.readBox(formattedDate)).called(1);

      /// Verify the fetch method was called one time only
      verify(mockDataProvider.fetchForecastData()).called(1);
    });

    test('''getData clean the box and fetch data and return nothing''',
        () async {
      final now = DateTime.now();
      final tomorrow = now.add(const Duration(days: 1));

      // Setup the mock
      final formattedDate = DateFormat('yyyy-MM-dd').format(now);
      when(mockDataProvider.clearBox()).thenAnswer((_) async => 0);
      when(mockDataProvider.readBox(formattedDate)).thenAnswer((_) async => []);
      when(mockDataProvider.fetchForecastData()).thenAnswer(
        (_) async => null,
      );

      // Try to get the weather for tomorrow
      final result = await weatherRepository.getData(tomorrow);

      // If there are no data it returns null
      expect(result, isNull);

      // Verify the box was read one time
      verify(mockDataProvider.readBox(formattedDate)).called(1);

      /// Verify the fetch method was called one time only
      verify(mockDataProvider.fetchForecastData()).called(1);
    });
  });
}
