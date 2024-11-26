import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
// 外部ライブラリ
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
// 自作widgets
import 'package:product/screen/add.dart';
import 'package:product/screen/graph.dart';
import 'package:product/widgets/settings.dart';
import 'package:product/screen/nutrition.dart';

// カレンダーローカル対応（日本語）
void main() =>  initializeDateFormatting().then((_) =>runApp(
  const MyApp()
));

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      title: 'MyApp',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.dark, // 追記
        ),
        useMaterial3: true,
      ),

      themeMode: ThemeMode.light,
      // themeMode: ThemeMode.system,
      home: MyBottomNavigationBar(),
    );
  }
}

// 状態クラス
class MyBottomNavigationBar extends StatefulWidget {
  const MyBottomNavigationBar({super.key});

  @override
  State<MyBottomNavigationBar> createState() =>
      _MyBottomNavigationBarState();
}

// 状態保持
class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
    static const nutrition = Nutrition();
    static const graph = Graph();
    static const settings = Settings();
    static const add = Add();

    late int _weekDay = DateTime.now().weekday;
    DateTime _time = DateTime.now();

    // 現在の日付
    DateTime _focusedDay = DateTime.now();
    // 選択中の日付
    DateTime? _selectedDay;   

    // 連番
    int _selectedIndex = 0;

    // フォントの設定
    static const TextStyle optionStyle = TextStyle(fontSize: 50, fontWeight: FontWeight.bold);

    // コンテンツのリスト（Widgetのリスト）
    static const List<Widget> _widgetOptions = <Widget>[
      nutrition,
      graph,
      add,
    ];

    // タップしたタブの連番をセット
    void _onItemTapped(int index) {
      setState(() {
        _selectedIndex = index;
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ヘッダー
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // backgroundColor: const Color.fromARGB(255, 138, 191, 163),
        actions: [
            IconButton(onPressed: (){
              // 設定画面へ遷移
              Navigator.push(context, MaterialPageRoute(builder: (context) => settings));
            }, icon: const Icon(Icons.settings, size: 35,)),
        ],
        title: TextButton(
          onPressed: () {
            DatePicker.showDatePicker(context,
              showTitleActions: true,
              minTime: DateTime(2024, 1, 1),
              maxTime: DateTime(2050, 12, 31),
              onChanged: (date) {
                //　ダイアログを選択するたび
                setState(() {
                  
                });
                print('papiko');
                print(date);
              },
              // 決定後の値
              onConfirm: (date) {
                setState(() {
                  _weekDay = date.weekday;
                  _time = date;
                });
                print('ai');
                print(date);
                // 曜日
                print(_weekDay);
              },
              currentTime: DateTime.now(),
              locale: LocaleType.jp
            );
          },
          child: Text(
            DateFormat('yyyy/MM/dd(E)', "ja_JP").format(_time),
            style: const TextStyle(color: Colors.blue, fontSize: 20),
          ),
        ),
      ),
      // コンテンツ
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      // フッター
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // ボトムタブバー
        items: 
        const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt),
            label: '食事',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.auto_graph_sharp),
            label: 'グラフ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.upload),
            label: '追加',
          ),
        ],
        // 現在選択しているタブ
        currentIndex: _selectedIndex,
        // 選択中の色
        selectedItemColor: Colors.amber[800],
        // タップしたときに発動
        onTap: _onItemTapped,
      ),
    );
  }
}
