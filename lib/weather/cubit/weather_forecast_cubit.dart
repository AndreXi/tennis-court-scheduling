import 'package:bloc/bloc.dart';
import 'package:tennis_court_scheduling/weather/weather.dart';

part 'weather_forecast_state.dart';

class WeatherForecastCubit extends Cubit<WeatherForecastState> {
  WeatherForecastCubit({required this.repository})
      : super(WeatherForecastFetch());

  final WeatherRepository repository;

  Future<void> fetchData(DateTime date) async {
    emit(WeatherForecastFetching());
    final data = await repository.getData(date);
    if (data != null) {
      emit(
        WeatherForecastSuccess(
          data.precipitationProbabilityDay,
          data.precipitationProbabilityNight,
        ),
      );
    } else {
      emit(WeatherForecastUnknown());
    }
  }
}
