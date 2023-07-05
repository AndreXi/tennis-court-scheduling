import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tennis_court_scheduling/schedules/schedules.dart';

part 'schedules_state.dart';

class SchedulesCubit extends Cubit<SchedulesState> {
  SchedulesCubit({required this.repository}) : super(SchedulesInitial());

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
}
