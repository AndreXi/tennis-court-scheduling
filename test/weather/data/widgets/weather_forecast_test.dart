import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tennis_court_scheduling/weather/weather.dart';

import '../../../helpers/helpers.dart';

void main() {
  group('WeatherForecast widget', () {
    testWidgets('renders WeatherRainProbability and show the rain probability',
        (tester) async {
      const dayRainProbability = 23;
      await tester.pumpApp(const WeatherForecast(day: dayRainProbability));
      expect(find.byType(WeatherRainProbability), findsOneWidget);
      expect(find.byType(Icon), findsOneWidget);
      expect(find.text('$dayRainProbability%'), findsOneWidget);
    });

    testWidgets('renders WeatherRainProbabilityUnknown', (tester) async {
      await tester.pumpApp(const WeatherForecast());
      expect(find.byType(WeatherRainProbabilityUnknown), findsOneWidget);
      expect(find.byType(Icon), findsOneWidget);
      expect(find.text('--%'), findsOneWidget);
    });
  });
}
