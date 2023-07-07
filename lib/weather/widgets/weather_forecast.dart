import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tennis_court_scheduling/weather/weather.dart';

class WeatherForecast extends StatelessWidget {
  const WeatherForecast({required this.date, super.key});

  final DateTime date;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WeatherForecastCubit(
        repository: WeatherRepository(dataProvider: WeatherDataProvider()),
      ),
      child: BlocBuilder<WeatherForecastCubit, WeatherForecastState>(
        builder: (context, state) {
          switch (state) {
            case WeatherForecastFetch():
              context.read<WeatherForecastCubit>().fetchData(date);

            case WeatherForecastFetching():
              return const CircularProgressIndicator();

            case WeatherForecastSuccess():
              return Container(
                child: Row(
                  children: [
                    Icon(
                      Icons.thunderstorm,
                      color: Colors.white,
                    ),
                    WeatherRainProbability(
                      day: state.dayRainProbability,
                      night: state.nightRainProbability,
                    )
                  ],
                ),
              );

            default:
              return SizedBox();
          }
          return SizedBox();
        },
      ),
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
        Text('$day%'),
        // Text('$night%'),
      ],
    );
  }
}
