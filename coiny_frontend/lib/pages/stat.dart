import 'dart:ffi';

import 'package:coiny_frontend/barGraph/bar_Graph.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class stat extends StatefulWidget {
  const stat({super.key});

  @override
  State<stat> createState() => _statState();
}

class _statState extends State<stat> {
  List<double> financial = [
    8500,
    1050,
    -450,
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFFFE2D2),
        body: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 220, top: 60),
                child: Text(
                  'Stat',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 300,
                width: 300,
                child: MyBarGraph(financial: financial),
              ),
              SizedBox(height: 80),
              StatInfo(
                Saved: financial[0].toInt(),
                UsableMoney: financial[1].toInt(),
                Used: financial[2].toInt(),
              )
            ],
          ),
        ));
  }
}

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
          SizedBox(height: 10),
          Padding(
            padding:
                const EdgeInsets.only(bottom: 14.0, left: 16.0, right: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Saved", style: TextStyle(fontSize: 20)),
                Text(Saved.toString() + "฿",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              ],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(bottom: 14.0, left: 16.0, right: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Usable Money", style: TextStyle(fontSize: 20)),
                Text(UsableMoney.toString() + "฿",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              ],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(bottom: 14.0, left: 16.0, right: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Used", style: TextStyle(fontSize: 20)),
                Text(Used.toString() + "฿",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              ],
            ),
          ),
          Divider(
            color: const Color(0xFFEDB59E),
            height: 20,
            thickness: 4,
            indent: 16,
            endIndent: 16,
          ),
          Padding(
            padding:
                const EdgeInsets.only(bottom: 14.0, left: 16.0, right: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Total",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                Text((Saved + UsableMoney).toString() + "฿",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
