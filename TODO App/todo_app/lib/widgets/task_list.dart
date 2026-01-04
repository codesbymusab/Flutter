import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_app/database/todo_db.dart';
import 'package:todo_app/widgets/task_card.dart';

class TaskCardsList extends StatefulWidget {
  final String selectedList;
  final TodoDb db;
  const TaskCardsList({
    super.key,
    required this.selectedList,
    required this.db,
  });

  @override
  State<TaskCardsList> createState() => _TaskCardsListState();
}

class _TaskCardsListState extends State<TaskCardsList> {
  @override
  Widget build(BuildContext context) {
    Map<dynamic, dynamic> selectedList =
        widget.db.todoLists[widget.selectedList];
    return Expanded(
      child: widget.selectedList.isEmpty
          ? Center(
              child: Text(
                'List is Empty',
                style: Theme.of(context).textTheme.displayMedium,
              ),
            )
          : ListView.builder(
              itemCount: selectedList.length,
              itemBuilder: (context, listIndex) {
                final String description = selectedList.keys
                    .toList()[listIndex];

                final bool status = selectedList.values.toList()[listIndex][0];

                final String time = selectedList.values.toList()[listIndex][1];

                return Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Slidable(
                    endActionPane: ActionPane(
                      motion: StretchMotion(),
                      children: [
                        SlidableAction(
                          onPressed: (context) {
                            setState(() {
                              selectedList.remove(description);
                              widget.db.updataData();
                            });
                          },
                          icon: Icons.delete,
                          backgroundColor: Colors.red,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ],
                    ),
                    child: TaskCard(
                      description: description,
                      status: status,
                      dueDateTime: time,
                      onChanged: (value) {
                        setState(() {
                          selectedList[description][0] = !status;
                          widget.db.updataData();
                        });
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }
}
