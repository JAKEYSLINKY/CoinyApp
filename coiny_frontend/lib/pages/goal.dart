import 'package:coiny_frontend/components/addGoal.dart';
import 'package:coiny_frontend/components/goalEditon.dart';
import 'package:flutter/material.dart';

class GoalPage extends StatelessWidget {
  const GoalPage({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFE2D2),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 70.0, horizontal: 25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ClipOval(
                  child: Image.asset(
                    'assets/rabbit.jpg',
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
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
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Center(
                            child: Text(
                          '10000B',
                          style:
                              TextStyle(color: Color(0xFFFFF3EC), fontSize: 20),
                        )),
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
              
      
              child: Row(
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
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Buffet Teenoi',
                              style: TextStyle(
                                  color: Color(0xFFFFF3EC), fontSize: 20),
                            ),
                            Text(
                              '250/1000',
                              style: TextStyle(
                                  color: Color(0xFFFFF3EC), fontSize: 16),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: const SizedBox(
                                  height: 35,
                                  child: LinearProgressIndicator(
                                    value:
                                        0.55, //value of percentage. 0.55 = 55%
                                    backgroundColor: Color(0xFFFFF3EC),
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Color(0xFFF98A4C)),
                                  ),
                                ),
                              ),
                              const Positioned.fill(
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 5.0),
                                    child: Text(
                                      '55%',
                                      style: TextStyle(
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
              ),
              ),
            ),
            Center(
              child: ElevatedButton(
                  onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return addGoalPopUp(); // Show AnotherPopup when NumberInputButton is clicked
          },
        );
      },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(const Color(0xFF95491E)),
                  ),
                  child: const Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 8.0, horizontal: 40.0),
                    child: Icon(
                      Icons.add,
                      color: Color(0xFFFFF3EC),
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
