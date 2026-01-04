import 'package:flutter/material.dart';
import 'package:todo_app/widgets/task_card.dart';

class SearchTasksList extends StatelessWidget {
  final Map<dynamic, dynamic> searchList;

  const SearchTasksList({super.key, required this.searchList});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: searchList.isEmpty
          ? Center(
              child: Text(
                'No Tasks Found',
                style: Theme.of(context).textTheme.displayMedium,
              ),
            )
          : ListView.builder(
              itemCount: searchList.length,
              itemBuilder: (context, listIndex) {
                final String description = searchList.keys.toList()[listIndex];

                final bool status = searchList.values.toList()[listIndex][0];

                final String time = searchList.values.toList()[listIndex][1];

                return Padding(
                  padding: const EdgeInsets.all(15.0),

                  child: TaskCard(
                    description: description,
                    status: status,
                    dueDateTime: time,
                    onChanged: (value) {},
                  ),
                );
              },
            ),
    );
  }
}
