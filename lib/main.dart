import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/Login/loginscreen.dart';
import 'package:todo/Timer/screens/homeScreen.dart';
import 'package:todo/Timer/screens/timerservice.dart';
import 'package:todo/ToDoScreen.dart';
import 'package:todo/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ChangeNotifierProvider<timerservice>(
      create: (_) => timerservice(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: homescreen(),
      // home: ToDoScreen(),
      home: LoginScreen(),
    );
  }
}
