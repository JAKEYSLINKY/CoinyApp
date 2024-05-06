// ignore_for_file: non_constant_identifier_names, prefer_interpolation_to_compose_strings, camel_case_types
import 'package:coiny_frontend/barGraph/bar_Graph.dart';
import 'package:flutter/material.dart';

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
              const Padding(
                padding: EdgeInsets.only(right: 220, top: 60),
                child: Text(
                  'Stat',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 240,
                width: 300,
                child: MyBarGraph(financial: financial),
              ),
              const SizedBox(height: 80),
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
            padding:
                const EdgeInsets.only(bottom: 14.0, left: 16.0, right: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Saved", style: TextStyle(fontSize: 20)),
                Text(Saved.toString() + "฿",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20)),
              ],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(bottom: 14.0, left: 16.0, right: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Usable Money", style: TextStyle(fontSize: 20)),
                Text(UsableMoney.toString() + "฿",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20)),
              ],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(bottom: 14.0, left: 16.0, right: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Used", style: TextStyle(fontSize: 20)),
                Text(Used.toString() + "฿",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20)),
              ],
            ),
          ),
          const Divider(
            color: Color(0xFFEDB59E),
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
