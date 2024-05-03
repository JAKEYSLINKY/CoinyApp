import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFE2D2),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 100, bottom: 70),
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
              padding: const EdgeInsets.only(top: 5.0, bottom: 15.0),
              child: TextFormField(
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
                      // Add onPressed logic
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color(0xFFF5CCB4), // Background color
                    ),
                    child: const Text('Login',style: TextStyle(color: Color(0xFF95491E)))),
              ),
            ),
            Center(
              child: TextButton(
                  onPressed: () {
                    // Add onPressed logic
                  },
                  child: const Text('Sign up?')),
            )
          ],
        ),
      ),
    );
  }
}
