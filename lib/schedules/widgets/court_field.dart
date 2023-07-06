import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tennis_court_scheduling/l10n/l10n.dart';
import 'package:tennis_court_scheduling/schedules/schedules.dart';

class CourtField extends StatelessWidget {
  const CourtField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateScheduleCubit, CreateScheduleState>(
      builder: (context, state) {
        return FormField<String>(
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'You must select a court to schedule';
            }
            return null;
          },
          builder: (field) {
            final l10n = context.l10n;
            final courtNames = SchedulesConst.courtNames;
            final data = state.data;

            List<Widget> buildCourtButtons() {
              final r = <Widget>[];
              for (var i = 0; i < courtNames.length; i++) {
                final courtName = courtNames[i];
                final isAvailable = data.availability[i];
                r.add(
                  ElevatedButton(
                    style: (data.courtName == courtName)
                        ? ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFc6ed2c),
                          )
                        : null,
                    onPressed: isAvailable
                        ? () {
                            context
                                .read<CreateScheduleCubit>()
                                .changeCourt(courtName);
                            field.didChange(courtName);
                          }
                        : null,
                    child: Column(
                      children: [
                        Text(courtName),
                        Text(
                          isAvailable
                              ? l10n.courtField_available
                              : l10n.courtField_full,
                        ),
                      ],
                    ),
                  ),
                );
              }
              return r;
            }

            return InputDecorator(
              decoration: InputDecoration(
                labelText: 'Courts',
                errorText: field.errorText,
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: buildCourtButtons(),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
