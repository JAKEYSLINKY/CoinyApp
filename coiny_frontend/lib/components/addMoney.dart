import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class addMoney extends StatefulWidget {
  final token;

  addMoney({super.key, required this.token});

  @override
  _NumberInputDialogState createState() => _NumberInputDialogState();
}

class _NumberInputDialogState extends State<addMoney> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  final url = 'http://10.0.2.2:4000/transactions/add';

  Future<void> _postData(String usage) async {
    print(usage);
    try {
      final int amount = int.parse(_controller.text);
      final response = await http
          .post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'token': widget.token,
          'amount': amount,
          'usage': usage,
          'source': "null",
        }),
      )
          .catchError((e) {
        print('Error occurred during POST request: $e');
        throw Exception('Failed to post data: $e');
      });

      if (response.statusCode == 200) {
        print('create bonus success: ${response.statusCode}');
        final responseData = jsonDecode(response.body);
      } else {
        print('Failed to post data: ${response.statusCode}');
        print('Error message: ${response.body}');
      }
    } catch (e) {
      print('Error occurred during POST request: $e');
      throw Exception('Failed to post data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Color(0xFFEDB59E),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: EdgeInsets.zero, // No padding around the IconButton
            child: IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ],
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'How much money do you want to add?',
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(
              height: 16), // Add some space between the texts and the TextField
          Container(
            height: 37, // Set the height of the input box
            child: TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Ex. 1000',
                labelStyle: TextStyle(color: Color(0xFFEDB59E)),
                floatingLabelBehavior: FloatingLabelBehavior.never,
                filled: true,
                fillColor: Color(0xFFFFF3EC), // Set the background color
                border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(20), // Set the border radius
                  borderSide: BorderSide.none, // Remove the border
                ),
                contentPadding: EdgeInsets.symmetric(
                    vertical: 0, horizontal: 12), // Set the padding
              ),
            ),
          ),
        ],
      ),
      actions: <Widget>[
        Center(
          child: Column(
            children: [
              Container(
                width: 200,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Color(0xFFF5CCB4), // Set the button's background color
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            15)), // Set the button's border radius
                  ),
                  onPressed: () {
                    int number = int.tryParse(_controller.text) ?? 0;
                    print('pressed saved button');
                    _postData('save');

                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Add to Saved',
                    style: TextStyle(
                        color: const Color(0xFF95491E)), // Set the text color
                  ),
                ),
              ),
              SizedBox(height: 8), // Add some space between buttons
              Container(
                width: 200,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Color(0xFF95491E), // Set the button's background color
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            15)), // Set the button's border radius
                  ),
                  onPressed: () {
                    // Add your onSave logic for the second button here
                    int number = int.tryParse(_controller.text) ?? 0;
                    _postData('use');
                    Navigator.of(context).pop();
                    // This is just a placeholder
                    print('Second button pressed');
                  },
                  child: Text(
                    'Add to Usable Money',
                    style: TextStyle(
                        color: const Color(0xFFF5CCB4)), // Set the text color
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
