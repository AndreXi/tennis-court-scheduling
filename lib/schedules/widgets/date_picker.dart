import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tennis_court_scheduling/l10n/l10n.dart';
import 'package:tennis_court_scheduling/schedules/schedules.dart';

class DatePicker extends StatelessWidget {
  const DatePicker({super.key});

  Future<void> _selectDate(BuildContext context, DateTime date) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: date,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != date) {
      if (!context.mounted) return;
      context.read<CreateScheduleCubit>().changeDate(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    final selectedDate = context.watch<CreateScheduleCubit>().state.data.date;
    final l10n = context.l10n;

    return TextFormField(
      decoration: InputDecoration(
        labelText: l10n.datePicker_label,
      ),
      controller: TextEditingController(
        text: DateFormat.yMd().format(selectedDate),
      ),
      onTap: () {
        _selectDate(context, selectedDate);
      },
      readOnly: true,
    );
  }
}
