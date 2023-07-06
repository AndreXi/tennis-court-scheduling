import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tennis_court_scheduling/l10n/l10n.dart';
import 'package:tennis_court_scheduling/schedules/schedules.dart';

class CourtField extends StatelessWidget {
  const CourtField({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final courtNames = SchedulesConst.courtNames;
    final data = context.watch<CreateScheduleCubit>().state.data;

    List<Widget> buildCourtButtons() {
      final r = <Widget>[];

      for (var i = 0; i < courtNames.length; i++) {
        final courtName = courtNames[i];
        final isAvailable = data.availability[i];

        r.add(
          ElevatedButton(
            style: (data.courtName == courtName)
                ? ElevatedButton.styleFrom(backgroundColor: Color(0xFFc6ed2c))
                : null,
            onPressed: isAvailable
                ? () {
                    context.read<CreateScheduleCubit>().changeCourt(courtName);
                  }
                : null,
            child: Column(
              children: [
                Text(courtName),
                Text(isAvailable ? 'Available' : 'Full'),
              ],
            ),
          ),
        );
      }

      return r;
    }

    return Row(
      children: buildCourtButtons(),
    );
  }
}
