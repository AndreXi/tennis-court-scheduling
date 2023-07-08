import 'package:bloc/bloc.dart';
import 'package:tennis_court_scheduling/schedules/schedules.dart';
import 'package:tennis_court_scheduling/weather/weather.dart';

part 'schedules_state.dart';

class SchedulesCubit extends Cubit<SchedulesState> {
  SchedulesCubit({
    required this.schedulesRepository,
    required this.weatherRepository,
  }) : super(
          const SchedulesFetch(
            data: SchedulesData(
              schedules: {},
              weatherForecasts: {},
            ),
          ),
        );

  final SchedulesRepository schedulesRepository;
  final WeatherRepository weatherRepository;

  Future<void> fetchData() async {
    emit(SchedulesFetching(data: state.data.copyWith()));
    try {
      final schedules = await schedulesRepository.getAll();

      /// Fetch weather forecasts for each date
      final forecasts = <String, WeatherModel>{};
      for (final date in schedules.keys) {
        final weatherData =
            await weatherRepository.getData(DateTime.parse(date));
        if (weatherData != null) {
          forecasts[date] = weatherData;
        }
      }

      schedules.isEmpty
          ? emit(SchedulesEmpty(data: state.data.copyWith()))
          : emit(
              SchedulesSuccess(
                data: SchedulesData(
                  schedules: schedules,
                  weatherForecasts: forecasts,
                ),
              ),
            );
    } catch (error) {
      emit(SchedulesError(error.toString(), data: state.data.copyWith()));
    }
  }

  Future<void> deleteReservation(ReservationInfo info) async {
    final result = await schedulesRepository.removeReservation(info);
    if (result) {
      emit(SchedulesFetch(data: state.data.copyWith()));
    } else {
      emit(
        SchedulesError(
          'Error deleting the reservation, reload the data and try again',
          data: state.data.copyWith(),
        ),
      );
    }
  }
}
