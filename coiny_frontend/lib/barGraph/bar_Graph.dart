import 'package:coiny_frontend/barGraph/barData.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class MyBarGraph extends StatelessWidget {
  final List financial;
  const MyBarGraph({super.key, required this.financial});

  @override
  Widget build(BuildContext context) {
    //initializing the data
    BarData MyBarData = BarData(
      Saved: financial[0],
      UsableMoney: financial[1],
      Used: financial[2],
    );
    MyBarData.initializeBarData();
    return BarChart(BarChartData(
      maxY: financial[0] + financial[1] - financial[2],
      minY: 0,
      gridData: const FlGridData(show: false),
      borderData: FlBorderData(
        show: true,
        border: const Border(
            bottom: BorderSide(
          color: Color(0xFFEDB59E),
          width: 5,
        )),
      ),
      titlesData: const FlTitlesData(
          show: true,
          topTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          rightTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          bottomTitles: AxisTitles(
              sideTitles: SideTitles(
            showTitles: false,
            // getTitlesWidget: getBottonTitles,
          ))),
      barGroups: MyBarData.barData
          .map((data) => BarChartGroupData(x: data.x, barRods: [
                BarChartRodData(
                  toY: data.y,
                  color: const Color(0xFFF5CCB4),
                  width: 69,
                  borderRadius: BorderRadius.circular(10),
                )
              ]))
          .toList(),
    ));
  }
}

// Widget getBottonTitles(double value, TitleMeta meta) {
//   const style = TextStyle(
//     color: Colors.black,
//     fontSize: 12,
//     fontWeight: FontWeight.bold,
//   );

//   Widget text = const Text('');
//   switch (value.toInt()) {
//     case 0:
//       text = const Text(
//         'Saved',
//         style: style,
//       );
//       break;
//     case 1:
//       text = const Text(
//         'Usable Money',
//         style: style,
//       );
//       break;
//     case 2:
//       text = const Text(
//         'Used',
//         style: style,
//       );
//       break;
//   }
//   return SideTitleWidget(child: text, axisSide: meta.axisSide);
// }
