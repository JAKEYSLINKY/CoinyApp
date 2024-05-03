import 'package:flutter/material.dart';
import 'pages/home.dart';
import 'pages/plan1.dart';
import 'pages/plan2.dart';
import 'pages/stat.dart';
import 'pages/goal.dart';
import 'auth/login.dart';
import 'auth/signup.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      // home: HomePage(),
      home: Plan1Page(),
    );
  }
}
