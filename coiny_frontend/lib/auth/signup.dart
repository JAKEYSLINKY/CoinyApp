import 'dart:convert';
import 'package:coiny_frontend/auth/login.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SignUpPage extends StatelessWidget {
  SignUpPage({Key? key}) : super(key: key);
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void signUp() async {
    try {
      final apiURL = 'http://10.0.2.2:4000/auth/regis';
      if (usernameController.text.isNotEmpty &&
          passwordController.text.isNotEmpty) {
        var response = await http.post(Uri.parse(apiURL),
            headers: <String, String>{'Content-Type': 'application/json'},
            body: jsonEncode(<String, dynamic>{
              "username": usernameController.text,
              "password": passwordController.text,
            }));
        if (response.statusCode == 200) {
          print('user created');
        }
      }
    } catch (e) {
      print('ERROR: $e');
      print(usernameController.text);
      print(passwordController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFE2D2),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 100, bottom: 40),
                child: Center(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 170, // Adjust size of the circle
                        height: 170, // Adjust size of the circle
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey
                              .withOpacity(0.5), // Adjust opacity and color
                        ),
                      ),
                      const Icon(
                        Icons.person,
                        size: 150,
                        // Set icon color to white
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Center(
                  child: Text(
                    'Sign up',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5.0, bottom: 15.0),
                child: TextFormField(
                  controller: usernameController,
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Color(0xFFFFF3EC),
                    labelText: 'Username',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(color: Color(0xFFFFF3EC)),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                        vertical: 12.0,
                        horizontal: 15.0), // Adjust vertical padding
                  ),
                ),
              ),
              TextFormField(
                controller: passwordController,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Color(0xFFFFF3EC),
                  labelText: 'Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(color: Color(0xFFFFF3EC)),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                      vertical: 12.0,
                      horizontal: 15.0), // Adjust vertical padding
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30.0, bottom: 0.0),
                child: Center(
                  child: ElevatedButton(
                      onPressed: () {
                        signUp();
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color(0xFFF5CCB4), // Background color
                      ),
                      child: const Text('Sign up',
                          style: TextStyle(color: Color(0xFF95491E)))),
                ),
              ),
              Center(
                child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Already have an account?')),
              )
            ],
          ),
        ),
      ),
    );
  }
}
