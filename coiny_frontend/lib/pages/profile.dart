import 'package:coiny_frontend/components/chooseProfile.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(ProfilePage());
}

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ProfileScreen(onBack: () {
      Navigator.of(context).pop(); // Navigate back to the previous page
    });
  }
}

class ProfileScreen extends StatefulWidget {
  final Function() onBack;

  ProfileScreen({required this.onBack});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _name = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFE2D2),
      appBar: AppBar(
        backgroundColor: Color(0xFFE2D2),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: widget.onBack,
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Profile',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 40),
            Stack(
              children: [
                CircleAvatar(
                  radius: 90,
                  // You can replace the AssetImage with your profile image
                  backgroundImage: AssetImage('assets/profile.jpg'),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color:
                          Colors.white, // Background color of the pencil icon
                    ),
                    padding:
                        EdgeInsets.all(5), // Padding around the pencil icon
                    child: IconButton(
                      icon: Icon(Icons.edit, color: Color(0xFF95491E)),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return ProfilePictureDialog();
                          },
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: TextField(
                style:
                    TextStyle(color: Colors.black), // Set text color to black
                decoration: InputDecoration(
                  labelText: 'Name',
                  filled: true, // Set to true to fill the background with white
                  fillColor: Color(0xFFFFF3EC), // Set the fill color to white
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: BorderSide.none, // Remove the border
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    _name = value;
                  });
                },
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: 150, // Adjust width as needed
              height: 35,
              child: ElevatedButton(
                onPressed: () {
                  // Save button logic
                  print('Name saved: $_name');
                },
                child: Text('Save'),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Color(0xFFF5CCB4)), // Change background color
                  foregroundColor: MaterialStateProperty.all<Color>(
                      Color(0xFF95491E)), // Change text color
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 50),
            SizedBox(
              width: 150,
              height: 35,
              child: ElevatedButton(
                onPressed: () {
                  // Logout button logic
                  print('Logged out');
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.logout, color: Colors.white), // Icon
                    SizedBox(width: 5), // Add some space between icon and text
                    Text(
                      'Logout',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Color(0xFFEB6363)), // Background color
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
