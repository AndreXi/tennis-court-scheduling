import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:tennis_court_scheduling/l10n/l10n.dart';
import 'package:tennis_court_scheduling/schedules/schedules.dart';
import 'package:tennis_court_scheduling/weather/weather.dart';

@RoutePage()
class SchedulesPage extends StatelessWidget {
  const SchedulesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SchedulesCubit(
        schedulesRepository: GetIt.I<SchedulesRepository>(),
        weatherRepository: GetIt.I<WeatherRepository>(),
      ),
      child: const SchedulesView(),
    );
  }
}

class SchedulesView extends StatelessWidget {
  const SchedulesView({
    super.key,
  });

  void openCreateScheduleDialog(BuildContext context) {
    showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return const CreateScheduleDialog();
      },
    ).then((value) {
      if (value ?? false) {
        context.read<SchedulesCubit>().fetchData();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.schedules_title),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: ElevatedButton.icon(
              onPressed: () => openCreateScheduleDialog(context),
              icon: const Icon(Icons.add),
              label: Text(l10n.schedulesPage_createButtonLabel),
            ),
          )
        ],
      ),
      body: BlocBuilder<SchedulesCubit, SchedulesState>(
        builder: (context, state) {
          switch (state) {
            case SchedulesFetch():
              context.read<SchedulesCubit>().fetchData();

            case SchedulesFetching():
              return const Center(
                child: CircularProgressIndicator(),
              );

            case SchedulesEmpty():
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'There are no schedules right now',
                      style: TextStyle(color: Colors.white),
                    ),
                    ElevatedButton.icon(
                      onPressed: () => openCreateScheduleDialog(context),
                      icon: const Icon(Icons.add),
                      label: Text(l10n.schedulesPage_createButtonLabel),
                    ),
                  ],
                ),
              );

            default:
          }
          return DaySchedulesList(items: state.data.schedules);
        },
      ),
    );
  }
}
