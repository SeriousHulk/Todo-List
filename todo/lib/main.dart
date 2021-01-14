import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './todo_main.dart';

void main() => runApp(Main());

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todo',
      home: Splash(),
    );
  }
}

class Splash extends StatefulWidget {
  @override
  SplashState createState() => new SplashState();
}

class SplashState extends State<Splash> {
  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool('seen') ?? false);

    if (_seen) {
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => new Home()));
    } else {
      await prefs.setBool('seen', true);
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => new IntroScreen()));
    }
  }

  @override
  void initState() {
    super.initState();
    // new Timer(new Duration(milliseconds: 200), () {
    checkFirstSeen();
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: Center(
      //   child: Text('Loading...'),
      // ),
    );
  }
}

class IntroScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Important Instructions:',
              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 30),
            ),
            SizedBox(height: 20),
            Text(
              '1. Press + icon button to add New Task',
              style: TextStyle(fontSize: 20, color: Colors.red),
            ),
            SizedBox(height: 10),
            Text(
              '2. Check Marks the task to mark as Completed',
              style: TextStyle(fontSize: 20, color: Colors.red),
            ),
            SizedBox(height: 10),
            Text(
              '3. Press and Hold Task For Few Second To Delete Task',
              style: TextStyle(fontSize: 20, color: Colors.red),
            ),
            SizedBox(height: 30),
            MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                color: Colors.orangeAccent,
                child: new Text(
                  'Gogo Home Page',
                  style: TextStyle(fontSize: 25),
                ),
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                      new MaterialPageRoute(builder: (context) => new Home()));
                }),
          ],
        ),
      ),
    );
  }
}
