import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Monthly calorie bar chart',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(title: const Text('Monthly calorie bar chart')),
        body: const Center(child: MonthlyCalBarChart(title: 'Title')),
      ),
    );
  }
}

class MonthlyCalBarChart extends StatefulWidget {
  const MonthlyCalBarChart({super.key, required this.title});

  final String title;

  @override
  State<MonthlyCalBarChart> createState() => _MonthlyCalBarChart();
}

class _MonthlyCalBarChart extends State<MonthlyCalBarChart> {
  // 選択された棒グラフ（初期値は今日）
  int selectedIndex = 27;

  // 推奨摂取カロリー（±200の部分が背景オレンジ）
  final int appropriateCal = 2000;

  // 日付と対応するカロリーデータ
  List<BarData> datas = [
    BarData(DateTime(2024, 10, 28), 1800, 57,  69, 268),
    BarData(DateTime(2024, 10, 29), 2100, 120, 53, 300),
    BarData(DateTime(2024, 10, 30), 2000, 115, 60, 290),
    BarData(DateTime(2024, 10, 31), 2600, 90,  55, 300),
    BarData(DateTime(2024, 11, 1),  1800, 100, 50, 300),
    BarData(DateTime(2024, 11, 2),  2100, 70,  65, 250),
    BarData(DateTime(2024, 11, 3),  1200, 100, 50, 300),
    BarData(DateTime(2024, 11, 4),  1800, 57,  69, 268),
    BarData(DateTime(2024, 11, 5),  2100, 120, 53, 300),
    BarData(DateTime(2024, 11, 6),  2000, 115, 60, 290),
    BarData(DateTime(2024, 11, 7),  2600, 90,  55, 300),
    BarData(DateTime(2024, 11, 8),  1800, 100, 50, 300),
    BarData(DateTime(2024, 11, 9),  2100, 70,  65, 250),
    BarData(DateTime(2024, 11, 10), 1200, 100, 50, 300),
    BarData(DateTime(2024, 11, 11), 1800, 57,  69, 268),
    BarData(DateTime(2024, 11, 12), 2100, 120, 53, 300),
    BarData(DateTime(2024, 11, 13), 2000, 115, 60, 290),
    BarData(DateTime(2024, 11, 14), 2600, 90,  55, 300),
    BarData(DateTime(2024, 11, 15), 1800, 100, 50, 300),
    BarData(DateTime(2024, 11, 16), 2100, 70,  65, 250),
    BarData(DateTime(2024, 11, 17), 1200, 100, 50, 300),
    BarData(DateTime(2024, 11, 18), 1800, 57,  69, 268),
    BarData(DateTime(2024, 11, 19), 2100, 120, 53, 300),
    BarData(DateTime(2024, 11, 20), 2000, 115, 60, 290),
    BarData(DateTime(2024, 11, 21), 2600, 90,  55, 300),
    BarData(DateTime(2024, 11, 22), 1800, 100, 50, 300),
    BarData(DateTime(2024, 11, 23), 2100, 70,  65, 250),
    BarData(DateTime(2024, 11, 24), 1200, 100, 50, 300),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    MaterialColor getBarColor(int value, int appropriateMinCal, int appropriateMaxCal) {
      if (appropriateMinCal <= value && value <= appropriateMaxCal) {
        return Colors.blue;
      }
      return Colors.grey;
    }

    return Center(
      child: Column(
        children: [
          // 棒グラフ
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: screenWidth * 0.95,
              height: screenWidth * 0.95 * 0.33,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceEvenly,
                  maxY: 3000,
                  barTouchData: BarTouchData(
                    enabled: false,
                    touchCallback: (FlTouchEvent event, barTouchResponse) {
                      if (event.runtimeType == FlTapDownEvent && barTouchResponse != null) {
                        final index = barTouchResponse.spot?.touchedBarGroupIndex;
                        // indexにintの値が入っているか
                        if (index != null && index >= 0 && index < datas.length) {
                          setState(() {
                            selectedIndex = index;
                          });
                        }
                      }
                    },
                  ),
                  titlesData: FlTitlesData(
                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    leftTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        reservedSize: 24,
                        showTitles: true,
                        getTitlesWidget: (double value, TitleMeta meta) {
                          // x軸の値を日付フォーマットで表示（一番はじめのデータと1日のデータは月も表示）
                          String formattedDate = '';
                          if (value % 4 == 0) {
                            formattedDate = datas[value.toInt()].getDayString();
                            if (value == 0.0 || formattedDate == '1') {
                              formattedDate = datas[value.toInt()].getFormattedDate();
                            }
                          }
                          return SideTitleWidget(
                            axisSide: meta.axisSide,
                            child: Text(formattedDate),
                          );
                        },
                        interval: 1,
                      ),
                    ),
                    rightTitles: const AxisTitles(
                      sideTitles: SideTitles(
                        reservedSize: 30,
                        showTitles: true,
                        interval: 1000,
                      )
                    )
                  ),
                  borderData: FlBorderData(
                    show: false,
                  ),
                  barGroups: List.generate(datas.length, (index) {
                    return BarChartGroupData(
                      x: index,
                      barRods: [
                        BarChartRodData(
                          toY: datas[index].calorie.toDouble(),
                          color: getBarColor(datas[index].calorie, appropriateCal - 200, appropriateCal + 200),
                          width: 10,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ],
                    );
                  }),
                  gridData: const FlGridData(
                    horizontalInterval: 1000,
                    drawVerticalLine: false,
                  ),
                  rangeAnnotations: RangeAnnotations(
                    horizontalRangeAnnotations: [
                      HorizontalRangeAnnotation(
                        y1: 1800,
                        y2: 2200,
                        color: Colors.orange.withOpacity(0.3),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          // 選択された日の詳細
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: screenWidth * 0.95,
              height: screenWidth * 0.95 * 0.6,
              child: ColoredBox(
                color: Colors.blue,
                child: Column(
                  children: [
                    Text(
                      datas[selectedIndex].getFormattedDate()
                    ),
                    Text(
                      '${datas[selectedIndex].calorie}kcal'
                    ),
                    Row(
                      children: [
                        Text(
                          'Protein ${datas[selectedIndex].protein}g'
                        ),
                        Text(
                          'Fat ${datas[selectedIndex].fat}g'
                        ),
                        Text(
                          'Carbonhydrate ${datas[selectedIndex].carbonhydrate}g'
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          // 一か月の平均
          Padding(
            padding: EdgeInsets.all(16.0),
            child: SizedBox(
              width: screenWidth * 0.95,
              height: screenWidth * 0.95 * 0.6,
              child: ColoredBox(
                color: Colors.blue,
                child: Column(
                  children: [
                    Text(
                      '${datas[0].getFormattedDate()} ~ ${datas[datas.length -1].getFormattedDate()}'
                    ),
                    Text(
                      // よくわからんけど平均を返却
                      '${(datas.map((m) => m.calorie).reduce((a, b) => a + b) / datas.length).floor()}kcal'
                    ),
                    Row(
                      children: [
                        Text(
                          'Protein ${(datas.map((m) => m.protein).reduce((a, b) => a + b) / datas.length).floor()}g'
                        ),
                        Text(
                          'Fat ${(datas.map((m) => m.fat).reduce((a, b) => a + b) / datas.length).floor()}g'
                        ),
                        Text(
                          'Carbonhydrate ${(datas.map((m) => m.carbonhydrate).reduce((a, b) => a + b) / datas.length).floor()}g'
                        )
                      ],
                    )
                  ],
                ),
              )
            )
          )
        ]
      )
    );
  }
}

class BarData {
  final DateTime date;
  final int calorie;
  final int protein;
  final int fat;
  final int carbonhydrate;

  BarData(
    this.date,
    this.calorie,
    this.protein,
    this.fat,
    this.carbonhydrate
  );

  String getFormattedDate() {
    return DateFormat('M/d').format(date);
  }

  String getDayString() {
    return DateFormat('d').format(date);
  }

  List<int> getPFCInt() {
    return [protein, fat, carbonhydrate];
  }
}