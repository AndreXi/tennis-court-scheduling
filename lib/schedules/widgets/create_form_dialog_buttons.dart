import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tennis_court_scheduling/l10n/l10n.dart';
import 'package:tennis_court_scheduling/schedules/schedules.dart';

class DialogButtons extends StatelessWidget {
  const DialogButtons({required this.formKey, super.key});

  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    void onAccept() {
      final cubit = context.read<CreateScheduleCubit>();
      final isValid = formKey.currentState?.validate() ?? false;
      if (isValid) {
        cubit
            .createSchedule(
              ReservationInfo(
                userName: cubit.state.data.userName,
                courtName: cubit.state.data.courtName,
                date: DateFormat('yyyy-MM-dd').format(cubit.state.data.date),
              ),
            )
            .then((_) => Navigator.of(context).pop(true));
      }
    }

    void onCancel() {
      Navigator.of(context).pop(false);
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: TextButton(
              onPressed: onCancel,
              style: TextButton.styleFrom(foregroundColor: Colors.black),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  l10n.createSchedule_cancel,
                  style: const TextStyle(color: Colors.black87),
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            flex: 2,
            child: ElevatedButton.icon(
              icon: BlocBuilder<CreateScheduleCubit, CreateScheduleState>(
                builder: (context, state) {
                  switch (state) {
                    case CreateScheduleCreationLoading():
                      return const CircularProgressIndicator();
                    default:
                      return const Icon(Icons.save);
                  }
                },
              ),
              onPressed: onAccept,
              label: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Text(l10n.createSchedule_confirm),
              ),
            ),
          )
        ],
      ),
    );
  }
}
