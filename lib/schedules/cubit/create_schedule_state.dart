part of 'create_schedule_cubit.dart';

class SchedulesCreateScheduleData {
  const SchedulesCreateScheduleData({
    required this.availability,
    required this.userName,
    required this.courtName,
    required this.date,
  });

  final String userName;
  final String courtName;
  final DateTime date;
  final List<bool> availability;

  SchedulesCreateScheduleData copyWith({
    String? userName,
    String? courtName,
    DateTime? date,
    List<bool>? availability,
  }) {
    return SchedulesCreateScheduleData(
      userName: userName ?? this.userName,
      courtName: courtName ?? this.courtName,
      date: date ?? this.date,
      availability: availability ?? this.availability,
    );
  }

  @override
  String toString() => '''
SchedulesCreateScheduleData(
  userName: $userName, 
  courtName: $courtName, 
  date: $date,
  availability: $availability,
)''';
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

final class CreateScheduleError extends CreateScheduleState {
  CreateScheduleError(this.message, {required super.data});
  final String message;
}

final class CreateScheduleCreationLoading extends CreateScheduleState {
  CreateScheduleCreationLoading({required super.data});
}

final class CreateScheduleCreationSuccess extends CreateScheduleState {
  CreateScheduleCreationSuccess({required super.data});
}
