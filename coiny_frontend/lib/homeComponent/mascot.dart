import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class mascot extends StatefulWidget {
  const mascot({super.key});

  @override
  State<mascot> createState() => _mascotState();
}

class _mascotState extends State<mascot> {
  var random = Random();
  late int randomNumber = random.nextInt(10);

  final List<String> messages = [
    'Howdy, I am Coiny. And I will help you manage your money! Howdy, I am Coiny. And I will help you manage your money!',
    'Hello! Coiny here, let\'s get your finances in order! Howdy, I am Coiny. And I will help you manage your money!',
    'Greetings from Coiny! Ready to save some money? Howdy, I am Coiny. And I will help you manage your money!',
    'Hi there! I\'m Coiny, your financial assistant. Howdy, I am Coiny. And I will help you manage your money!',
    'Hey! Coiny at your service for all money matters. Howdy, I am Coiny. And I will help you manage your money!',
    'Welcome! Coiny is here to help you budget wisely.Howdy, I am Coiny. And I will help you manage your money!',
    'Good day! Coiny will assist you in tracking expenses. Howdy, I am Coiny. And I will help you manage your money!',
    'Hi! Coiny reporting for duty to manage your funds. Howdy, I am Coiny. And I will help you manage your money!',
    'Salutations! Coiny will help you keep your money in check. Howdy, I am Coiny. And I will help you manage your money!',
    'Hello! Coiny is ready to support your financial goals. Howdy, I am Coiny. And I will help you manage your money!'
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        ClipOval(
          child: Image.asset(
            'assets/RabbitMascot.png',
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(width: 5),
        Expanded(
          child: Stack(
            children: [
              SingleChildScrollView(
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
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            messages[randomNumber],
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const Positioned(
                bottom: -8.0,
                right: 0,
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
