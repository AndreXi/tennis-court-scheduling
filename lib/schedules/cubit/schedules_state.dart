part of 'schedules_cubit.dart';

abstract class SchedulesState extends Equatable {
  const SchedulesState();

  @override
  List<Object> get props => [];
}

class SchedulesInitial extends SchedulesState {}

class SchedulesFetching extends SchedulesState {}

class SchedulesEmpty extends SchedulesState {}

final class SchedulesSuccess extends SchedulesState {
  const SchedulesSuccess(this.items);

  final Map<String, SchedulesBoxType> items;

  @override
  List<Object> get props => [items];
}

final class SchedulesError extends SchedulesState {
  const SchedulesError(this.error);

  final String error;

  @override
  List<Object> get props => [error];
}
