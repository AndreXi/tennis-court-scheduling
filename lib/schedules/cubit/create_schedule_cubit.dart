import 'package:bloc/bloc.dart';
import 'package:tennis_court_scheduling/schedules/schedules.dart';

part 'create_schedule_state.dart';

class CreateScheduleCubit extends Cubit<CreateScheduleState> {
  CreateScheduleCubit({required this.repository})
      : super(
          CreateScheduleFetch(
            data: SchedulesCreateScheduleData(
              userName: '',
              courtName: '',
              date: DateTime.now(),
              availability:
                  List.filled(SchedulesConst.maxDailySchedulesByCourt, false),
            ),
          ),
        ) {
    /// Default [data.date] selection
    changeDate(state.data.date);
  }

  final SchedulesRepository repository;

  Future<void> changeDate(DateTime newDate) async {
    emit(CreateScheduleFetching(data: state.data.copyWith(date: newDate)));

    /// Update the [availability]
    final newAvailability = await repository.checkAvailability(
      SchedulesConst.courtNames,
      newDate,
      SchedulesConst.maxDailySchedulesByCourt,
    );

    /// Check if the selected [courtName] is available
    var newCourtName = state.data.courtName;
    final selectedCourtIndex =
        SchedulesConst.courtNames.indexOf(state.data.courtName);
    if (selectedCourtIndex > -1 && !newAvailability[selectedCourtIndex]) {
      newCourtName = ''; // Reset the selection
    }

    emit(
      CreateScheduleSuccess(
        data: state.data.copyWith(
          availability: newAvailability,
          courtName: newCourtName,
        ),
      ),
    );
  }

  void changeName(String newName) {
    emit(CreateScheduleSuccess(data: state.data.copyWith(userName: newName)));
  }

  void changeCourt(String newCourtName) {
    emit(
      CreateScheduleSuccess(data: state.data.copyWith(courtName: newCourtName)),
    );
  }

  Future<void> createSchedule(ReservationInfo info) async {
    emit(CreateScheduleCreationLoading(data: state.data.copyWith()));
    try {
      await repository.createSchedule(info);
      emit(CreateScheduleCreationSuccess(data: state.data.copyWith()));
    } catch (_) {
      emit(
        CreateScheduleError(
          'Creation failed, check the availability of the court',
          data: state.data.copyWith(),
        ),
      );
    }
  }
}
