import 'package:flutter/material.dart';
import 'package:attendence_app/Database/database.dart';

class YearsPage extends StatefulWidget {
  @override
  _YearsPageState createState() => _YearsPageState();
}

class _YearsPageState extends State<YearsPage> {
  DatabaseClient db;

//  List yearsList = [];

  @override
  void initState() {
    super.initState();
    db = new DatabaseClient();
    db.create().then((dynamic) {
      updateYears();
    });
  }

  updateYears() {
    db.getYears().whenComplete(() {
      setState(() {});
    });
  }

  addYear(String text) {
    db.addYears(text).whenComplete(() {
      updateYears();
    });
  }

  var count = 0;

  @override
  Widget build(BuildContext context) {
    print("YearsPage Updated " + count.toString() + " times");
    count++;
    print("List = " + db.yearsList.toString());
    var th = Theme.of(context);
    return ListView.builder(
        itemCount: db.yearsList.length + 1,
        // i am adding a top tile to add new year
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return ListTile(
                leading: CircleAvatar(child: Icon(Icons.add)),
                title: Text("Add year"),
                onTap: () {
                  addYear("SecondYear");
//                db.deleteDb();
                });
          }
          return AnimatedContainer(
            padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
            duration: Duration(seconds: 1),
            child: ListTile(
              leading: new CircleAvatar(
                child: Text(
                  (index).toString(),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.fade,
                  textDirection: TextDirection.ltr,
                  textScaleFactor: 1.5,
                  style: TextStyle(
                    color: (th.brightness == Brightness.dark)
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
                backgroundColor: Colors.transparent,
//                backgroundColor: th.primaryColor.withOpacity(0.5),
              ),
              title: Text(db.yearsList[index - 1]),
              trailing: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  IconButton(
                      icon: Icon(Icons.mode_edit),
                      onPressed: () {
//                        db.
//                        updateYears();
                      }),
                  IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        db.removeYear(db.yearsList[index - 1]);
                        updateYears();
                      }),
                ],
              ),
            ),
          );
        });
  }
}
