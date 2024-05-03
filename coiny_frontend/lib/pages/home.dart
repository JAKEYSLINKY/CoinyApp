import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
                  Profile(),
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
        bottomNavigationBar: MyBottomNavigationBar(),
      ),
    );
  }
}

class AddCategory extends StatelessWidget {
  const AddCategory({super.key});

  static const List<String> iconNames = [
    'home',
    'work',
    'school',
    'restaurant',
    'shopping',
    'health',
    'fitness',
    'sports',
    'music',
    'movie',
    'book',
    'game',
    'art',
    'travel',
    'nature',
    'car',
    'bicycle',
    'plane',
    'train',
    'bus',
    'ship',
    'rocket',
    'star',
    'sun',
    'moon',
  ];

  @override
  Widget build(BuildContext context) {
    // List<Widget> iconWidgets = iconNames.map((iconName) {
    //   return GestureDetector(
    //     onTap: () => showDialog<String>(
    //       context: context,
    //       builder: (BuildContext context) => AlertDialog(
    //         title: const Text('New Category'),
    //         content: const Column(
    //           children: [],
    //         ),
    //         actions: <Widget>[
    //           TextButton(
    //             onPressed: () => Navigator.pop(context, 'Cancel'),
    //             child: const Text('Cancel'),
    //           ),
    //           TextButton(
    //             onPressed: () => Navigator.pop(context, 'OK'),
    //             child: const Text('OK'),
    //           ),
    //         ],
    //       ),
    //     ),
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color(0xFFEDB59E),
      ),
      child: const Center(
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );

    // .toList();
    // // Return a widget
    // return ListView(
    //   children: iconWidgets,
    // );
  }
}

class Category {
  final String name;
  final String iconName;

  Category(this.name, this.iconName);
}

class CategoriesList extends StatelessWidget {
  CategoriesList({super.key});

  final List<Category> categories = [
    Category('Entertain', 'entertain'),
    Category('Coffee', 'coffee'),
    Category('Bus', 'bus'),
    Category('Food', 'restaurant'),
    Category('Shoppingggggggg', 'shopping'),
    Category('Shoppingggggggg', 'shopping'),
    // Add more categories with their associated icon names as needed
  ];

  final Map<String, IconData> iconDataMap = {
    'entertain': Icons.sports_esports,
    'coffee': Icons.coffee,
    'bus': Icons.directions_bus,
    'restaurant': Icons.restaurant,
    'shopping': Icons.shopping_bag,
    // Add more mappings as needed
  };

  @override
  Widget build(BuildContext context) {
    List<Widget> categoryWidgets = categories.map((category) {
      IconData iconData = iconDataMap[category.iconName] ?? Icons.category;

      return Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color(0xFFF98A4C),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              iconData,
              color: Colors.white,
              size: 40,
            ),
            Text(
              category.name.length > 10
                  ? category.name.substring(0, 10) + '...'
                  : category.name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      );
    }).toList();

    // Add "Other" category widget
    categoryWidgets.add(
      Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color(0xFFF98A4C),
        ),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.more_horiz,
              color: Colors.white,
              size: 40,
            ),
            Text(
              'Other',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );

    return ListView(
      shrinkWrap: true,
      children: <Widget>[
        Wrap(
          spacing: 10, //horizontal space
          runSpacing: 10, //vertical space
          alignment: WrapAlignment.spaceBetween,
          direction: Axis.horizontal,
          children: categoryWidgets,
        ),
      ],
    );
  }
}

class History extends StatelessWidget {
  const History({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
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
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("30 April 2024", style: TextStyle(fontSize: 10)),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Coffee",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      Text("100B"),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Shopping",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      Text("1000B"),
                    ],
                  ),
                  // Add more Text widgets as needed
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ClipOval(
          child: Image.asset(
            'assets/rabbit.jpg',
            width: 50,
            height: 50,
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }
}

class Mascot extends StatelessWidget {
  const Mascot({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
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
          // Box of text
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: const Text(
                'Howdy, I am Coiny. And I will help you manage your money!',
                style: TextStyle(fontSize: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ShowMoney extends StatelessWidget {
  const ShowMoney({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Your profile content here
          Text(
            "Usable Money :",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Text(
            "Daily Expenses :",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ],
      ),
    );
  }
}

class MyBottomNavigationBar extends StatelessWidget {
  const MyBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Container(
        height: 60,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        color: const Color(0xFFEDB59E),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.home),
              onPressed: () {
                // Navigate to home screen
              },
            ),
            IconButton(
              icon: const Icon(Icons.leaderboard),
              onPressed: () {
                // Navigate to search screen
              },
            ),
            IconButton(
              icon: const Icon(Icons.library_books),
              onPressed: () {
                // Navigate to notifications screen
              },
            ),
            IconButton(
              icon: const Icon(Icons.emoji_events),
              onPressed: () {
                // Navigate to profile screen
              },
            ),
          ],
        ),
      ),
    );
  }
}
