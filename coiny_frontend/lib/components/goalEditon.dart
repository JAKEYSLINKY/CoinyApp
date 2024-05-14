import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NumberInputDialog extends StatefulWidget {
  final int goal;
  final int saved;
  final String name;
  final int goalId;
  final token;
  final Function reloadGoals;
  // final Function updateSavedAmount;
  NumberInputDialog({
    super.key,
    required this.goal,
    required this.saved,
    required this.name,
    required this.goalId,
    required this.reloadGoals,
    required this.token,
    // required this.updateSavedAmount
  });
  @override
  _NumberInputDialogState createState() => _NumberInputDialogState();
}

class _NumberInputDialogState extends State<NumberInputDialog> {
  late TextEditingController _controller;
  late int tempSave;
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  void addMoney() async {
    try {
      final apiURL = 'http://10.0.2.2:4000/goals/add';
      if (_controller.text.isNotEmpty) {
        final response = await http.patch(Uri.parse(apiURL),
            headers: <String, String>{'Content-Type': 'application/json'},
            body: jsonEncode(<String, dynamic>{
              "token": widget.token,
              "goalId": widget.goalId,
              "amount": int.parse(_controller.text),
            }));
        if (response.statusCode == 200) {
          print('Added money to goal');
          // widget.updateSavedAmount(tempSave);
          widget.reloadGoals();
          Navigator.pop(context);
        }
      }
    } catch (e) {
      print('ERROR: $e');
      print(_controller.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Color(0xFFEDB59E),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(widget.name),
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AnotherPopup(
                        token: widget.token,
                        goalId: widget.goalId,
                        name: widget.name,
                        reloadGoals: widget.reloadGoals,
                        goal: widget.goal,
                      ); // Replace AnotherPopup with the popup you want to show
                    },
                  );
                },
              ),
            ],
          ),
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Your saved : ${widget.saved}',
            style: TextStyle(fontSize: 16),
          ),
          Text(
            'How much money do you want to put in goal?',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(
              height: 16), // Add some space between the texts and the TextField
          Container(
            height: 37, // Set the height of the input box
            child: TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Ex. 200',
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
          child: Container(
// Set the height of the button
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    Color(0xFFF5CCB4), // Set the button's background color
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        20)), // Set the button's border radius
              ),
              onPressed: () {
                int number = int.tryParse(_controller.text) ?? 0;
                if (number > widget.saved) {
                  print('You can not add more than you have');
                } else if (number > 0 && number <= widget.saved) {
                  addMoney();
                  tempSave = widget.saved - number;
                }
              },
              child: Text(
                'Save',
                style: TextStyle(
                    color: const Color(0xFF95491E)), // Set the text color
              ),
            ),
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

class AnotherPopup extends StatefulWidget {
  final String token;
  final int goalId;
  final String name;
  final int goal;
  final Function reloadGoals;

  const AnotherPopup(
      {super.key,
      required this.token,
      required this.goalId,
      required this.reloadGoals,
      required this.name,
      required this.goal});
  @override
  // ignore: library_private_types_in_public_api, no_logic_in_create_state
  _AnotherPopupState createState() => _AnotherPopupState(
        controller1: TextEditingController(),
        controller2: TextEditingController(),
      );
}

class _AnotherPopupState extends State<AnotherPopup> {
  TextEditingController _controller1;
  TextEditingController _controller2;

  _AnotherPopupState({
    required TextEditingController controller1,
    required TextEditingController controller2,
  })  : _controller1 = controller1,
        _controller2 = controller2;

  @override
  void initState() {
    super.initState();
    _controller1 = TextEditingController(text: widget.name);
    _controller2 = TextEditingController(text: widget.goal.toString());
  }

  void editGoal() async {
    try {
      final apiURL = 'http://10.0.2.2:4000/goals/edit';
      if (_controller1.text.isNotEmpty && _controller2.text.isNotEmpty) {
        final response = await http.patch(Uri.parse(apiURL),
            headers: <String, String>{'Content-Type': 'application/json'},
            body: jsonEncode(<String, dynamic>{
              "token": widget.token,
              "goalId": widget.goalId,
              "name": _controller1.text,
              "goalAmount": int.parse(_controller2.text),
            }));
        if (response.statusCode == 200) {
          print('Edit goal');
          widget.reloadGoals();
          Navigator.pop(context);
          Navigator.pop(context);
        }
      }
    } catch (e) {
      print('ERROR: $e');
      print(_controller1.text);
      print(_controller2.text);
    }
  }

  void deleteGoal() async {
    try {
      final apiURL =
          'http://10.0.2.2:4000/goals/delete?token=${widget.token}&goalId=${widget.goalId}';
      final response = await http.delete(
        Uri.parse(apiURL),
        headers: <String, String>{'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        print('delete goal');
        widget.reloadGoals();
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.pop(context);
      }
    } catch (e) {
      print('ERROR: $e');
      print(_controller1.text);
      print(_controller2.text);
    }
  }

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    super.dispose();
  }

  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color(0xFFEDB59E),
          title: Text("Are you sure that you want to delete?"),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFF5CCB4),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'No',
                    style: TextStyle(color: const Color(0xFF95491E)),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF95491E),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                  onPressed: () {
                    deleteGoal();
                  },
                  child: Text(
                    'Yes',
                    style: TextStyle(color: const Color(0xFFF5CCB4)),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Color(0xFFEDB59E), // Set the background color
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment:
            CrossAxisAlignment.start, // Align children to the start (left)
        children: [
          Padding(
            padding:
                EdgeInsets.only(bottom: 8), // Add margin below "Edit your goal"
            child: Text(
              'Edit your goal',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.left, // Align text to the left
            ),
          ),
          Container(
            height: 37,
            child: TextField(
              controller: _controller1,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Ex. Dream house',
                labelStyle: TextStyle(color: Color(0xFFEDB59E)),
                floatingLabelBehavior: FloatingLabelBehavior.never,
                filled: true,
                fillColor: Color(0xFFFFF3EC), // Set the background color
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 0, horizontal: 12),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: 8), // Add margin above and below "Set goal"
            child: Text(
              'Set goal',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.left, // Align text to the left
            ),
          ),
          Container(
            height: 37,
            child: TextField(
              controller: _controller2,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Ex. 1200000',
                labelStyle: TextStyle(color: Color(0xFFEDB59E)),
                floatingLabelBehavior: FloatingLabelBehavior.never,
                filled: true,
                fillColor: Color(0xFFFFF3EC), // Set the background color
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 0, horizontal: 12),
              ),
            ),
          ),
        ],
      ),
      actions: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(
                    0xFFF5CCB4), // Set the button's background color to red for delete
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        20)), // Set the button's border radius
              ),
              onPressed:
                  _showConfirmationDialog, // Call the confirmation dialog function
              child: Text(
                'Delete',
                style: TextStyle(
                    color: const Color(0xFF95491E)), // Set the text color
              ),
            ),
            SizedBox(width: 10), // Add some space between buttons
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(
                    0xFF95491E), // Set the button's background color to blue for save
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        20)), // Set the button's border radius
              ),
              onPressed: () {
                // Add your save logic here
                editGoal();
              },
              child: Text(
                'Save',
                style: TextStyle(
                    color: const Color(0xFFF5CCB4)), // Set the text color
              ),
            ),
          ],
        ),
      ],
    );
  }
}
