import 'package:flutter/material.dart';

import './task.dart';
import './new_todo.dart';
import 'about_dev.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Task> list = [];

  Backend backend = Backend();

  void call() async {
    List<Task> list1 = await backend.loadSharedPreferencesAndData();
    if (list1 != null) {
      setState(() {
        list.addAll(list1);
      });
    }
  }

  @override
  void initState() {
    call();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightBlueAccent,
        child: Icon(Icons.add, size: 40, color: Colors.white),
        splashColor: Colors.red,
        onPressed: () {
          showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (ctx) => SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: NewTodoView((newTaskTitle) {
                        setState(() {
                          Task t = Task(name: newTaskTitle);
                          list.add(t);
                          backend.addTask(t);
                        });
                      }),
                    ),
                  ));
        },
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
              top: 60.0,
              left: 30.0,
              right: 30.0,
              bottom: 30.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ClipOval(
                  child: Material(
                    elevation: 6,
                    color: Colors.white, // button color
                    child: InkWell(
                      radius: 30.0,
                      splashColor: Colors.red, // inkwell color
                      child: SizedBox(
                          width: 56,
                          height: 56,
                          child: Icon(
                            Icons.list,
                            size: 35.0,
                            color: Colors.lightBlueAccent,
                          )),
                      onTap: () => Navigator.of(context).push(PageRouteBuilder(
                          opaque: false,
                          pageBuilder: (_, __, ___) => AboutDev())),
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
                Text(
                  'Todo',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 50,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Text('${list.length} Tasks',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    )),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)),
              ),
              child: list.length == 0
                  ? Center(
                      child: Text(
                        'No task is added',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black38,
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: list.length,
                      itemBuilder: (context, index) {
                        var item = list[index];
                        return ListTile(
                          onLongPress: () {
                            setState(() {
                              backend.removeItem(item);
                              list.remove(item);
                            });
                          },
                          title: Text(
                            item.name,
                            style: TextStyle(
                              fontSize: 18,
                              decoration: item.isDone
                                  ? TextDecoration.lineThrough
                                  : null,
                            ),
                          ),
                          trailing: Checkbox(
                            value: item.isDone,
                            onChanged: (checkboxState) {
                              setState(() {
                                backend.toggleDone(item);
                              });
                            },
                          ),
                        );
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }
}