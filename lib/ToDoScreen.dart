import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:random_string/random_string.dart';
import 'package:todo/Timer/screens/homeScreen.dart';
import 'package:todo/db_service/database.dart';

class ToDoScreen extends StatefulWidget {
  const ToDoScreen({super.key});

  @override
  State<ToDoScreen> createState() => _ToDoScreenState();
}

class _ToDoScreenState extends State<ToDoScreen> {
  bool yearly = true, monthly = false, weekly = false, daily = false;
  bool suggest = false;
  TextEditingController todoController = TextEditingController();
  Stream? todoStream;
  getonTheLoad() async {
    todoStream = await DatabaseServices().getTask(yearly
        ? "Yearly"
        : monthly
            ? "Monthly"
            : weekly
                ? "Weekly"
                : "Daily");
    setState(() {});
  }

  Widget getWork() {
    return StreamBuilder(
        stream: todoStream,
        builder: (context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? Expanded(
                  child: ListView.builder(
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (context, Index) {
                        DocumentSnapshot docSnap = snapshot.data.docs[Index];
                        return CheckboxListTile(
                          activeColor: Color.fromARGB(255, 69, 25, 77),
                          title: Text(docSnap["work"]),
                          value: docSnap["Yes"],
                          onChanged: (newValue) async {
                            await DatabaseServices().tickMethod(
                                docSnap["id"],
                                yearly
                                    ? "Yearly"
                                    : monthly
                                        ? "Monthly"
                                        : weekly
                                            ? "Weekly"
                                            : "Daily");
                            setState(() {
                              Future.delayed(Duration(seconds: 2), () {
                                DatabaseServices().removeMethod(
                                    docSnap["id"],
                                    yearly
                                        ? "Yearly"
                                        : monthly
                                            ? "Monthly"
                                            : weekly
                                                ? "Weekly"
                                                : "Daily");
                              });
                            });
                          },
                          controlAffinity: ListTileControlAffinity.leading,
                        );
                      }),
                )
              : Center(child: CircularProgressIndicator());
        });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 103, 60, 101),
        onPressed: () {
          openBox();
        },
        child: Icon(Icons.add, color: Colors.black),
      ),
      appBar: AppBar(
        title: Text('Planner'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 163, 95, 163),
              ),
              child: Text(
                'Planner',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Text('Home'),
              onTap: () {
                // Navigate to home screen or any other screen you want
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('POMODORO'),
              onTap: () {
                // Navigate to timer screen or any other screen you want
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => homescreen()),
                );
              },
            ),
            ListTile(
              title: Text('Logout'),
              onTap: () {
                // Perform logout functionality
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 10, left: 20),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          Colors.white,
          Colors.white,
          Colors.white54,
        ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
                // ignore: prefer_const_constructors
                child: Text(
              "Let's the work begins !",
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            )),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                yearly
                    ? Material(
                        elevation: 5,
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 103, 60, 101),
                              borderRadius: BorderRadius.circular(20)),
                          child: Text(
                            "Yearly",
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      )
                    : GestureDetector(
                        onTap: () async {
                          yearly = true;
                          monthly = false;
                          weekly = false;
                          daily = false;
                          await getonTheLoad();
                          setState(() {});
                        },
                        child: Text(
                          "Yearly",
                          style: TextStyle(fontSize: 20),
                        )),
                monthly
                    ? Material(
                        elevation: 5,
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 103, 60, 101),
                              borderRadius: BorderRadius.circular(20)),
                          child: Text(
                            "Monthly",
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      )
                    : GestureDetector(
                        onTap: () async {
                          yearly = false;
                          monthly = true;
                          weekly = false;
                          daily = false;
                          await getonTheLoad();
                          setState(() {});
                        },
                        child: Text(
                          "Monthly",
                          style: TextStyle(fontSize: 20),
                        )),
                weekly
                    ? Material(
                        elevation: 5,
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 103, 60, 101),
                              borderRadius: BorderRadius.circular(20)),
                          child: Text(
                            "Weekly",
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      )
                    : GestureDetector(
                        onTap: () async {
                          yearly = false;
                          monthly = false;
                          weekly = true;
                          daily = false;
                          await getonTheLoad();
                          setState(() {});
                        },
                        child: Text(
                          "Weekly",
                          style: TextStyle(fontSize: 20),
                        )),
                daily
                    ? Material(
                        elevation: 5,
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 103, 60, 101),
                              borderRadius: BorderRadius.circular(20)),
                          child: Text(
                            "Daily",
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      )
                    : GestureDetector(
                        onTap: () async {
                          yearly = false;
                          monthly = false;
                          weekly = false;
                          daily = true;
                          await getonTheLoad();
                          setState(() {});
                        },
                        child: Text(
                          "Daily",
                          style: TextStyle(fontSize: 20),
                        )),
              ],
            ),
            SizedBox(height: 20),
            getWork(),
          ],
        ),
      ),
    );
  }

  Future openBox() {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: SingleChildScrollView(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.cancel),
                    ),
                    SizedBox(
                      width: 60,
                    ),
                    Text(
                      "Add ToDo Task",
                      style: TextStyle(
                        color: Color.fromARGB(255, 69, 25, 77),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Text("Add Text"),
                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 2.0),
                  ),
                  child: TextField(
                    controller: todoController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Enter The Task",
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 175, 127, 184),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    width: 100,
                    padding: EdgeInsets.all(5),
                    child: GestureDetector(
                      onTap: () {
                        String id = randomAlphaNumeric(10);
                        Map<String, dynamic> userTodo = {
                          "work": todoController.text,
                          "id": id,
                          "Yes": false,
                        };
                        // Add the task to the selected frequency
                        if (daily) {
                          DatabaseServices().addDailyTask(userTodo, id);
                          DatabaseServices().addWeeklyTask(userTodo, id);
                          DatabaseServices().addMonthlyTask(userTodo, id);
                          DatabaseServices().addYearlyTask(userTodo, id);
                        } else if (weekly) {
                          DatabaseServices().addWeeklyTask(userTodo, id);
                          DatabaseServices().addMonthlyTask(userTodo, id);
                          DatabaseServices().addYearlyTask(userTodo, id);
                        } else if (monthly) {
                          DatabaseServices().addMonthlyTask(userTodo, id);
                          DatabaseServices().addYearlyTask(userTodo, id);
                        } else if (yearly) {
                          DatabaseServices().addYearlyTask(userTodo, id);
                        }
                        // Clear the text field
                        todoController.clear();
                        Navigator.pop(context);
                      },
                      child: Center(
                        child: Text(
                          "ADD",
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
