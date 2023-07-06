import 'package:flutter/material.dart';

class CreateScheduleDialog extends StatelessWidget {
  const CreateScheduleDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog.fullscreen(
      backgroundColor: Colors.green.shade500,
      child: Column(
        children: [
          Spacer(),
          DialogButtons(),
        ],
      ),
    );
  }
}

class DialogButtons extends StatelessWidget {
  const DialogButtons({super.key});

  void onAccept() {}

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
