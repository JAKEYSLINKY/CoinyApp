import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProfileDialog extends StatelessWidget {
  ProfileDialog({Key? key, required this.token, required this.onTokenChanged})
      : super(key: key);
  var token;
  final Function(String) onTokenChanged;
  TextEditingController _controller = TextEditingController();

  void onSave() async {
    try {
      final apiURL = 'http://10.0.2.2:4000/users/edit/name';
      final response = await http.patch(
        Uri.parse(apiURL),
        headers: <String, String>{'Content-Type': 'application/json'},
        body: jsonEncode(<String, dynamic>{
          "token": token,
          "name": _controller.text,
        }),
      );
      if (response.statusCode == 200) {
        print('Name updated');
      }
    } catch (e) {
      print('ERROR: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Color(0xFFEDB59E),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 5),
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            Container(
              padding: EdgeInsets.all(10.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage('assets/profile.jpg'),
                    radius: 50,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Name',
                    style: TextStyle(
                      color: Color(0xFFFFFFFF),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: _controller,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: 'Ex. coiny',
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
                      suffixIcon: SizedBox(
                        width: 10, // Specify the width of the icon
                        height: 10, // Specify the height of the icon
                        child: Icon(Icons.edit, color: Color(0xFFEDB59E)),
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFF5CCB4),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        onPressed: () {
                          token = '';
                          onTokenChanged(token);
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          'Logout',
                          style: TextStyle(
                            color: const Color(0xFF95491E),
                          ),
                        ),
                      ),
                      SizedBox(width: 5),
                      // ElevatedButton(
                      //   style: ElevatedButton.styleFrom(
                      //     backgroundColor: Color(0xFF95491E),
                      //     shape: RoundedRectangleBorder(
                      //       borderRadius: BorderRadius.circular(15),
                      //     ),
                      //   ),
                      //   onPressed: () {
                      //     onSave();
                      //     Navigator.of(context).pop();
                      //   },
                      //   child: Text(
                      //     'Save',
                      //     style: TextStyle(
                      //       color: const Color(0xFFF5CCB4),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                  SizedBox(height: 15),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
