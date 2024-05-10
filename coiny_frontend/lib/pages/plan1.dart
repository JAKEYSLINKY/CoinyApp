import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Plan1Page extends StatefulWidget {
  const Plan1Page({Key? key}) : super(key: key);

  @override
  _Plan1PageState createState() => _Plan1PageState();
}

class _Plan1PageState extends State<Plan1Page> {
  final url = 'http://localhost:4000/plans/create';
  TextEditingController monthlyController = TextEditingController();
  TextEditingController savedController = TextEditingController();
  String result = '';

  @override
  void dispose() {
    monthlyController.dispose();
    savedController.dispose();
    super.dispose();
  }

  Future<void> _postData() async {
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'user': 1,
          'monthly': monthlyController.text,
          'save': savedController.text,
          'currentSave': savedController.text,
        }),
      );

      if (response.statusCode == 201) {
        // Successful POST request, handle the response here
        final responseData = jsonDecode(response.body);
        setState(() {
          //result =
              //'ID: ${responseData['id']}\nName: ${responseData['name']}\nEmail: ${responseData['email']}';
        });
      } else {
        // If the server returns an error response, throw an exception
        throw Exception('Failed to post data');
      }
    } catch (e) {
      setState(() {
        result = 'Error: $e';
      });
    } 
  }

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
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: const Color(0xFFFFF3EC),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: TextFormField(
                          controller: monthlyController,
                          textAlign: TextAlign.end,
                          decoration: const InputDecoration(
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
                          controller: savedController,
                          textAlign: TextAlign.end,
                          decoration: const InputDecoration(
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
                    int monthly = int.tryParse(monthlyController.text) ?? 0;
                    int saved = int.tryParse(savedController.text) ?? 0;
                    print('Monthly: $monthly');
                    print('Saved: $saved');
                    _postData();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF5CCB4),
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
