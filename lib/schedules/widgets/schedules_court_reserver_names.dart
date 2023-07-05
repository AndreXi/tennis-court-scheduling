import 'package:flutter/material.dart';

class SchedulesCourtReserverNames extends StatelessWidget {
  const SchedulesCourtReserverNames({
    required this.names,
    super.key,
  });

  final List<String> names;

  void onPressedDelete() {
    // TODO(AndreXi): Implement it.
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      decoration: const BoxDecoration(border: Border(left: BorderSide())),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: names
            .map(
              (name) => Expanded(
                child: Container(
                  height: 40,
                  decoration:
                      const BoxDecoration(border: Border(top: BorderSide())),
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(4),
                        child: Icon(Icons.person),
                      ),
                      Text(name),
                      const Spacer(),
                      IconButton(
                        onPressed: onPressedDelete,
                        icon: const Icon(Icons.remove_circle),
                      )
                    ],
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
