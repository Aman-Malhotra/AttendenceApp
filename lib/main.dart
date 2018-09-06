import 'package:attendence_app/Database/database.dart';
import 'package:flutter/material.dart';
import 'mainClass.dart';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState(){
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Attendence App",
      theme: ThemeData(
        primaryColor: Colors.amber,
        accentColor: Colors.amberAccent,
        brightness: Brightness.dark,
      ),
      home: MainClass(),
    );
  }
}

