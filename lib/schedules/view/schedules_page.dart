import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tennis_court_scheduling/l10n/l10n.dart';
import 'package:tennis_court_scheduling/schedules/schedules.dart';

@RoutePage()
class SchedulesPage extends StatelessWidget {
  const SchedulesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.schedules_title),
      ),
      body: FutureBuilder(
        future: Hive.openBox<List<SchedulesModel>>(SchedulesConst.boxName),
        builder: (context, snapshot) {
          final data = snapshot.data?.get('2023-7-5');

          print(snapshot.data?.toString());
          print(data);
          return Center(
            child: Column(
              children: [
                Text(snapshot.data?.keys.toString() ?? 'ne'),
                Text(snapshot.data.toString() ?? 'ne'),
              ],
            ),
          );
        },
      ),
    );
  }
}
