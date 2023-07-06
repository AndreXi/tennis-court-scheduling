import 'package:flutter/material.dart';
import 'package:tennis_court_scheduling/l10n/l10n.dart';
import 'package:tennis_court_scheduling/schedules/schedules.dart';

class NameConfirmDeleteDialog extends StatelessWidget {
  const NameConfirmDeleteDialog({required this.info, super.key});

  final ReservationInfo info;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return AlertDialog(
      title: Text(
        l10n.nameConfirmDeleteDialog_title,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
      content: Text(
        l10n.nameConfirmDeleteDialog_content(info.userName),
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text(
            l10n.nameConfirmDeleteDialog_cancel,
            style: const TextStyle(
              color: Color(0xfffefff3),
            ),
          ),
          onPressed: () {
            Navigator.of(context).pop(false);
          },
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xff993300),
          ),
          child: Text(
            l10n.nameConfirmDeleteDialog_confirm,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
          onPressed: () {
            Navigator.of(context).pop(true);
          },
        ),
      ],
    );
  }
}
