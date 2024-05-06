import 'package:coiny_frontend/components/addMoney.dart';
import 'package:flutter/material.dart';

class Plan2Page extends StatelessWidget {
  const Plan2Page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFE2D2),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 70.0, horizontal: 50.0),
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
            const Text(
              "Planning",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: Column(children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          "Monthly",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      Text(
                        '10000B',
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          "Saved",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      Text(
                        '8000B',
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ]),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Add onPressed logic
                    },
                    child: const Text(
                      'Reset',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Container(
                height: 3,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(0xFFEDB59E),
                ),
              ),
            ),
            const Text(
              "Add Bonus Money",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return addMoney(); // Show AnotherPopup when NumberInputButton is clicked
          },
        );
      },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color(0xFFF5CCB4), // Background color
                    ),
                    child: const Text(
                      'Add',
                      style: TextStyle(color: Color(0xFF95491E)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
