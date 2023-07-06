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
          autovalidateMode: AutovalidateMode.onUserInteraction,
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
    final name = context.watch<CreateScheduleCubit>().state.data.userName;
    final l10n = context.l10n;

    return TextFormField(
      decoration:
          InputDecoration(labelText: l10n.createScheduleForm_nameInput_label),
      controller: TextEditingController(text: name),
      onEditingComplete: () =>
          context.read<CreateScheduleCubit>().changeName(name),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return l10n.createScheduleForm_nameInput_empty;
        }
      },
    );
  }
}

class DialogButtons extends StatelessWidget {
  const DialogButtons({required this.formKey, super.key});

  final GlobalKey<FormState> formKey;

  void onAccept() {
    formKey.currentState?.validate();
  }

  void onCancel(BuildContext context) {
    Navigator.of(context).pop(false);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: TextButton(
              onPressed: () => onCancel(context),
              style: TextButton.styleFrom(foregroundColor: Colors.black),
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  'Cancel',
                  style: TextStyle(color: Colors.black87),
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            flex: 2,
            child: ElevatedButton.icon(
              icon: const Icon(Icons.save),
              onPressed: () => onAccept(),
              label: const Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Text('Confirm'),
              ),
            ),
          )
        ],
      ),
    );
  }
}
