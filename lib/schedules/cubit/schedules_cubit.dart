import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tennis_court_scheduling/schedules/schedules.dart';

part 'schedules_state.dart';

class SchedulesCubit extends Cubit<SchedulesState> {
  SchedulesCubit({required this.repository}) : super(SchedulesFetch());

  final SchedulesRepository repository;

  Future<void> fetchData() async {
    emit(SchedulesFetching());
    try {
      final data = await repository.getAll();
      emit(SchedulesSuccess(data));
    } catch (error) {
      emit(SchedulesError(error.toString()));
    }
  }

  Future<void> deleteReservation(ReservationInfo info) async {
    final result = await repository.removeReservation(info);
    if (result) {
      emit(SchedulesFetch());
    } else {
      emit(
        const SchedulesError(
          'Error deleting the reservation, reload the data and try again',
        ),
      );
    }
  }
}
