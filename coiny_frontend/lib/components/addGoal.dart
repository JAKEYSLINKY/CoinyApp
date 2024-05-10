import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import '../pages/goal.dart';

class addGoalPopUp extends StatefulWidget {
  const addGoalPopUp({super.key});
  @override
  State<addGoalPopUp> createState() => _addGoalPopUpstate();
}

class _addGoalPopUpstate extends State<addGoalPopUp> {
  TextEditingController goalNameController = TextEditingController();
  TextEditingController goalAmountController = TextEditingController();

  void createGoal() async {
    try {
      final apiURL = 'http://10.0.2.2:4000/goals/create';
      if (goalNameController.text.isNotEmpty &&
          goalAmountController.text.isNotEmpty) {
        final response = await http.post(Uri.parse(apiURL),
            headers: <String, String>{'Content-Type': 'application/json'},
            body: jsonEncode(<String, dynamic>{
              "userId": 1,
              "name": goalNameController.text,
              "goalAmount": int.parse(goalAmountController.text),
            }));

        if (response.statusCode == 200) {
          print('Goal created');
          Navigator.pop(context);
        }
      }
    } catch (e) {
      print('ERROR: $e');
      print(goalNameController.text);
      print(goalAmountController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Color(0xFFEDB59E),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 8),
            child: Text(
              'Enter your goal',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.left,
            ),
          ),
          Container(
            height: 37,
            child: TextField(
              controller: goalNameController,
              decoration: InputDecoration(
                labelText: 'Ex. Dream house',
                labelStyle: TextStyle(color: Color(0xFFEDB59E)),
                floatingLabelBehavior: FloatingLabelBehavior.never,
                filled: true,
                fillColor: Color(0xFFFFF3EC),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 0, horizontal: 12),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Text(
              'Set goal',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.left,
            ),
          ),
          Container(
            height: 37,
            child: TextField(
              controller: goalAmountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Ex. 1200000',
                labelStyle: TextStyle(color: Color(0xFFEDB59E)),
                floatingLabelBehavior: FloatingLabelBehavior.never,
                filled: true,
                fillColor: Color(0xFFFFF3EC),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 0, horizontal: 12),
              ),
            ),
          ),
        ],
      ),
      actions: <Widget>[
        Center(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFFF5CCB4),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
            ),
            onPressed: () {
              createGoal();
              // Navigator.push(
              //     context, MaterialPageRoute(builder: (context) => GoalPage()));
            },
            child: Text(
              'Save',
              style: TextStyle(color: const Color(0xFF95491E)),
            ),
          ),
        ),
      ],
    );
  }
}
