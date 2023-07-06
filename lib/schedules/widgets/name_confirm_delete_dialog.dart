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
      title: Text(l10n.nameConfirmDeleteDialog_title),
      content: Text(l10n.nameConfirmDeleteDialog_content(info.userName)),
      actions: <Widget>[
        TextButton(
          child: Text(l10n.nameConfirmDeleteDialog_cancel),
          onPressed: () {
            Navigator.of(context).pop(false);
          },
        ),
        TextButton(
          child: Text(l10n.nameConfirmDeleteDialog_confirm),
          onPressed: () {
            Navigator.of(context).pop(true);
          },
        ),
      ],
    );
  }
}
