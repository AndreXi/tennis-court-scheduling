import 'package:flutter/material.dart';
import 'package:tennis_court_scheduling/schedules/schedules.dart';

class SchedulesCourtReserverNames extends StatelessWidget {
  const SchedulesCourtReserverNames({
    required this.names,
    required this.courtName,
    required this.date,
    super.key,
  });

  final String courtName;
  final String date;
  final List<String> names;

  void onPressedDelete(BuildContext context, ReservationInfo info) async {
    final wasConfirmed = await showDialog<bool>(
      context: context,
      builder: (context) {
        return NameConfirmDeleteDialog(info: info);
      },
    );
    // context.read<SchedulesCubit>().(info);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      decoration: const BoxDecoration(border: Border(left: BorderSide())),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: names
            .map(
              (name) => Expanded(
                child: Container(
                  height: 40,
                  decoration:
                      const BoxDecoration(border: Border(top: BorderSide())),
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(4),
                        child: Icon(Icons.person),
                      ),
                      Text(name),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: IconButton(
                          onPressed: () => onPressedDelete(
                            context,
                            ReservationInfo(
                              userName: name,
                              courtName: courtName,
                              date: date,
                            ),
                          ),
                          icon: const Icon(Icons.remove_circle),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
