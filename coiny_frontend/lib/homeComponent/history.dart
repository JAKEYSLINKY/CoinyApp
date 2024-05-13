import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class history extends StatefulWidget {
  const history({Key? key, required this.transactionData});
  final List<Map<String, dynamic>> transactionData;

  @override
  State<history> createState() => _HistoryState();
}

class _HistoryState extends State<history> {

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
              children: widget.transactionData.map((transaction) {
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
