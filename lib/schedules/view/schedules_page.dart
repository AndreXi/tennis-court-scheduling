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

  void openCreateScheduleDialog(BuildContext context) {
    showDialog<bool>(
      context: context,
      builder: (context) {
        return const CreateScheduleDialog();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.schedules_title),
        actions: [
          IconButton(
            onPressed: () => openCreateScheduleDialog(context),
            icon: const Icon(Icons.add),
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

            case SchedulesSuccess():
              return SizedBox(
                child: DaySchedulesList(items: state.items),
              );
          }

          return const SizedBox();
        },
      ),
    );
  }
}
