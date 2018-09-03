import 'package:flutter/material.dart';
import 'yearsPage.dart';

class MainClass extends StatefulWidget {
  @override
  _MainClassState createState() => _MainClassState();
}

class _MainClassState extends State<MainClass> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Choose year"),
        centerTitle: true,
      ),
      endDrawer: Drawer(

      ),
      body: YearsPage(),
    );
  }
}
