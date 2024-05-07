import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

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
        //bottomNavigationBar: MyBottomNavigationBar(),
      ),
    );
  }
}

class AddCategory extends StatelessWidget {
  const AddCategory({super.key});
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
    Category('Shoppingggggggg', 'cart'),
    Category('Other', 'other'),
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

  @override
  Widget build(BuildContext context) {
    List<Widget> categoryWidgets = categories.map((category) {
      IconData iconData = iconDataMap[category.iconName] ??
          Icons
              .category; //if iconDataMap[category.iconName] is null, use Icons.category

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

    // // Add "Other" category widget
    // categoryWidgets.add(
    //   Container(
    //     width: 100,
    //     height: 100,
    //     decoration: BoxDecoration(
    //       borderRadius: BorderRadius.circular(10),
    //       color: const Color(0xFFF98A4C),
    //     ),
    //     child: const Column(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: [
    //         Icon(
    //           Icons.more_horiz,
    //           color: Colors.white,
    //           size: 40,
    //         ),
    //         Text(
    //           'Other',
    //           style: TextStyle(
    //             color: Colors.white,
    //             fontSize: 14,
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // );

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
        // Box of text
        Expanded(
          child: Padding(
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
                child: Text(
                  'Howdy, I am Coiny. And I will help you manage your money!',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ShowMoney extends StatelessWidget {
  const ShowMoney({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(top: 32.0, bottom: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Your profile content here
          Text(
            "Usable Money :",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          Text(
            "Daily Expenses :",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
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
      color: const Color(0xFFEDB59E),
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
