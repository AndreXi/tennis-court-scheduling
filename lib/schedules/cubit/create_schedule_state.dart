part of 'create_schedule_cubit.dart';

class SchedulesCreateScheduleData {
  const SchedulesCreateScheduleData({
    required this.availability,
    required this.userName,
    required this.courtName,
    required this.date,
    this.weatherInfo,
  });

  final String userName;
  final String courtName;
  final DateTime date;
  final List<bool> availability;
  final WeatherModel? weatherInfo;

  SchedulesCreateScheduleData copyWith({
    String? userName,
    String? courtName,
    DateTime? date,
    List<bool>? availability,
    WeatherModel? weatherInfo,
  }) {
    return SchedulesCreateScheduleData(
      userName: userName ?? this.userName,
      courtName: courtName ?? this.courtName,
      date: date ?? this.date,
      availability: availability ?? this.availability,
      weatherInfo: weatherInfo ?? this.weatherInfo,
    );
  }
}

sealed class CreateScheduleState<T extends SchedulesCreateScheduleData> {
  const CreateScheduleState({required this.data});
  final SchedulesCreateScheduleData data;
}

final class CreateScheduleFetch extends CreateScheduleState {
  CreateScheduleFetch({required super.data});
}

final class CreateScheduleFetching extends CreateScheduleState {
  CreateScheduleFetching({required super.data});
}

final class CreateScheduleSuccess extends CreateScheduleState {
  CreateScheduleSuccess({required super.data});
}

final class CreateScheduleCreationLoading extends CreateScheduleState {
  CreateScheduleCreationLoading({required super.data});
}

final class CreateScheduleCreationSuccess extends CreateScheduleState {
  CreateScheduleCreationSuccess({required super.data});
}
