import 'package:bloc/bloc.dart';
import 'package:intl/intl.dart';
import 'package:tennis_court_scheduling/weather/weather.dart';

part 'weather_forecast_state.dart';

class WeatherForecastCubit extends Cubit<WeatherForecastState> {
  WeatherForecastCubit({required this.repository})
      : super(WeatherForecastFetch());

  final WeatherRepository repository;

  Future<void> fetchData(DateTime date) async {
    emit(WeatherForecastFetching());
    final formattedDate = DateFormat('yyyy-MM-dd').format(date);
    await repository.getData(formattedDate);
    emit(WeatherForecastSuccess(23, 98));
  }
}
