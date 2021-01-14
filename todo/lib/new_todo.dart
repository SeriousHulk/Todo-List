import 'package:flutter/material.dart';

class NewTodoView extends StatelessWidget {
  final Function addTaskCallback;

  NewTodoView(this.addTaskCallback);

  TextEditingController titleController;

  @override
  Widget build(BuildContext context) {
    String newTaskTitle;

    return Container(
      color: const Color(0xff757575),
      child: Container(
        padding: const EdgeInsets.all(25.0),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const Text(
              'Add Task',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.w700,
                color: Colors.lightBlueAccent,
              ),
            ),
            TextField(
              autofocus: true,
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
              controller: titleController,
              onChanged: (newText) {
                newTaskTitle = newText;
              },
              decoration: InputDecoration(labelText: 'Task'),
            ),
            RaisedButton(
              color: Colors.lightBlueAccent,
              child: Text(
                'Add',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                addTaskCallback(newTaskTitle);
                Navigator.pop(context);
              },
              elevation: 3.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10.0),
                      topRight: Radius.circular(10.0))),
            )
          ],
        ),
      ),
    );
  }
}
