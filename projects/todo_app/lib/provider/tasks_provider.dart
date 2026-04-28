import 'package:flutter/material.dart';
import 'package:todo_app/database/todo_db.dart';
import 'package:hive_flutter/hive_flutter.dart';

class TasksProvider extends ChangeNotifier {
  final db = TodoDb();
  String selectedList = 'Default';
  bool showSearchBar = false;

  void changelist(String listName) {
    selectedList = listName;
    notifyListeners();
  }

  void toggleSearchBar() {
    showSearchBar = !showSearchBar;
    notifyListeners();
  }

  void addList(String listName) {
    db.addData(listName);
    notifyListeners();
  }

  void setupTasks() {
    final box = Hive.box('myBox');
    if (box.get("TODOLISTS") == null) {
      db.initilizeData();
      db.updataData();
    }
    db.loadData();
  }

  void addTask(String description, List<Object> details) {
    db.todoLists[selectedList][description] = details;
    db.updataData();
    notifyListeners();
  }

  void removeTask(String taskKey) {
    db.todoLists[selectedList].remove(taskKey);
    db.updataData();
    notifyListeners();
  }

  void updateStatus(String taskKey, bool status) {
    db.todoLists[selectedList][taskKey][0] = !status;
    db.updataData();
    notifyListeners();
  }
}
