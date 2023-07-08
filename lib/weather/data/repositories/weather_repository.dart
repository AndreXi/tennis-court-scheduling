// ignore_for_file: avoid_dynamic_calls

import 'package:intl/intl.dart';
import 'package:tennis_court_scheduling/weather/weather.dart';

class WeatherRepository {
  WeatherRepository({required this.dataProvider});

  final WeatherDataProvider dataProvider;

  Future<WeatherModel?> getData(DateTime date) async {
    final formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    var data = await dataProvider.readBox(formattedDate);

    /// If [data] is null fetch data from the [dataProvider]
    if (data.isEmpty) {
      data = await _fetchAndWriteBox();
    }

    try {
      return data.firstWhere(
        (item) =>
            DateTime(item.date.year, item.date.month, item.date.day) ==
            DateTime(date.year, date.month, date.day),
      );
    } catch (_) {
      return null;
    }
  }

  Future<List<WeatherModel>> _fetchAndWriteBox() async {
    /// Clean the box because old data is not needed
    await dataProvider.clearBox();

    /// Make the request to the API and get the rawData
    final rawData = await dataProvider.fetchForecastData();

    if (rawData == null) return [];

    final data = <WeatherModel>[];
    final rawForecasts = rawData['DailyForecasts'] as List<dynamic>? ?? [];
    for (final item in rawForecasts) {
      final date = DateTime.parse(item['Date'] as String);
      final dayProbability = item['Day']['PrecipitationProbability'] as int;
      final nightProbability = item['Night']['PrecipitationProbability'] as int;

      data.add(
        WeatherModel(
          date: date,
          precipitationProbabilityDay: dayProbability,
          precipitationProbabilityNight: nightProbability,
        ),
      );
    }

    /// Save into the box
    final formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    await dataProvider.writeBox(formattedDate, data);

    return data;
  }
}
