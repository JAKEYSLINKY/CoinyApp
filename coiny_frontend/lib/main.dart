import 'package:flutter/material.dart';
import 'pages/home.dart';
import 'pages/plan.dart';
import 'pages/stat.dart';
import 'pages/goal.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}
