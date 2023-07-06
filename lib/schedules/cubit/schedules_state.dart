part of 'schedules_cubit.dart';

abstract class SchedulesState extends Equatable {
  const SchedulesState();

  @override
  List<Object> get props => [];
}

class SchedulesFetch extends SchedulesState {}

class SchedulesFetching extends SchedulesState {}

class SchedulesEmpty extends SchedulesState {}

final class SchedulesSuccess extends SchedulesState {}

final class SchedulesError extends SchedulesState {
  const SchedulesError(this.error);

  final String error;

  @override
  List<Object> get props => [error];
}

class SchedulesConfirmDelete extends SchedulesState {
  const SchedulesConfirmDelete({
    required this.info,
  });

  final ReservationInfo info;

  @override
  List<Object> get props => [info];
}
