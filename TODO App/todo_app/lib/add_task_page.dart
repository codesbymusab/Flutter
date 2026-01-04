import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/main_page.dart';
import 'package:todo_app/provider/tasks_provider.dart';
import 'package:todo_app/widgets/round_elevated_button.dart';
import 'package:todo_app/widgets/select_list_menu.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final TextEditingController taskController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  String selectedList = 'Default';

  DateTime? pickedDate;
  TimeOfDay? pickedTime;
  String taskDetails = '';

  void onSelected(value) {
    context.read<TasksProvider>().changelist(value);
  }

  InputDecoration textFieldsDecor(String label, String hintText) {
    return InputDecoration(
      filled: true,
      fillColor: const Color.fromARGB(255, 245, 240, 220),
      label: Text(label),
      labelStyle: Theme.of(context).textTheme.displayMedium,
      hintText: hintText,
      border: UnderlineInputBorder(),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        leading: IconButton(
          onPressed: () {
            if (taskController.text.isNotEmpty) {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text(
                      'Are you Sure',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    content: Text(
                      'Quit without saving?',
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'CANCEL',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          taskController.clear();
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                        child: Text('YES', style: TextStyle(color: Colors.red)),
                      ),
                    ],
                  );
                },
              );
            } else {
              Navigator.pop(context);
            }
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: Text('New Task', style: Theme.of(context).textTheme.titleMedium),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              spacing: 5,
              children: [
                Flexible(
                  child: TextField(
                    controller: taskController,
                    decoration: textFieldsDecor(
                      'What is to be done?',
                      'Enter Task Here',
                    ),
                  ),
                ),
                Icon(Icons.keyboard_alt_rounded),
              ],
            ),
            Row(
              spacing: 5,
              children: [
                Flexible(
                  child: TextField(
                    controller: dateController,
                    decoration: textFieldsDecor('Due Date', 'Date not set'),
                    onTap: () async {
                      pickedDate = await showDatePicker(
                        context: context,
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2100),
                      );
                      setState(() {
                        if (pickedDate != null) {
                          dateController.text = DateFormat(
                            DateFormat.YEAR_ABBR_MONTH_WEEKDAY_DAY,
                          ).format(pickedDate!).toString();
                          taskDetails = dateController.text;
                        }
                      });
                    },
                  ),
                ),

                Icon(Icons.calendar_month),
              ],
            ),

            Row(
              spacing: 5,
              children: [
                Flexible(
                  child: TextField(
                    controller: timeController,
                    decoration: textFieldsDecor('Due Time', 'Time not set'),
                    onTap: () async {
                      pickedTime = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      setState(() {
                        if (pickedTime != null) {
                          timeController.text = pickedTime!.format(context);

                          taskDetails =
                              '${dateController.text} ${timeController.text}';
                        }
                      });
                    },
                  ),
                ),

                Icon(Icons.timer),
              ],
            ),

            Row(
              spacing: 5,
              children: [
                Flexible(
                  child: SelectListMenu(
                    label: 'Add to List',
                    color: const Color.fromARGB(255, 245, 240, 220),
                    size: 300,
                  ),
                ),
                Icon(Icons.view_list_rounded),
                IconButton(
                  tooltip: 'Add new list',
                  onPressed: () {
                    final TextEditingController addListController =
                        TextEditingController();
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text(
                            'New List',
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          content: TextField(
                            controller: addListController,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(8),
                              hintText: 'Enter List Name',
                              filled: true,
                              fillColor: const Color.fromARGB(
                                255,
                                245,
                                240,
                                220,
                              ),
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                'CANCEL',
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                if (addListController.text.isNotEmpty) {
                                  context.read<TasksProvider>().addList(
                                    addListController.text,
                                  );
                                  Navigator.pop(context);
                                }
                              },
                              child: Text(
                                'ADD',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  icon: Icon(Icons.my_library_add, color: Colors.black),
                ),
              ],
            ),
            SizedBox(height: 150),

            RoundElevatedButton(
              icon: Icons.done,
              onPressed: () {
                List<Object> details = [false, taskDetails];

                context.read<TasksProvider>().addTask(
                  taskController.text,
                  details,
                );
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MainPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
