import 'package:flutter/material.dart';

class addGoalButton extends StatelessWidget {
  final Function(int) onSave;

  addGoalButton({required this.onSave});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return addGoalPopUp(); // Show AnotherPopup when NumberInputButton is clicked
          },
        );
      },
      child: Text('+'),
    );
  }
}

class addGoalPopUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Color(0xFFEDB59E),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 8),
            child: Text(
              'Enter your goal',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.left,
            ),
          ),
          Container(
            height: 37,
            child: TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Ex. Dream house',
                labelStyle: TextStyle(color: Color(0xFFEDB59E)),
                floatingLabelBehavior: FloatingLabelBehavior.never,
                filled: true,
                fillColor: Color(0xFFFFF3EC),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 12),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Text(
              'Set goal',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.left,
            ),
          ),
          Container(
            height: 37,
            child: TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Ex. 1200000',
                labelStyle: TextStyle(color: Color(0xFFEDB59E)),
                floatingLabelBehavior: FloatingLabelBehavior.never,
                filled: true,
                fillColor: Color(0xFFFFF3EC),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 12),
              ),
            ),
          ),
        ],
      ),
      actions: <Widget>[
        Center(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFFF5CCB4),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              'Save',
              style: TextStyle(color: const Color(0xFF95491E)),
            ),
          ),
        ),
      ],
    );
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Goal'),
        ),
        body: Center(
          child: addGoalButton(
            onSave: (int number) {
              print('Number saved: $number');
            },
          ),
        ),
      ),
    );
  }
}
