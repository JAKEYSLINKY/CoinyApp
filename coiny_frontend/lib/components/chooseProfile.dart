import 'package:flutter/material.dart';

class ProfilePictureDialog extends StatefulWidget {
  @override
  _ProfilePictureDialogState createState() => _ProfilePictureDialogState();
}

class _ProfilePictureDialogState extends State<ProfilePictureDialog> {
  int selectedIndex = -1; // Initially no picture selected

  final List<String> profilePictures = [
    'assets/bear.jpg',
    'assets/cat.jpg',
    'assets/chick.jpg',
    'assets/dog.jpg',
    'assets/squirrel.jpg',
    'assets/lion.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );

  }

  contentBox(context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: Color(0xFFEDB59E),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            "Choose your profile picture",
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20.0),
          GridView.builder(
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 1, // Ensure each grid item is a square
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,
            ),
            itemCount: profilePictures.length,
            itemBuilder: (BuildContext context, int index) {
              // Load profile picture from assets
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIndex = index; // Update selected index
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: selectedIndex == index ? Color(0xFF95491E) : Colors.transparent,
                      width: 4.0,
                    ),
                    borderRadius: BorderRadius.circular(70), // Half of avatar radius
                  ),
                  child: CircleAvatar(
                    radius: 35, // 70 / 2
                    backgroundImage: AssetImage(profilePictures[index]),
                  ),
                ),
              );
            },
          ),
          SizedBox(height: 25.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close dialog on cancel
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFF5CCB4)), // background color
                  foregroundColor: MaterialStateProperty.all<Color>(Color(0xFF95491E)), // text color
                ),
                child: Text("Cancel"),
              ), 
              SizedBox(width: 20),
              ElevatedButton(
                onPressed: () {
                  // Perform save action here
                  if (selectedIndex != -1) {
                    print("Selected profile picture index: $selectedIndex");
                  } else {
                    print("No profile picture selected");
                  }
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF95491E)), // background color
                  foregroundColor: MaterialStateProperty.all<Color>(Color(0xFFF5CCB4)), // text color
                ),
                child: Text("Save"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text("Profile Picture Dialog"),
      ),
      body: Center(
        child: Builder(
          builder: (BuildContext context) {
            return ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return ProfilePictureDialog();
                  },
                );
              },
              child: Text("Show Profile Picture Dialog"),
            );
          },
        ),
      ),
    ),
  ));
}
