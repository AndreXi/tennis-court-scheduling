part of 'create_schedule_cubit.dart';

class SchedulesCreateScheduleData {
  const SchedulesCreateScheduleData({
    required this.userName,
    required this.courtName,
    required this.date,
  });

  final String userName;
  final String courtName;
  final DateTime date;

  SchedulesCreateScheduleData copyWith({
    String? userName,
    String? courtName,
    DateTime? date,
  }) {
    return SchedulesCreateScheduleData(
      userName: userName ?? this.userName,
      courtName: courtName ?? this.courtName,
      date: date ?? this.date,
    );
  }

  @override
  String toString() => '''
SchedulesCreateScheduleData(
  userName: $userName, 
  courtName: $courtName, 
  date: $date
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
