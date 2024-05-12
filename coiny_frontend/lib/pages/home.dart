import 'package:flutter/material.dart';
import '../components/addCategory.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            color: Color(0xFFFFE2D2),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Mascot(),
                  ShowMoney(),
                  CategoriesList(),
                  AddCategory(),
                  History(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Mascot extends StatelessWidget {
  const Mascot({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        ClipOval(
          child: Image.asset(
            'assets/rabbit.jpg',
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(width: 5),
        // Box of text with positioned carrot image
        Expanded(
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 13.0),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  height: 74,
                  width: 225,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Howdy, I am Coiny. And I will help you manage your money!',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // Positioned carrot image at bottom right
              const Positioned(
                bottom: -14.0, // Adjust position as needed
                right: -14.0, // Adjust position as needed
                child: Image(
                  image: AssetImage('assets/carrot.png'),
                  height: 60,
                  width: 60,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ShowMoney extends StatefulWidget {
  const ShowMoney({super.key});

  @override
  State<ShowMoney> createState() => _ShowMoneyState();
}

class _ShowMoneyState extends State<ShowMoney> {
  final url = 'http://10.0.2.2:4000/transactions/balance';
  int userId = 2;
  int usableMoney = 0;
  double dailyExpense = 0.0;

  @override
  void initState() {
    super.initState();
    _getData();
  }

  Future<void> _getData() async {
    try {
      final response = await http.get(Uri.parse('$url?userId=$userId'));
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = jsonDecode(response.body);
        setState(() {
          usableMoney = jsonData['data']['usableMoney'];
          dailyExpense = jsonData['data']['currentDailyExpense'];
        });
        print('Received data: $jsonData');
      } else {
        throw Exception('Failed to fetch data: ${response.statusCode}');
      }
    } catch (e) {
      print('$e');
      throw Exception('Error occurred during HTTP request: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 32.0, bottom: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Your profile content here
          Row(
            children: [
              Text(
                "Usable Money :",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Text(
                " $usableMoney ฿",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                "Daily Expenses :",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Text(
                " ${dailyExpense.toInt()} ฿",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class Category {
  final String iconName;
  final String name;

  Category(this.iconName, this.name);

  @override
  String toString() {
    return 'Category{iconName: $iconName, name: $name}';
  }
}

class CategoriesList extends StatefulWidget {
  CategoriesList({super.key});

  @override
  State<CategoriesList> createState() => _CategoriesListState();
}

class _CategoriesListState extends State<CategoriesList> {
  final List<Category> categories = [
    Category('entertain', 'Entertain'),
    Category('coffee', 'Coffee'),
    Category('bus', 'Bus'),
    Category('restaurant', 'food'),
    Category('cart', 'Shopping'),
    Category('other', 'Other'),
    // Add more categories with their associated icon names as needed
  ];

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

  final url = 'http://10.0.2.2:4000/categories/get';
  int userId = 2;

  @override
  void initState() {
    super.initState();
    _getData();
  }

  Future<void> _getData() async {
    try {
      final response = await http.get(Uri.parse('$url?userId=$userId'));
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = jsonDecode(response.body);
        List<Category> fetchedCategories = List<Category>.from(jsonData['data']
            .map((category) =>
                Category(category['iconName'], category['name'])));
        setState(() {
          categories.addAll(fetchedCategories);
          print('Updated categories: $categories');
        });
      } else {
        throw Exception('Failed to fetch data: ${response.statusCode}');
      }
    } catch (e) {
      print('$e');
      throw Exception('Error occurred during HTTP request: $e');
    }
  }

  final TextEditingController _amountController = TextEditingController();
  final urlwithdraw = 'http://10.0.2.2:4000/transactions/withdraw';

  Future<void> _postData(String categoryName) async {
    try {
      final response = await http.post(
        Uri.parse(urlwithdraw),
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
        Navigator.pop(context, 'OK');
      } else {
        throw Exception('Failed to create withdraw');
      }
    } catch (e) {
      print('$e');
      throw Exception('Error occurred during HTTP request: $e');
    }
  }

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
                onPressed: () {
                  _postData(categoryName);
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
    List<Widget> categoryWidgets = categories.map((C) {
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

class AddCategory extends StatelessWidget {
  const AddCategory({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: ElevatedButton(
        onPressed: () {
          showDialog<String>(
              context: context,
              builder: (BuildContext context) => AddCategoryDialog());
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFFEDB59E),
        ),
        child: const Center(
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  final url = 'http://10.0.2.2:4000/transactions/get';
  int userId = 1;
  List<Map<String, dynamic>> _transactionData = [];

  @override
  void initState() {
    super.initState();
    _getData();
  }

  Future<void> _getData() async {
    try {
      final response = await http.get(Uri.parse('$url?userId=$userId'));
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = jsonDecode(response.body);
        List<dynamic> transactions = jsonData['data'];
        setState(() {
          _transactionData = transactions.cast<Map<String, dynamic>>();
        });

        print('Received transaction data: $jsonData');
      } else {
        throw Exception('Failed to fetch data: ${response.statusCode}');
      }
    } catch (e) {
      print('$e');
      throw Exception('Error occurred during HTTP request: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // Your profile content here
        Container(
          margin: const EdgeInsets.only(
              bottom: 10.0), // Add margin only at the bottom
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "History",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              Icon(Icons.history),
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 1),
            color: const Color(0xFFFFF3EC),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: _transactionData.map((transaction) {
                String date = transaction['created'];
                String categoryName = transaction['categories']['name'];
                int amount = transaction['amount'];

                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [Text(date, style: TextStyle(fontSize: 10))],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          categoryName,
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        Text("$amount B")
                      ],
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
