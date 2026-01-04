import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/add_task_page.dart';
import 'package:todo_app/provider/tasks_provider.dart';
import 'package:todo_app/widgets/search_task_list.dart';
import 'package:todo_app/widgets/quick_task.dart';
import 'package:todo_app/widgets/round_elevated_button.dart';
import 'package:todo_app/widgets/select_list_menu.dart';
import 'package:todo_app/widgets/task_list.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final TextEditingController quickTaskController = TextEditingController();
  final TextEditingController taskController = TextEditingController();
  final TextEditingController searchController = TextEditingController();

  void onPressedAdd() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddTaskPage()),
    );
  }

  void quickTaskAdd() {
    if (quickTaskController.text.isNotEmpty) {
      List<Object> taskDetails = [false, ''];

      context.read<TasksProvider>().addTask(
        quickTaskController.text,
        taskDetails,
      );
      quickTaskController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    context.read<TasksProvider>().setupTasks();
    final db = context.watch<TasksProvider>().db;

    void quickTaskAdd() {
      if (quickTaskController.text.isNotEmpty) {
        List<Object> taskDetails = [false, ''];

        context.read<TasksProvider>().addTask(
          quickTaskController.text,
          taskDetails,
        );
        quickTaskController.clear();
      }
    }

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      appBar: context.read<TasksProvider>().showSearchBar
          ? AppBar(
              backgroundColor: Theme.of(context).colorScheme.primary,
              leadingWidth: double.infinity,
              leading: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      searchController.clear();
                      context.read<TasksProvider>().toggleSearchBar();
                    },
                    icon: Icon(Icons.arrow_back),
                  ),
                  Expanded(
                    child: TextField(
                      controller: searchController,
                      cursorColor: Colors.black,
                      showCursor: true,
                      decoration: InputDecoration(
                        hintText: 'Search',
                        prefixIcon: Icon(Icons.search),
                        focusedBorder: UnderlineInputBorder(),
                      ),
                      onChanged: (value) {
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
            )
          : AppBar(
              leadingWidth: 190,
              leading: Row(
                spacing: 5,
                children: [
                  Stack(
                    children: [
                      Icon(
                        Icons.circle,
                        size: 35,
                        color: const Color.fromARGB(215, 0, 0, 0),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Icon(
                          Icons.done_rounded,
                          color: Theme.of(context).colorScheme.secondary,
                          size: 26,
                        ),
                      ),
                    ],
                  ),

                  SelectListMenu(
                    label: '',

                    color: Theme.of(context).colorScheme.primary,
                    size: 140,
                  ),
                ],
              ),
              title: Text(
                'To Do',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              centerTitle: MediaQuery.sizeOf(context).width > 500
                  ? true
                  : false,
              backgroundColor: Theme.of(context).colorScheme.primary,
              actions: [
                IconButton(
                  onPressed: () {
                    context.read<TasksProvider>().toggleSearchBar();
                  },
                  icon: Icon(
                    Icons.search,
                    color: const Color.fromARGB(215, 0, 0, 0),
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.more_vert_rounded),
                  color: const Color.fromARGB(215, 0, 0, 0),
                ),
              ],
            ),
      body: Column(
        children: [
          if (context.read<TasksProvider>().showSearchBar) ...{
            SearchTasksList(searchList: db.searchData(searchController.text)),
          } else ...{
            Expanded(
              child:
                  db
                      .todoLists[context.read<TasksProvider>().selectedList]!
                      .isEmpty
                  ? Center(
                      child: Text(
                        'List is Empty',
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                    )
                  : TaskCardsList(
                      selectedList: context.read<TasksProvider>().selectedList,
                      db: db,
                    ),
            ),
          },

          RoundElevatedButton(icon: Icons.add, onPressed: onPressedAdd),
          QuickTaskAdder(
            onPressed: quickTaskAdd,
            quickTaskController: quickTaskController,
          ),
        ],
      ),
    );
  }
}
