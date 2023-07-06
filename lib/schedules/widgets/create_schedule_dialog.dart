import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tennis_court_scheduling/l10n/l10n.dart';
import 'package:tennis_court_scheduling/schedules/schedules.dart';

class CreateScheduleDialog extends StatelessWidget {
  const CreateScheduleDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final l10n = context.l10n;

    return Dialog(
      backgroundColor: const Color(0xFF339966),
      child: BlocProvider<CreateScheduleCubit>(
        create: (context) => CreateScheduleCubit(
          repository:
              SchedulesRepository(dataProvider: SchedulesDataProvider()),
        ),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Wrap(
                  runSpacing: 16,
                  children: [
                    Center(
                      child: Text(
                        l10n.createSchedule_title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 36,
                          color: Color(0xFFfefff3),
                        ),
                      ),
                    ),
                    const DatePicker(),
                    const NameField(),
                    const CourtField(),
                  ],
                ),
              ),
              // Spacer(),
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
      decoration: InputDecoration(
        labelText: l10n.createScheduleForm_nameInput_label,
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
      controller: TextEditingController(text: name),
      onChanged: (v) => context.read<CreateScheduleCubit>().changeName(v),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return l10n.createScheduleForm_nameInput_empty;
        }
        return null;
      },
    );
  }
}
