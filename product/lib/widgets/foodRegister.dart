import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


// 食品項目記録画面
class FoodRegister extends StatefulWidget {
  const FoodRegister({super.key});

  // This widget is the root of your application.
  @override
  FoodRegisterState createState() => FoodRegisterState();
}

class FoodRegisterState extends State<FoodRegister> {
  static const TextStyle optionStyle = TextStyle(fontSize: 25, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    // 列方向に指定
    return 
      Scaffold(
        // ヘッダー
        appBar: AppBar(
          title: Text('食事を記録する'),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          // 左側のアイコン
          leading: IconButton(
              onPressed: () {
                // 前の画面に戻る
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back),
            ),
          // 右側のアイコン一覧
          actions: <Widget>[
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.favorite),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.more_vert),
            ),
            ]
        ),
        // コンテンツ
        body: Column(
          children: [
            Text('aiue'),
          ],
        )
      );
  }
}
// settings設定アイコン、search検索アイコン



