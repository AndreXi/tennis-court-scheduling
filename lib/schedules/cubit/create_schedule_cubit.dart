import 'package:bloc/bloc.dart';
import 'package:tennis_court_scheduling/schedules/schedules.dart';
import 'package:tennis_court_scheduling/weather/weather.dart';

part 'create_schedule_state.dart';

class CreateScheduleCubit extends Cubit<CreateScheduleState> {
  CreateScheduleCubit({
    required this.schedulesRepository,
    required this.weatherRepository,
  }) : super(
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

  final SchedulesRepository schedulesRepository;
  final WeatherRepository weatherRepository;

  Future<void> changeDate(DateTime newDate) async {
    emit(CreateScheduleFetching(data: state.data.copyWith(date: newDate)));

    /// Update the [availability]
    final newAvailability = await schedulesRepository.checkAvailability(
      SchedulesConst.courtNames,
      newDate,
      SchedulesConst.maxDailySchedulesByCourt,
    );

    /// Update the [weatherInfo]
    final weatherData = await weatherRepository.getData(newDate);

    /// Check if the selected [courtName] is available
    var newCourtName = state.data.courtName;
    final selectedCourtIndex =
        SchedulesConst.courtNames.indexOf(state.data.courtName);
    if (selectedCourtIndex > -1 && !newAvailability[selectedCourtIndex]) {
      newCourtName = ''; // Reset the selection
    }

    final newStateData = SchedulesCreateScheduleData(
      availability: newAvailability,
      courtName: newCourtName,
      weatherInfo: weatherData,
      date: state.data.date,
      userName: state.data.userName,
    );

    emit(CreateScheduleSuccess(data: newStateData));
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
    await schedulesRepository.createSchedule(info);
    emit(CreateScheduleCreationSuccess(data: state.data.copyWith()));
  }
}
