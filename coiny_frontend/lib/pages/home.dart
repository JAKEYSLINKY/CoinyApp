import 'package:flutter/material.dart';
import '../components/addCategory.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../homeComponent/mascot.dart';
import '../homeComponent/showMoney.dart';
import '../homeComponent/categoryList.dart';
import '../homeComponent/addCategory.dart';
import '../homeComponent/history.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int userId = 2;

  @override
  void initState() {
    super.initState();
    _getCategoryData();
    _getMoneyData();
    _getHistoryData();
  }

  final urlgetcategory = 'http://10.0.2.2:4000/categories/get';
  final List<Category> categories = [
    Category('entertain', 'Entertain'),
    Category('coffee', 'Coffee'),
    Category('bus', 'Bus'),
    Category('restaurant', 'food'),
    Category('cart', 'Shopping'),
    Category('other', 'Other'),
    // Add more categories with their associated icon names as needed
  ];

  Future<void> _getCategoryData() async {
    try {
      final response =
          await http.get(Uri.parse('$urlgetcategory?userId=$userId'));
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = jsonDecode(response.body);
        List<Category> fetchedCategories = List<Category>.from(jsonData['data']
            .map((category) =>
                Category(category['iconName'], category['name'])));
        setState(() {
          categories.addAll(fetchedCategories);
          print('Updated categories: $categories');
        });
      } else {
        throw Exception('Failed to fetch data: ${response.statusCode}');
      }
    } catch (e) {
      print('$e');
      throw Exception('Error occurred during HTTP request: $e');
    }
  }

  final urlgetmoney = 'http://10.0.2.2:4000/transactions/balance';
  int usableMoney = 0;
  double dailyExpense = 0.0;

  Future<void> _getMoneyData() async {
    try {
      final response = await http.get(Uri.parse('$urlgetmoney?userId=$userId'));
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = jsonDecode(response.body);
        setState(() {
          usableMoney = jsonData['data']['usableMoney'];
          dailyExpense = jsonData['data']['currentDailyExpense'];
        });
        print('Received data: $jsonData');
      } else {
        throw Exception('Failed to fetch data: ${response.statusCode}');
      }
    } catch (e) {
      print('$e');
      throw Exception('Error occurred during HTTP request: $e');
    }
  }

  final urlgethistory = 'http://10.0.2.2:4000/transactions/get';
  List<Map<String, dynamic>> _transactionData = [];

  Future<void> _getHistoryData() async {
    try {
      final response =
          await http.get(Uri.parse('$urlgethistory?userId=$userId'));
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = jsonDecode(response.body);
        List<dynamic> transactions = jsonData['data'];
        setState(() {
          _transactionData = transactions.cast<Map<String, dynamic>>();
        });

        print('Received transaction data: $jsonData');
      } else {
        throw Exception('Failed to fetch data: ${response.statusCode}');
      }
    } catch (e) {
      print('$e');
      throw Exception('Error occurred during HTTP request: $e');
    }
  }

  // void refreshHomePage() {
  //   setState(() {});
  // }
  void reloadData() {
    _getMoneyData();
    //_getCategoryData();
    _getHistoryData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            color: Color(0xFFFFE2D2),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  mascot(),
                  showMoney(
                      usableMoney: usableMoney, dailyExpense: dailyExpense),
                  categoriesList(
                      categories: categories, reloadData: reloadData),
                  addCategory(),
                  history(transactionData: _transactionData),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
