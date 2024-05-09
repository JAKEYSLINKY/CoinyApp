import 'package:flutter/material.dart';
import 'pages/home.dart';
import 'pages/plan1.dart';
import 'pages/plan2.dart';
import 'pages/stat.dart';
import 'pages/goal.dart';
import 'auth/login.dart';
import 'auth/signup.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedPage = 3;
  final _pageOptions = [
    const HomePage(),
    const stat(),
    const Plan1Page(),
    GoalPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            backgroundColor: const Color(0xFFFFE2D2),
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 8, right: 30),
                child: ClipOval(
                  child: Image.asset(
                    'assets/profile.jpg',
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
          body: _pageOptions[_selectedPage],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _selectedPage,
            backgroundColor: const Color(0xFFEDB59E),
            iconSize: 24, // Adjust icon size
            selectedFontSize: 14, // Adjust selected font size
            unselectedFontSize: 14, // Adjust unselected font size
            type: BottomNavigationBarType.fixed,
            selectedItemColor: const Color(0xFF95491E),
            unselectedItemColor: Colors.white,
            onTap: (int index) {
              setState(() {
                _selectedPage = index;
              });
            },
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                  ),
                  label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.leaderboard), label: 'Stat'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.library_books), label: 'Plan'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.emoji_events), label: 'Goal'),
            ],
          ),
        ));
  }
}
