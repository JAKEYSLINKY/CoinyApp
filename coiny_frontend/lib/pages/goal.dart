import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:coiny_frontend/components/addGoal.dart';
import 'package:coiny_frontend/components/goalEditon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Mygoal {
  final String name;
  final int goal;
  final int currentAmount;
  Mygoal({required this.name, required this.goal, required this.currentAmount});
}

class GoalPage extends StatelessWidget {
  GoalPage({super.key});
  // ignore: non_constant_identifier_names
  final int Saved = 8000;
  final int userId = 1;
  List<Mygoal> goals = [
    Mygoal(name: 'Macbook Pro', goal: 50000, currentAmount: 5000),
    Mygoal(name: 'iPhone 13', goal: 30000, currentAmount: 15000),
    Mygoal(name: 'AirPods Pro', goal: 5000, currentAmount: 2500),
  ];

  void initialize() async {
    getGoal();
  }
  
  void getGoal() async {
    try {
      final apiURL = 'http://localhost:4000/goals/get';
        final response = await http.get(Uri.parse(apiURL),
            headers: <String, String>{'Content-Type': 'application/json'},);

        if (response.statusCode == 200) {
          print('getGoal');
      }
    } catch (e) {
      print('ERROR: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFE2D2),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              child: Text(
                "Goal",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Expanded(
                        child: Text(
                      'Your save :',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    )),
                    Expanded(
                        child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF95491E),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                            child: Text('$Saved฿',
                                style: const TextStyle(
                                    color: Color(0xFFFFF3EC),
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold))),
                      ),
                    ))
                  ]),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return NumberInputDialog(); // Show AnotherPopup when NumberInputButton is clicked
                    },
                  );
                },
                child: Column(
                  children: goals.map((goal) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 15.0),
                      child: goalTem(
                        name: goal.name,
                        goal: goal.goal,
                        currentAmount: goal.currentAmount,
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            Center(
              child: AddNewGoal(),
            ),
          ],
        ),
      ),
    );
  }
}

class AddNewGoal extends StatelessWidget {
  const AddNewGoal({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return addGoalPopUp(); // Show AnotherPopup when NumberInputButton is clicked
            },
          );
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(const Color(0xFF95491E)),
        ),
        child: const Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 40.0),
          child: Icon(
            Icons.add,
            color: Color(0xFFFFF3EC),
          ),
        ));
  }
}

// ignore: must_be_immutable, camel_case_types
class goalTem extends StatelessWidget {
  goalTem({
    super.key,
    required this.name,
    required this.goal,
    required this.currentAmount,
  });
  String name;
  int goal;
  int currentAmount;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFF95491E),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    name,
                    style:
                        const TextStyle(color: Color(0xFFFFF3EC), fontSize: 20),
                  ),
                  Text(
                    // ignore: prefer_interpolation_to_compose_strings
                    currentAmount.toString() + "/" + goal.toString() + '฿',
                    style:
                        const TextStyle(color: Color(0xFFFFF3EC), fontSize: 16),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: SizedBox(
                        height: 35,
                        child: LinearProgressIndicator(
                          value: (currentAmount / goal)
                              .toDouble(), //value of percentage. 0.55 = 55%
                          backgroundColor: Color(0xFFFFF3EC),
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Color(0xFFF98A4C)),
                        ),
                      ),
                    ),
                    Positioned.fill(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: Text(
                            '${(currentAmount / goal * 100).toStringAsFixed(0)}%',
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ]),
          ),
        )),
      ],
    );
  }
}
