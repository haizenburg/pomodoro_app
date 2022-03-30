import 'package:flutter/material.dart';
import 'package:pomodoro_app/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pomodoro',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: Home(),
    );
  }
}

