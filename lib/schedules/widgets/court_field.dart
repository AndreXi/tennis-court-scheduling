import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tennis_court_scheduling/l10n/l10n.dart';
import 'package:tennis_court_scheduling/schedules/schedules.dart';

class CourtField extends StatelessWidget {
  const CourtField({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return FormField<String>(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return l10n.courtField_error;
        }
        return null;
      },
      builder: (field) {
        return BlocConsumer<CreateScheduleCubit, CreateScheduleState>(
          listener: (context, state) => field.didChange(state.data.courtName),
          builder: (context, state) {
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
                labelText: l10n.courtField_label,
                errorText: field.errorText,
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xfffefff3)),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xaafefff3)),
                ),
                errorBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xaac6ed2c)),
                ),
                focusedErrorBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xffc6ed2c)),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Center(
                  child: Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    // mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: buildCourtButtons(),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
