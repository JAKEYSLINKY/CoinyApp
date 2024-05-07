import 'package:flutter/material.dart';

class addMoney extends StatefulWidget {
  // final Function(int) onSave;

  addMoney({super.key});

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
            'How much money do you want to put in goal?',
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(height: 16), // Add some space between the texts and the TextField
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
                  borderRadius: BorderRadius.circular(20), // Set the border radius
                  borderSide: BorderSide.none, // Remove the border
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 12), // Set the padding
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
                    backgroundColor: Color(0xFFF5CCB4), // Set the button's background color
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)), // Set the button's border radius
                  ),
                  onPressed: () {
                    int number = int.tryParse(_controller.text) ?? 0;
                    // widget.onSave(number);
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Add to Saved',
                    style: TextStyle(color: const Color(0xFF95491E)), // Set the text color
                  ),
                ),
              ),
              SizedBox(height: 8), // Add some space between buttons
              Container(
                width: 200,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF95491E), // Set the button's background color
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)), // Set the button's border radius
                  ),
                  onPressed: () {
                    // Add your onSave logic for the second button here
                    int number = int.tryParse(_controller.text) ?? 0;
                    // widget.onSave(number);
                    Navigator.of(context).pop();
                    // This is just a placeholder
                    print('Second button pressed');
                  },
                  child: Text(
                    'Add to Usable Money',
                    style: TextStyle(color: const Color(0xFFF5CCB4)), // Set the text color
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

class NumberInputButton extends StatelessWidget {
  final Function(int) onSave;

  NumberInputButton({required this.onSave});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return addMoney();
          },
        );
      },
      child: Text('Add Money'),
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
          child: NumberInputButton(
            onSave: (int number) {
              print('Number saved: $number');
              // Do something with the saved number
            },
          ),
        ),
      ),
    );
  }
}
