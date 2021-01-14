import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class Task {
  String name;
  bool isDone;

  Task({
    @required this.name,
    this.isDone = false,
  });

  Task.fromMap(Map map)
      : this.name = map['name'],
        this.isDone = map['isDone'];

  Map toMap() {
    return {
      'name': this.name,
      'isDone': this.isDone,
    };
  }

}

class Backend {
  List<Task> list = [];

  SharedPreferences sharedPreferences;
  Future<List<Task>> loadSharedPreferencesAndData() async {
    sharedPreferences = await SharedPreferences.getInstance();
    list = loadData();
    return list;
  }

  void addTask(Task item) {
    list.add(item);
    saveData();
  }

  void toggleDone(Task item) {
    item.isDone = !item.isDone;
    saveData();
  }
  
  void removeItem(Task item) {
    list.remove(item);
    saveData();
  }

  List<Task> loadData() {
    List<String> listString = sharedPreferences.getStringList('list');
    List<Task> list = [];
    if (listString != null) {
      list = listString.map((item) => Task.fromMap(json.decode(item))).toList();
    }
    return list;
  }
  
  void saveData() {
    List<String> stringList = list.map((item) => json.encode(item.toMap())).toList();
    sharedPreferences.setStringList('list', stringList);
  }

  
}
