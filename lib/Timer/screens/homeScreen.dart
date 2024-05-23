import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/Timer/screens/timerservice.dart';
import 'package:todo/Timer/screens/widgets/progress.dart';
import 'package:todo/Timer/screens/widgets/timecontroller.dart';
import 'package:todo/Timer/screens/widgets/timercard.dart';
import 'package:todo/Timer/screens/widgets/timeroptions.dart';
import 'package:todo/ToDoScreen.dart';

class homescreen extends StatelessWidget {
  const homescreen({Key? key});

  Color renderColor(String currentState) {
    if (currentState == "FOCUS") {
      return Color.fromARGB(255, 204, 135, 168);
    } else {
      return Color.fromARGB(255, 143, 186, 212);
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<timerservice>(context);
    return Scaffold(
      backgroundColor: renderColor(provider.currentState),
      appBar: AppBar(
        elevation: 10,
        backgroundColor: renderColor(provider.currentState),
        title: const Text(
          'Pomodoro - Timer',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            iconSize: 40,
            color: Colors.white,
            onPressed: () =>
                Provider.of<timerservice>(context, listen: false).reset(),
          ),
        ],
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
              title: Text('ToDo'),
              onTap: () {
                // Navigate to ToDo screen or any other screen you want
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => ToDoScreen()),
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
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            children: [
              SizedBox(
                height: 40,
              ),
              TimerCard(),
              SizedBox(
                height: 50,
              ),
              timerOptions(),
              SizedBox(
                height: 100,
              ),
              timeController(),
              SizedBox(
                height: 80,
              ),
              progress()
            ],
          ),
        ),
      ),
    );
  }
}
