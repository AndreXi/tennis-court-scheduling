import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tennis_court_scheduling/weather/weather.dart';

class WeatherForecast extends StatelessWidget {
  const WeatherForecast({required this.date, super.key});

  final DateTime date;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherForecastCubit, WeatherForecastState>(
      builder: (context, state) {
        switch (state) {
          case WeatherForecastFetch():
            context.read<WeatherForecastCubit>().fetchData(date);

          case WeatherForecastFetching():
            return const CircularProgressIndicator();

          case WeatherForecastSuccess():
            return Row(
              children: [
                const Icon(
                  Icons.thunderstorm,
                  color: Color(0xfffefff3),
                ),
                const SizedBox(width: 8),
                WeatherRainProbability(
                  day: state.dayRainProbability,
                  night: state.nightRainProbability,
                )
              ],
            );

          case WeatherForecastUnknown():
            return const Row(
              children: [
                Icon(
                  Icons.thunderstorm,
                  color: Color(0x99fefff3),
                ),
                SizedBox(width: 8),
                WeatherRainProbabilityUnknown()
              ],
            );
            ;

          default:
            return const SizedBox();
        }
        return const SizedBox();
      },
    );
  }
}

class WeatherForecast2 extends StatelessWidget {
  const WeatherForecast2({super.key, this.day});

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
