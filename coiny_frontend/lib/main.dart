import 'package:flutter/material.dart';
import 'pages/home.dart';
import 'pages/plan1.dart';
import 'pages/plan2.dart';
import 'pages/stat.dart';
import 'pages/goal.dart';
import 'auth/login.dart';
import 'auth/signup.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final urlget = 'http://10.0.2.2:4000/plans/get';
  int userId = 2;
  late int _selectedPlanPage;

  @override
  void initState() {
    super.initState();
    _selectedPlanPage = 1; // Assuming Plan1Page is the default page
    _checkDataAndNavigate();
  }

  Future<void> _checkDataAndNavigate() async {
    try {
      final data = await _getData();
      if (data != null) {
        // Data is available, navigate to Plan2Page
        setState(() {
          _selectedPlanPage = 2;
        });
      } else {
        // No data available, navigate to Plan1Page
        setState(() {
          _selectedPlanPage = 1;
        });
      }
    } catch (e) {
      // Error occurred, navigate to Plan1Page
      setState(() {
        _selectedPlanPage = 1;
      });
    }
  }

  Future<Map<String, dynamic>> _getData() async {
    try {
      final response = await http.get(Uri.parse('$urlget?userId=$userId'));
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = jsonDecode(response.body);
        print('Received data: $jsonData');
        return jsonData;
      } else {
        throw Exception('Failed to fetch data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error occurred during HTTP request: $e');
    }
  }

  int _selectedPage = 3;
  void navigateToPlan2() {
    setState(() {
      _selectedPlanPage = 2;
    });
  }
  void navigateToPlan1() {
    setState(() {
      _selectedPlanPage = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    final _pageOptions = [
      const HomePage(),
      const stat(),
      if (_selectedPlanPage == 2) Plan2Page(navigateToPlan1) else Plan1Page(navigateToPlan2),
      GoalPage(),
    ];
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
