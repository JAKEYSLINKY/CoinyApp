import 'package:flutter/material.dart';

class NumberInputDialog extends StatefulWidget {
  // final Function(int) onSave;
  // NumberInputDialog({required this.onSave});
  NumberInputDialog({super.key});
  
  @override
  _NumberInputDialogState createState() => _NumberInputDialogState();
}

class _NumberInputDialogState extends State<NumberInputDialog> {
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text('Buffet Teenoi'),
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AnotherPopup(); // Replace AnotherPopup with the popup you want to show
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
            'Your saved : 8500',
            style: TextStyle(fontSize: 16),
          ),
          Text(
            'How much money do you want to put in goal?',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 16), // Add some space between the texts and the TextField
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
          child: Container(
// Set the height of the button
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFF5CCB4), // Set the button's background color
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)), // Set the button's border radius
              ),
              onPressed: () {
                int number = int.tryParse(_controller.text) ?? 0;
                // widget.onSave(number);
                Navigator.of(context).pop();
              },
              child: Text(
                'Save',
                style: TextStyle(color: const Color(0xFF95491E)), // Set the text color
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

class NumberInputButton extends StatelessWidget {
  // final Function(int) onSave;

  NumberInputButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return NumberInputDialog();
          },
        );
      },
      child: Text('Buffet Teenoi'),
    );
  }
}

class AnotherPopup extends StatefulWidget {
  @override
  _AnotherPopupState createState() => _AnotherPopupState();
}

class _AnotherPopupState extends State<AnotherPopup> {
  late TextEditingController _controller1;
  late TextEditingController _controller2;

  @override
  void initState() {
    super.initState();
    _controller1 = TextEditingController();
    _controller2 = TextEditingController();
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
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
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
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                ),
                onPressed: () {
                  // Add your delete logic here
                  Navigator.of(context).popUntil((route) => route.isFirst); // Close all pop-ups
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
        crossAxisAlignment: CrossAxisAlignment.start, // Align children to the start (left)
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 8), // Add margin below "Edit your goal"
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
                contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 12),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8), // Add margin above and below "Set goal"
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
                contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 12),
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
                backgroundColor: Color(0xFFF5CCB4), // Set the button's background color to red for delete
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)), // Set the button's border radius
              ),
              onPressed: _showConfirmationDialog, // Call the confirmation dialog function
              child: Text(
                'Delete',
                style: TextStyle(color: const Color(0xFF95491E)), // Set the text color
              ),
            ),
            SizedBox(width: 10), // Add some space between buttons
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF95491E), // Set the button's background color to blue for save
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)), // Set the button's border radius
              ),
              onPressed: () {
                // Add your save logic here
                Navigator.of(context).pop();
              },
              child: Text(
                'Save',
                style: TextStyle(color: const Color(0xFFF5CCB4)), // Set the text color
              ),
            ),
          ],
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
          child: NumberInputButton(
            // onSave: (int number) {
            //   print('Number saved: $number');
            //   // Do something with the saved number
            // },
          ),
        ),
      ),
    );
  }
}
