import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tennis_court_scheduling/l10n/l10n.dart';
import 'package:tennis_court_scheduling/schedules/schedules.dart';

class CreateScheduleDialog extends StatelessWidget {
  const CreateScheduleDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    return Dialog.fullscreen(
      backgroundColor: Colors.green.shade500,
      child: BlocProvider<CreateScheduleCubit>(
        create: (context) => CreateScheduleCubit(
          repository:
              SchedulesRepository(dataProvider: SchedulesDataProvider()),
        ),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              DatePicker(),
              NameField(),
              CourtField(),
              Spacer(),
              DialogButtons(
                formKey: formKey,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NameField extends StatelessWidget {
  const NameField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final name = context.read<CreateScheduleCubit>().state.data.userName;
    final l10n = context.l10n;

    return TextFormField(
      decoration:
          InputDecoration(labelText: l10n.createScheduleForm_nameInput_label),
      controller: TextEditingController(text: name),
      onChanged: (v) => context.read<CreateScheduleCubit>().changeName(v),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return l10n.createScheduleForm_nameInput_empty;
        }
      },
    );
  }
}
