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
            ),
          ),
        );

  final SchedulesRepository repository;

  void changeDate(DateTime newDate) {
    emit(CreateScheduleFetching(data: state.data.copyWith(date: newDate)));
    // repository.getAll();
    emit(CreateScheduleSuccess(data: state.data.copyWith()));
  }

  void changeName(String name) {
    emit(CreateScheduleSuccess(data: state.data.copyWith(userName: name)));
  }
}
