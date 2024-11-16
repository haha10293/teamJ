import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
// 自作widget
import 'package:product/widgets/add_food.dart';
import 'package:product/widgets/add_ingredients.dart';

// 追加画面
class Add extends StatefulWidget {
  const Add({super.key});

  @override
  AddState createState() => AddState();
}

class AddState extends State<Add> {
  // 各追加画面インスタンス化
  static const add_food = AddFood();
  static const add_ingredients = AddIngredients();
   // ドロップダウンリストのアイテム
  final List<String> items = ['g', 'ml', 'cc', '個', '袋'];
  // クラスメンバとして初期化
  String? selectedValue = 'g'; 


  // 入力欄widgets作成
  Widget textForm(int t, r, b, l, String label, hint, suffix, double deviceWidth) {
    return 
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(top: t.toDouble(), right: r.toDouble(), bottom: b.toDouble(), left: l.toDouble()),
            child: SizedBox(
              width: deviceWidth-50,
              child: TextField(
                keyboardType: TextInputType.number, // キーボードの種類を指定
                onChanged: (String value) {
                  setState(() {
                  // _BookName = value;
                  });
                },
                // フォームの装飾
                decoration: InputDecoration(
                  labelText: label,
                  hintText: hint,
                  hintStyle: TextStyle(color: Colors.grey, fontWeight: FontWeight.w300),
                  fillColor: Colors.yellow[50],
                  filled: true, //これ入れないとfillColorが表示されない
                  suffix: Text(suffix),
                  suffixStyle: TextStyle(color: const Color.fromARGB(255, 0, 0, 0), fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ),
        ],
      );
  }

  @override
  Widget build(BuildContext context) {
    // デバイスの画面幅を変数に入れる 
    final double deviceHeight = MediaQuery.of(context).size.height;
    final double deviceWidth = MediaQuery.of(context).size.width;
    return const DefaultTabController(
      length: 3,
      child: Scaffold(
        body: Column(
          children: [
            TabBar(
              labelColor: Colors.black,
              tabs: [
                Tab(text: "食品"),
                Tab(text: "食材"),
                Tab(text: "自炊"),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  // 食品追加画面
                  add_food,
                  // 食材追加画面
                  add_ingredients,
                  // 自炊追加画面
                  Center(child: Text("View 3")),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
