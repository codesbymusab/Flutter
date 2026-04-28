import 'package:flutter/material.dart';
import 'package:todo_app/database/todo_db.dart';

class TaskCard extends StatefulWidget {
  final String description;
  final bool status;
  final String dueDateTime;
  final ValueChanged onChanged;
  const TaskCard({
    super.key,
    required this.description,
    required this.status,
    required this.dueDateTime,
    required this.onChanged,
  });

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  final db = TodoDb();

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Checkbox(
              activeColor: const Color.fromARGB(176, 0, 0, 0),
              value: widget.status,
              onChanged: widget.onChanged,
            ),
            Column(
              spacing: 4,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.description,
                  style: widget.status
                      ? Theme.of(context).textTheme.bodySmall
                      : Theme.of(context).textTheme.displayMedium,
                ),
                if (widget.dueDateTime.isNotEmpty) ...{
                  Text(
                    widget.dueDateTime,
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                },
              ],
            ),
          ],
        ),
      ),
    );
  }
}
