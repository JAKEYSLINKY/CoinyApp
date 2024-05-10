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

class GoalPage extends StatefulWidget {
  GoalPage({Key? key}) : super(key: key);

  @override
  _GoalPageState createState() => _GoalPageState();
}

class _GoalPageState extends State<GoalPage> {
  final int Saved = 8000;
  final int userId = 1;
  List<Mygoal> goals = [];

  @override
  void initState() {
    super.initState();
    initialize();
  }

  void initialize() async {
    getGoal();
  }

  void getGoal() async {
    try {
      final apiURL = 'http://10.0.2.2:4000/goals/get?userId=$userId';
      final response = await http.get(
        Uri.parse(apiURL),
        headers: <String, String>{'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        print('getGoal');
        setState(() {
          goals = parseGoals(response.body); // Implement parseGoals method
        });
        print(response.body);
      }
    } catch (e) {
      print('ERROR: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFE2D2),
      body: SingleChildScrollView(
        child: Padding(
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
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
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
                  // child: Column(
                  //   children: goals.map((goal) {
                  //     return Padding(
                  //       padding: const EdgeInsets.only(bottom: 15.0),
                  //       child: goalTem(
                  //         name: goal.name,
                  //         goal: goal.goal,
                  //         currentAmount: goal.currentAmount,
                  //       ),
                  //     );
                  //   }).toList(),
                  // ),
                  child: Container(
                    child: ListView.builder(
                      itemCount: goals.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 15.0),
                          child: goalTem(
                            name: goals[index].name,
                            goal: goals[index].goal,
                            currentAmount: goals[index].currentAmount,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              Center(
                child: AddNewGoal(),
              ),
            ],
          ),
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
              return addGoalPopUp();
              // Show AnotherPopup when NumberInputButton is clicked
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

List<Mygoal> parseGoals(String responseBody) {
  try {
    // Parse the JSON string into a Map<String, dynamic> using jsonDecode
    Map<String, dynamic> jsonResponse = jsonDecode(responseBody);

    // Extract the 'data' field from the JSON response
    List<dynamic> jsonData = jsonResponse['data'];

    // Create an empty list to store the parsed goals
    List<Mygoal> parsedGoals = [];

    // Iterate over each item in the JSON data
    for (var item in jsonData) {
      // Check if the item is a Map<String, dynamic>
      if (item is Map<String, dynamic>) {
        // Extract individual fields from the map
        String name = item['name'];
        int goal = item['goalAmount'];
        int currentAmount = item['currentAmount'];

        // Create a new Mygoal object from the extracted data
        Mygoal goalObject = Mygoal(
          name: name ?? '',
          goal: goal ?? 0,
          currentAmount: currentAmount ?? 0,
        );

        // Add the created Mygoal object to the parsedGoals list
        parsedGoals.add(goalObject);
      }
    }

    // Return the list of parsed goals
    return parsedGoals;
  } catch (e) {
    // Handle JSON parsing errors
    print('Error parsing JSON: $e');
    return []; // Return an empty list in case of errors
  }
}
