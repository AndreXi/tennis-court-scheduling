part of 'schedules_cubit.dart';

abstract class SchedulesState {
  const SchedulesState();
}

class SchedulesFetch extends SchedulesState {}

class SchedulesFetching extends SchedulesState {}

class SchedulesEmpty extends SchedulesState {}

final class SchedulesSuccess extends SchedulesState {}

final class SchedulesError extends SchedulesState {
  const SchedulesError(this.error);

  final String error;
}

class SchedulesConfirmDelete extends SchedulesState {
  const SchedulesConfirmDelete({
    required this.info,
  });

  final ReservationInfo info;
}
