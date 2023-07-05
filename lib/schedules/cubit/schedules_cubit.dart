import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tennis_court_scheduling/schedules/schedules.dart';

part 'schedules_state.dart';

class SchedulesCubit extends Cubit<SchedulesState> {
  SchedulesCubit({required this.repository}) : super(SchedulesInitial());

  final SchedulesRepository repository;
}
