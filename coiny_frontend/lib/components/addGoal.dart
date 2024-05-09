import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class addGoalPopUp extends StatefulWidget {
  const addGoalPopUp({super.key});
  @override
  State<addGoalPopUp> createState() => _addGoalPopUpstate();
}

class _addGoalPopUpstate extends State<addGoalPopUp> {
  TextEditingController goalNameController = TextEditingController();
  TextEditingController goalAmountController = TextEditingController();
  bool _isNotvalid = false;

  void createGoal() async {
    try {
      if (goalNameController.text.isNotEmpty &&
          goalAmountController.text.isNotEmpty) {
        var reqBody = {
          "name": goalNameController.text,
          "goalAmount": goalAmountController.text,
          "userId": "1",
        };

        var response = await http.post(
            Uri.parse('http://localhost:4000/goals/create'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode(reqBody));

        var jsonResponse = jsonDecode(response.body);

        if (jsonResponse['status'] == 'success') {
          Navigator.pop(context);
        }
      }
    } catch (e) {
      print(e);
    }
    //   if(goalNameController.text.isNotEmpty && goalAmountController.text.isNotEmpty) {
    //   var reqBody = {
    //     "name": goalNameController.text,
    //     "goalAmount": goalAmountController.text,
    //   };

    //   var response = await http.post(
    //     Uri.parse('http://localhost:4000/goals/create'),
    //     headers: {'Content-Type': 'application/json'},
    //     body: jsonEncode(reqBody));

    //   var jsonResponse = jsonDecode(response.body);

    //   if(jsonResponse['status'] == 'success') {
    //     // Handle success
    //   } else {
    //     setState(() {
    //       _isNotvalid = true;
    //     });
    //   }
    // } else {
    //   // Handle empty fields
    // }
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
              keyboardType: TextInputType.number,
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
