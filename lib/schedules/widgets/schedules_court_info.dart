import 'package:flutter/material.dart';

class SchedulesCourtInfo extends StatelessWidget {
  const SchedulesCourtInfo({
    required this.courtName,
    required this.maxDaily,
    required this.names,
    super.key,
  });

  final String courtName;
  final int maxDaily;
  final List<String> names;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 24),
      decoration: const BoxDecoration(border: Border(top: BorderSide())),
      child: Padding(
        padding: const EdgeInsets.only(top: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              courtName,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  '${maxDaily - names.length}/',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: maxDaily - names.length == 0
                        ? Colors.red
                        : Colors.green,
                  ),
                ),
                Text(
                  '$maxDaily',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: maxDaily - names.length == 0
                        ? Colors.red
                        : Colors.green,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
