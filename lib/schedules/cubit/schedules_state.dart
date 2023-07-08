part of 'schedules_cubit.dart';

class SchedulesData {
  const SchedulesData({
    required this.schedules,
    required this.weatherForecasts,
  });

  final Map<String, SchedulesBoxType> schedules;
  final Map<String, WeatherModel> weatherForecasts;

  SchedulesData copyWith({
    Map<String, SchedulesBoxType>? schedules,
    Map<String, WeatherModel>? weatherForecasts,
  }) {
    return SchedulesData(
      schedules: schedules ?? this.schedules,
      weatherForecasts: weatherForecasts ?? this.weatherForecasts,
    );
  }
}

sealed class SchedulesState<T extends SchedulesData> {
  // coverage:ignore-line
  const SchedulesState({required this.data});
  final SchedulesData data;
}

final class SchedulesFetch extends SchedulesState {
  const SchedulesFetch({required super.data});
}

final class SchedulesFetching extends SchedulesState {
  const SchedulesFetching({required super.data});
}

final class SchedulesEmpty extends SchedulesState {
  const SchedulesEmpty({required super.data});
}

final class SchedulesSuccess extends SchedulesState {
  const SchedulesSuccess({required super.data});
}

final class SchedulesError extends SchedulesState {
  const SchedulesError(this.error, {required super.data});
  final String error;
}
