import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tennis_court_scheduling/schedules/schedules.dart';
import 'package:tennis_court_scheduling/weather/weather.dart';

class DaySchedulesItem extends StatelessWidget {
  const DaySchedulesItem({
    required this.date,
    required this.courtSchedulingMap,
    super.key,
  });

  final String date;
  final SchedulesBoxType courtSchedulingMap;

  List<Widget> _buildContent() {
    final r = <Widget>[];
    for (final courtName in courtSchedulingMap.keys) {
      final names = courtSchedulingMap[courtName] ?? [];
      final maxDaily = SchedulesConst.maxDailySchedulesByCourt;
      r.add(
        Container(
          constraints: const BoxConstraints(maxHeight: 40 * 3),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SchedulesCourtInfo(
                  courtName: courtName,
                  maxDaily: maxDaily,
                  names: names,
                ),
              ),
              Expanded(
                child: SchedulesCourtReserverNames(
                  names: names,
                  courtName: courtName,
                  date: date,
                ),
              )
            ],
          ),
        ),
      );
    }
    return r;
  }

  @override
  Widget build(BuildContext context) {
    final dateTime = DateTime.parse(date);

    return Container(
      width: 500,
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
      child: Card(
        clipBehavior: Clip.hardEdge,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(),
        ),
        child: Column(
          children: [
            Container(
              constraints: const BoxConstraints(minHeight: 48),
              decoration: BoxDecoration(color: Theme.of(context).primaryColor),
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 7,
                    child: Text(
                      DateFormat.yMEd().format(dateTime),
                      style: TextStyle(
                        color: Theme.of(context).cardColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 3,
                    child: BlocBuilder<SchedulesCubit, SchedulesState>(
                      builder: (context, state) {
                        return WeatherForecast(
                          day: state.data.weatherForecasts[date]
                              ?.precipitationProbabilityDay,
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
            ..._buildContent(),
          ],
        ),
      ),
    );
  }
}
