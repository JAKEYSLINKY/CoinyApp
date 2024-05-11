// ignore_for_file: non_constant_identifier_names, prefer_interpolation_to_compose_strings, camel_case_types
import 'dart:convert';

import 'package:coiny_frontend/barGraph/bar_Graph.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class stat extends StatefulWidget {
  const stat({super.key});

  @override
  State<stat> createState() => _statState();
}

class _statState extends State<stat> {
  final int userId = 1;
  List<double> financial = [0, 0, 0];
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    getSave();
  }

  void getSave() async {
    try {
      final apiURL = 'http://10.0.2.2:4000/plans/get?userId=$userId';
      final response = await http.get(
        Uri.parse(apiURL),
        headers: <String, String>{'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        print('getSave and currentSave');
        setState(() {
          financial = parseMoney(response.body);
          isLoading = false; // Implement parseGoals method
        });
      }
    } catch (e) {
      print('ERROR: $e');
      setState(() {
        isLoading = false; // Set isLoading to false in case of error
      });
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFFFE2D2),
        body: SingleChildScrollView(
          child: Center(
            child: isLoading
                ? CircularProgressIndicator() // Show loading indicator while data is being fetched
                : Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 15, right: 220),
                        child: Text(
                          'Stat',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 30),
                        child: SizedBox(
                          height: 240,
                          width: 280,
                          child: MyBarGraph(financial: financial),
                        ),
                      ),
                      const SizedBox(height: 75),
                      StatInfo(
                        Saved: financial[0].toInt(),
                        UsableMoney: financial[1].toInt(),
                        Used: financial[2].toInt(),
                      )
                    ],
                  ),
          ),
        ));
  }
}

// ignore: must_be_immutable
class StatInfo extends StatelessWidget {
  int Saved;
  int UsableMoney;
  int Used;
  StatInfo({
    required this.Saved,
    required this.UsableMoney,
    required this.Used,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 207,
      width: 324,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: statdata(name: "Current Save", value: Saved),
          ),
          statdata(name: "Usable Money", value: UsableMoney),
          statdata(name: "Used", value: Used),
          const Divider(
            color: Color(0xFFEDB59E),
            height: 20,
            thickness: 4,
            indent: 16,
            endIndent: 16,
          ),
          Padding(
            padding:
                const EdgeInsets.only(bottom: 10.0, left: 16.0, right: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Total",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                Text((Saved + UsableMoney).toString() + "฿",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20)),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class statdata extends StatelessWidget {
  const statdata({super.key, required this.name, required this.value});

  final String name;
  final int value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0, left: 16.0, right: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(name, style: const TextStyle(fontSize: 20)),
          Text(value.toString() + "฿",
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
        ],
      ),
    );
  }
}

List<double> parseMoney(String responseBody) {
  try {
    Map<String, dynamic> jsonResponse = jsonDecode(responseBody);
    if (jsonResponse.containsKey('data')) {
      Map<String, dynamic> data = jsonResponse['data'];
      int currentSave = data['currentSave'] ?? 0;
      int monthly = data['monthly'] ?? 0;
      int save = data['save'] ?? 0;
      int UsableMoney = currentSave - save;
      int Used = -(monthly - currentSave);
      print('currentSave: $currentSave' +
          ' UsableMoney: $UsableMoney' +
          ' Used: $Used');
      return [currentSave.toDouble(), UsableMoney.toDouble(), Used.toDouble()];
    }
    return [];
  } catch (e) {
    print('Error parsing JSON: $e');
    return [];
  }
}
