import 'package:hive_flutter/hive_flutter.dart';

class TodoDb {
  Map<dynamic, dynamic> todoLists = {};

  List<String> menuEntries = [];
  final _box = Hive.box('myBox');

  void initilizeData() {
    menuEntries = ['Default', 'Home', 'Work'];
    List<Object> taskDetails = [false, ''];

    todoLists['Default'] = {
      'Clean Trash': taskDetails,
      'Change Curtain': taskDetails,
      'Go to Doctor': taskDetails,
    };
    todoLists['Home'] = {};
    todoLists['Work'] = {};
  }

  void loadData() {
    todoLists = _box.get("TODOLISTS");
    menuEntries = _box.get("LISTNAMES");
  }

  void addData(String name) {
    menuEntries.add(name);
    todoLists[name] = {};
    updataData();
  }

  void updataData() {
    _box.put("TODOLISTS", todoLists);
    _box.put("LISTNAMES", menuEntries);
  }

  Map<String, dynamic> searchData(String keyword) {
    Map<String, dynamic> searchList = {};
    todoLists.forEach((listKey, list) {
      for (int i = 0; i < list.length; i++) {
        if (list.isNotEmpty &&
            (list.keys.toList()[i].toLowerCase().contains(
                  keyword.toLowerCase(),
                ) ||
                list.values.toList()[i][1].toString().contains(
                  keyword.toLowerCase(),
                ))) {
          searchList[list.keys.toList()[i]] = list.values.toList()[i];
        }
      }
    });
    return searchList;
  }
}
