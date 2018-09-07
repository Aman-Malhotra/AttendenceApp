import 'package:flutter/material.dart';
import 'package:attendence_app/Database/database.dart';
import 'package:flushbar/flushbar.dart';

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
    Flushbar(
      message: "",
      duration: Duration(seconds: 2),
      flushbarPosition: FlushbarPosition.BOTTOM,
      backgroundColor: Theme.of(context).primaryColor,
    )
      ..titleText = Text(
        "Added "+text,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 17.0,
          fontWeight: FontWeight.bold,
        ),
      )
      ..icon=Icon(Icons.text_format)
      ..show(context);
  }

  var count = 0;
  TextEditingController controller = new TextEditingController();

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
              title: TextFormField(
                controller: controller,
                enabled: true,
//                  inputFormatters: ,
                textAlign: TextAlign.left,
                decoration: InputDecoration(
                  hintText: "Enter the year to add",
                  border: OutlineInputBorder(
                      borderRadius:
                          const BorderRadius.all(const Radius.circular(6.0))),
                ),
              ),
              trailing: OutlineButton.icon(
                label: Text("Add"),
                icon: Icon(Icons.add),
                onPressed: () {
                  if (controller.text.trim().length != 0) {
                    addYear(controller.text);
                    controller.text = "";
                  } else {
                    Flushbar(
                      message: "",
                      duration: Duration(seconds: 2),
                      flushbarPosition: FlushbarPosition.BOTTOM,
                      backgroundColor: Theme.of(context).primaryColor,
                    )
                      ..titleText = Text(
                        "Please enter some text",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 17.0,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                      ..icon=Icon(Icons.text_format)
                      ..show(context);
                  }
                },
              ),
            );
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
              trailing: Column(
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
