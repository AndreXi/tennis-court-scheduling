import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
    return SingleChildScrollView(
      child: Column(
        children: _buildItems(),
      ),
    );
  }
}

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
      r.add(
        Column(
          children: [Text(courtName), ...names.map((e) => Text(e))],
        ),
      );
    }
    return r;
  }

  @override
  Widget build(BuildContext context) {
    final dateTime = DateTime.parse(date);

    return Card(
      clipBehavior: Clip.hardEdge,
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
    );
  }
}
