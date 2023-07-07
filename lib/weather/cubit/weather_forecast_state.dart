part of 'weather_forecast_cubit.dart';

sealed class WeatherForecastState {}

final class WeatherForecastFetch extends WeatherForecastState {}

final class WeatherForecastFetching extends WeatherForecastState {}

final class WeatherForecastSuccess extends WeatherForecastState {
  WeatherForecastSuccess(this.dayRainProbability, this.nightRainProbability);

  final int dayRainProbability;
  final int nightRainProbability;
}

final class WeatherForecastUnknown extends WeatherForecastState {}
