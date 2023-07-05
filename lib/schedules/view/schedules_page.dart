import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tennis_court_scheduling/l10n/l10n.dart';
import 'package:tennis_court_scheduling/schedules/schedules.dart';

@RoutePage()
class SchedulesPage extends StatelessWidget {
  SchedulesPage({super.key});

  final schedulesRepository =
      SchedulesRepository(dataProvider: SchedulesDataProvider());

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SchedulesCubit(repository: schedulesRepository),
      child: const SchedulesView(),
    );
  }
}

class SchedulesView extends StatelessWidget {
  const SchedulesView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.schedules_title),
      ),
    );
  }
}
