import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddCategoryDialog extends StatefulWidget {
  AddCategoryDialog({Key? key}) : super(key: key);

  @override
  _AddCategoryDialogState createState() => _AddCategoryDialogState();
}

class _AddCategoryDialogState extends State<AddCategoryDialog> {
  final TextEditingController _nameController = TextEditingController();
  String _selectedIconName = '';

  void _postCategory() async {
    try {
      final apiUrl = 'http://10.0.2.2:4000/categories/create';
      final response = await http
          .post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'userId': 1,
          'name': _nameController.text,
          'iconName': _selectedIconName,
        }),
      )
          .catchError((e) {
        // Handle error here
        print('Error occurred during HTTP POST request: $e');
        throw Exception('Failed to post data: $e');
      });

      if (response.statusCode == 200) {
        print('Category created successfully(200)');
        Navigator.pop(context, 'OK');
      } else {
        throw Exception('Failed to create category');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Color(0xFFEDB59E),
      title: Text('New Category'),
      content: SingleChildScrollView(
        child: Column(
          children: [
            GridView.count(
              crossAxisCount: 5,
              shrinkWrap: true,
              childAspectRatio: 1.0,
              children: iconDataMap.entries.map((entry) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedIconName = entry.key;
                    });
                  },
                  child: Column(
                    children: [
                      Icon(
                        entry.value,
                        color: _selectedIconName == entry.key
                            ? Colors.blue // Change the color when selected
                            : Colors.white,
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Name',
                    style: TextStyle(fontSize: 20.0),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Color(0xFFFFF3EC),
                        ),
                        child: TextFormField(
                          controller: _nameController,
                          decoration: InputDecoration(
                            hintText: 'Ex. Movies',
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 12.0,
                              horizontal: 15.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: TextButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Color(0xFFF5CCB4)),
                ),
                onPressed: () => Navigator.pop(context, 'Cancel'),
                child: const Text(
                  'Cancel',
                  style: TextStyle(color: Color(0xFF95491E)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: TextButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Color(0xFF95491E)),
                ),
                onPressed: () {
                  _postCategory();

                  Navigator.pop(context, 'OK');
                  print('Category Name: ${_nameController.text}');
                  print('Selected Icon Name: $_selectedIconName');
                },
                child: const Text(
                  'OK',
                  style: TextStyle(color: Color(0xFFEDB59E)),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

final Map<String, IconData> iconDataMap = {
  'music': Icons.music_note,
  'baby': Icons.child_friendly,
  'bag': Icons.business_center,
  'home': Icons.home,
  'sun': Icons.brightness_5,
  'bus': Icons.directions_bus,
  'rabbit': Icons.cruelty_free,
  'fastfood': Icons.fastfood,
  'restaurant': Icons.restaurant,
  'heart': Icons.favorite,
  'flower': Icons.local_florist,
  'gasstation': Icons.local_gas_station,
  'cart': Icons.shopping_cart,
  'localmall': Icons.local_mall,
  'cameraroll': Icons.camera_roll,
  'tag': Icons.loyalty,
  'entertain': Icons.sports_esports,
  'flag': Icons.flag,
  'fitness': Icons.fitness_center,
  'alert': Icons.crisis_alert,
  'coffee': Icons.coffee,
  'location': Icons.location_on,
  'chair': Icons.chair,
  'category': Icons.category,
  'other': Icons.more_horiz,
  // Add more mappings as needed
};
