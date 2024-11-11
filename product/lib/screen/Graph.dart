// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fl_chart/fl_chart.dart';

class Graph extends StatefulWidget {
  const Graph({super.key});

  // This widget is the root of your application.
  @override
  GraphState createState() => GraphState();
}

class GraphState extends State<Graph> {
  static const TextStyle optionStyle = TextStyle(fontSize: 25, fontWeight: FontWeight.bold);
  double _progress = 0;
  List<int> rgbo = [63, 81, 181];
  double _opacity = 1.0;

  @override
  Widget build(BuildContext context) {
    // 列方向に指定
    
    final screenWidth = MediaQuery.of(context).size.width;
    return 
    SingleChildScrollView(
      child: 
    Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      // 子要素
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: screenWidth * 0.95,
            height: screenWidth * 0.95 * 0.65,
            child:
        // グラフ
        BarChart(
            BarChartData(
              // 
              borderData: FlBorderData(
                border: const Border(
                  top: BorderSide.none,
                  right: BorderSide.none,
                  left: BorderSide(width: 1),
                  bottom: BorderSide(width: 1),
                ),
              ),
              // タイトル
              titlesData: const FlTitlesData(
                topTitles: AxisTitles(
                  axisNameWidget: Text(
                    "グラフ",
                  ),
                  axisNameSize: 35.0,
                ),
                rightTitles:
                    AxisTitles(sideTitles: SideTitles(showTitles: false)),
              ),
              groupsSpace: 10,
              barGroups: [
                BarChartGroupData(x: 1, barRods: [
                  BarChartRodData(toY: 1, width: 15, color: Colors.blue),
                ]),
                BarChartGroupData(x: 2, barRods: [
                  BarChartRodData(toY: 20, width: 15, color: Colors.blue),
                ]),
                BarChartGroupData(x: 3, barRods: [
                  BarChartRodData(toY: 30, width: 15, color: Colors.blue),
                ]),
                BarChartGroupData(x: 4, barRods: [
                  BarChartRodData(toY: 60, width: 15, color: Colors.blue),
                ]),
                BarChartGroupData(x: 5, barRods: [
                  BarChartRodData(toY: 90, width: 15, color: Colors.blue),
                ]),
                BarChartGroupData(x: 6, barRods: [
                  BarChartRodData(toY: 1000, width: 15, color: Colors.blue),
                ]),
                BarChartGroupData(x: 7, barRods: [
                  BarChartRodData(toY: 90, width: 15, color: Colors.blue),
                ]),
              ],
            ),
          ),),
          ),
        // 摂取した食品一覧
      ]
    ));
  }
}
// settings設定アイコン、search検索アイコン



