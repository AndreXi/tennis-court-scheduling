import 'package:flutter/material.dart';

class WeatherForecast extends StatelessWidget {
  const WeatherForecast({super.key, this.day});

  final int? day;

  @override
  Widget build(BuildContext context) {
    if (day == null) {
      return const WeatherRainProbabilityUnknown();
    }
    return WeatherRainProbability(
      day: day ?? -1,
      night: -1,
    );
  }
}

class WeatherRainProbability extends StatelessWidget {
  const WeatherRainProbability({
    required this.day,
    required this.night,
    super.key,
  });

  final int day;
  final int night;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(
          Icons.thunderstorm,
          color: Color(0xfffefff3),
        ),
        const SizedBox(width: 8),
        Text(
          '$day%',
          style: const TextStyle(
            color: Color(0xfffefff3),
            fontSize: 24,
          ),
        ),
      ],
    );
  }
}

class WeatherRainProbabilityUnknown extends StatelessWidget {
  const WeatherRainProbabilityUnknown({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Icon(
          Icons.thunderstorm,
          color: Color(0x99fefff3),
        ),
        SizedBox(width: 8),
        Text(
          '--%',
          style: TextStyle(
            color: Color(0x99fefff3),
            fontSize: 24,
          ),
        ),
      ],
    );
  }
}
