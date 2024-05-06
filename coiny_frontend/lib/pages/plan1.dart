import 'package:flutter/material.dart';

class Plan1Page extends StatelessWidget {
  const Plan1Page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFE2D2),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 50.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Planning",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Expanded(
                    child: Text(
                      "Monthly",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // Add onPressed logic
                      },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('10000'),
                          Text('B'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Expanded(
                    child: Text(
                      "Saved",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // Add onPressed logic
                      },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('8000'),
                          Text('B'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Add onPressed logic
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        const Color(0xFFF5CCB4), // Background color
                  ),
                  child: const Text(
                    'Confirm',
                    style: TextStyle(color: Color(0xFF95491E)),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
