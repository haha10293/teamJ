// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:product/widgets/weekly_cal_bar_chart.dart';
import 'package:product/widgets/monthly_cal_bar_chart.dart';

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
    return const DefaultTabController(
      length: 2,
      child: Column(
        children: [
          TabBar(
            tabs: [
              Tab(text: "一週間"),
              Tab(text: "一か月"),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                SingleChildScrollView(
                  child: WeeklyCalBarChart(title: "weekly calorie bar chart"),
                ),
                SingleChildScrollView(
                  child: MonthlyCalBarChart(title: "monthly calorie bar chart")
                )
              ]
            )
          )
        ],
      ),
    );
  }
}
// settings設定アイコン、search検索アイコン



