import 'package:flutter/material.dart';
import 'package:tennis_court_scheduling/schedules/schedules.dart';

class DaySchedulesList extends StatelessWidget {
  const DaySchedulesList({required this.items, super.key});

  final Map<String, SchedulesBoxType> items;

  List<Widget> _buildItems() {
    final r = <Widget>[];
    for (final date in items.keys) {
      r.add(
        DaySchedulesItem(date: date, courtSchedulingMap: items[date] ?? {}),
      );
    }
    return r;
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: SingleChildScrollView(
        child: Column(
          children: _buildItems(),
        ),
      ),
    );
  }
}
