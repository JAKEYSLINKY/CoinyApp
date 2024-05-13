import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Category {
  final String iconName;
  final String name;

  Category(this.iconName, this.name);

  @override
  String toString() {
    return 'Category{iconName: $iconName, name: $name}';
  }
}

class categoriesList extends StatefulWidget {
  categoriesList(
      {super.key, required this.categories, required this.reloadData});
  final List<Category> categories;
  final Function reloadData;
  @override
  State<categoriesList> createState() => _CategoriesListState();
}

class _CategoriesListState extends State<categoriesList> {
  final urlpostwithdraw = 'http://10.0.2.2:4000/transactions/withdraw';

  final TextEditingController _amountController = TextEditingController();

  Future<void> _postData(String categoryName) async {
    try {
      final response = await http.post(
        Uri.parse(urlpostwithdraw),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'userId': 2,
          'category': categoryName,
          'amount': _amountController.text,
        }),
      );
      if (response.statusCode == 200) {
        print('withdraw created successfully');
      } else {
        throw Exception('Failed to create withdraw');
      }
    } catch (e) {
      print('$e');
      throw Exception('Error occurred during HTTP request: $e');
    }
  }

  final Map<String, IconData> iconDataMap = {
    'music': Icons.music_note,
    'baby': Icons.child_friendly,
    'bag': Icons.business_center,
    'home': Icons.gite,
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
    'location': Icons.fmd_good,
    'chair': Icons.chair,
    'category': Icons.category,
    'other': Icons.more_horiz,
    // Add more mappings as needed
  };

  void _showCategoryDialog(
      BuildContext context, IconData iconData, String categoryName) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color(0xFFEDB59E),
          title: Column(
            children: [
              Icon(
                iconData,
                color: Colors.white,
                size: 40,
              ),
              Text(
                categoryName,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 0.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Color(0xFFFFF3EC),
                        ),
                        child: TextFormField(
                          controller: _amountController,
                          decoration: InputDecoration(
                            hintText: 'Ex. 100 ฿',
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
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  await _postData(categoryName);
                  await widget.reloadData();
                  Navigator.pop(context);
                },
                child: Text('Save'),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> categoryWidgets = widget.categories.map((C) {
      IconData iconData = iconDataMap[C.iconName] ??
          Icons
              .category; //if iconDataMap[category.iconName] is null, use Icons.category

      return ElevatedButton(
        onPressed: () {
          _showCategoryDialog(context, iconData, C.name);
        },
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          primary: const Color(0xFFF98A4C),
        ),
        child: SizedBox(
          width: 100,
          height: 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                iconData,
                color: Colors.white,
                size: 40,
              ),
              Text(
                C.name.length > 10 ? C.name.substring(0, 10) + '...' : C.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      );
    }).toList();

    return ListView(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: <Widget>[
        Wrap(
          spacing: 10, //horizontal space
          runSpacing: 10, //vertical space
          alignment: WrapAlignment.start,
          direction: Axis.horizontal,
          children: categoryWidgets,
        ),
      ],
    );
  }
}
