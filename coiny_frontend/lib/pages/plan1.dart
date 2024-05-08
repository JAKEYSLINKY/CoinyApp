import 'package:flutter/material.dart';

class Plan1Page extends StatelessWidget {
  const Plan1Page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const monthly = 10000;
    const saved = 8000;
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
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: const Color(0xFFFFF3EC),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: TextFormField(
                          textAlign: TextAlign.end,
                          decoration: const InputDecoration(
                            hintText: '${monthly}฿',
                            border: InputBorder.none,
                          ),
                        ),
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
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: const Color(0xFFFFF3EC),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: TextFormField(
                          textAlign: TextAlign.end,
                          decoration: const InputDecoration(
                            hintText: '${saved}฿',
                            border: InputBorder.none,
                          ),
                        ),
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
