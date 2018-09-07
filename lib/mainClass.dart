import 'package:flutter/material.dart';
import 'yearsPage.dart';
import 'package:attendence_app/Database/database.dart';

class MainClass extends StatefulWidget {
  @override
  _MainClassState createState() => _MainClassState();
}

class _MainClassState extends State<MainClass> {
  DatabaseClient db;
  @override
  void initState() {
    super.initState();
    db = new DatabaseClient();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Choose year"),
        centerTitle: true,
      ),
      endDrawer: Drawer(
        child: ListView(
          children: <Widget>[
            ListTile(
              leading: CircleAvatar(child: Icon(Icons.delete)),
              title: Text("Empty Database"),
              onTap: (){
                db.deleteDb().whenComplete((){setState((){});});
              },
            ),
          ],
        ),
      ),
      body: YearsPage(),
    );
  }
}
