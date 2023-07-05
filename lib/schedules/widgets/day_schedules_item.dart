import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tennis_court_scheduling/schedules/schedules.dart';

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
          decoration: const BoxDecoration(border: Border(top: BorderSide())),
          // padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SchedulesCourtInfo(
                courtName: courtName,
                maxDaily: maxDaily,
                names: names,
              ),
              SchedulesCourtReserverNames(names: names)
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

    return Padding(
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
              constraints: const BoxConstraints(minHeight: 32),
              decoration: BoxDecoration(color: Theme.of(context).primaryColor),
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    DateFormat.yMEd().format(dateTime),
                    style: TextStyle(
                      color: Theme.of(context).cardColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    width: 100,
                    height: 32,
                    child: Placeholder(),
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

class SchedulesCourtReserverNames extends StatelessWidget {
  const SchedulesCourtReserverNames({
    required this.names,
    super.key,
  });

  final List<String> names;

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 80,
      width: 200,
      decoration: BoxDecoration(border: Border(left: BorderSide())),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: names
            .map((e) => Container(
                  height: 35,
                  child: Row(
                    children: [
                      const Icon(Icons.person),
                      Text(e),
                    ],
                  ),
                ))
            .toList(),
      ),
    );
  }
}

class SchedulesCourtInfo extends StatelessWidget {
  const SchedulesCourtInfo({
    required this.courtName,
    required this.maxDaily,
    required this.names,
    super.key,
  });

  final String courtName;
  final int maxDaily;
  final List<String> names;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(courtName),
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              '${maxDaily - names.length}/',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: maxDaily - names.length == 0 ? Colors.red : Colors.green,
              ),
            ),
            Text(
              '$maxDaily',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: maxDaily - names.length == 0 ? Colors.red : Colors.green,
              ),
            ),
          ],
        )
      ],
    );
  }
}
