import 'package:flutter/material.dart';
import 'package:tennis_court_scheduling/l10n/l10n.dart';

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
    final l10n = context.l10n;
    final color = maxDaily - names.length == 0
        ? const Color(0xFF993300)
        : const Color(0xFF339966);

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
                Text(l10n.schedulesCourtInfo_freeLabel),
                const Spacer(),
                Text(
                  '${maxDaily - names.length}/',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
                Text(
                  '$maxDaily',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
                const SizedBox(width: 16),
              ],
            )
          ],
        ),
      ),
    );
  }
}
