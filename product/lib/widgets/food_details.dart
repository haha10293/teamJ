import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// TextInputFormatter
import 'package:flutter/widgets.dart';


// 食品項目記録画面
class FoodDetails extends StatefulWidget {
  const FoodDetails({super.key});

  // This widget is the root of your application.
  @override
  FoodDetailsState createState() => FoodDetailsState();
}

class FoodDetailsState extends State<FoodDetails> {
  // ここで作成したformkeyを基にformを作成
  final _formKey = GlobalKey<FormState>();
  final _searchForm = TextEditingController();
  static const TextStyle optionStyle = TextStyle(fontSize: 25, fontWeight: FontWeight.bold);

  // テキストフォーム作成
  TextFormField textFormField(IconData a, String b, TextEditingController c, String d, TextInputFormatter e, TextInputType f, [int g = 15]) {
    return TextFormField(
      controller: c,
      // テキストフィールドの装飾
      decoration: InputDecoration(
        prefixIcon: Icon(a),
        // labelText: d,
        // 右下のカウンターが消える
        counterText: '',
        hintText: b,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      // 入力制限
      inputFormatters: [e],
      // キーボードのタイプを指定
      keyboardType: f,
      // 最大文字
      maxLength: g,
      // 入力チェック
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'テキストを入力してください';
        }
        return null;
      },
    );
  }


  @override
  void dispose() {
    _searchForm.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 列方向に指定
    return 
      Scaffold(
        // ヘッダー
        appBar: AppBar(
          title: Text('食品詳細'),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          // 左側のアイコン
          leading: IconButton(
              onPressed: () {
                // 前の画面に戻る
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back),
            ),
        ),
        // コンテンツ
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(child: 
            Text('食品詳細画面', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),))
          ],
        )
      );
  }
}
// settings設定アイコン、search検索アイコン



