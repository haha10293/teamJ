import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// TextInputFormatter
import 'package:flutter/widgets.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';



// 設定画面
class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  SettingsState createState() => SettingsState();
}

enum Gender { 
  male('男性'),
  female('女性'),
  ;
  final String displayName;
  const Gender(this.displayName);
}

class SettingsState extends State<Settings> {
  // ここで作成したformkeyを基にformを作成
  final _formKey = GlobalKey<FormState>();
  final _Height = TextEditingController();
  final _Weight = TextEditingController();
  final _Age = TextEditingController();
  final _Name = TextEditingController();
  final _Target_kcal = TextEditingController();
  static const TextStyle optionStyle = TextStyle(fontSize: 25, fontWeight: FontWeight.bold);
  int _isSelectedValue = 1;
  double _isSelectedDropDown = 1.5;
  // radio:初期値
  Gender? _category = Gender.male;

  // テキストフォーム作成
  TextFormField textFormField(IconData a, String b, TextEditingController c, String d, TextInputFormatter e, TextInputType f, [int g = 5]) {
    return TextFormField(
      controller: c,
      // テキストフィールドの装飾
      decoration: InputDecoration(
        labelText: d,
        hintText: b,
        prefixIcon: Icon(a),
      ),
      // 入力制限
      inputFormatters: [e],
      // キーボードのタイプを指定
      keyboardType: f,
      // 最大入力数
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

  // ラジオボタン作成
  ListTile listTitle(Gender a) {
    return 
    ListTile(
      title: Text(a.displayName),
      leading: Radio<Gender>(
      value: a,
      groupValue: _category,
      onChanged: (Gender? value) {
          setState(() {
            _category = value;
          });
        },
      ),
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _Height.dispose();
    _Weight.dispose();
    _Age.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 列方向に指定
    return 
      Scaffold(
        // ヘッダー
        appBar: AppBar(
          title: Text('設定'),
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
        body: SingleChildScrollView(child:Column(
          children: [
            Text('個人情報', style: optionStyle,),
            Form(
              key: _formKey,
              child: 
              Column(
                children: [
                  // 入力欄
                  textFormField(Icons.search,'名前', _Name, '名前', FilteringTextInputFormatter.singleLineFormatter, TextInputType.name, 10),
                  textFormField(Icons.search,'身長', _Height, '身長', FilteringTextInputFormatter.allow(RegExp(r'^\d+(\.\d*)?')), TextInputType.numberWithOptions(decimal: true)),
                  textFormField(Icons.search,'体重', _Weight, '体重', FilteringTextInputFormatter.allow(RegExp(r'^\d+(\.\d*)?')), TextInputType.numberWithOptions(decimal: true), 5),
                  textFormField(Icons.search,'年齢', _Age, '年齢', 
                  FilteringTextInputFormatter.digitsOnly, TextInputType.number, 3),
                  textFormField(Icons.search,'目標エネルギー', _Target_kcal, '目標エネルギー', FilteringTextInputFormatter.digitsOnly, TextInputType.number, 5),
                  // ラジオボタン
                  Text('性別'),
                  listTitle(Gender.male),
                  listTitle(Gender.female),
                  // ドロップダウン
                  Text('身体活動レベル'),
                  DropdownButton(
                    items: const[
                      DropdownMenuItem(
                        value: 1.5,
                        child: Text('低頻度運動'),
                      ),
                      DropdownMenuItem(
                          value: 1.7,
                          child: Text('中頻度の運動'),
                      ),
                      DropdownMenuItem(
                          value: 1.9,
                          child: Text('高頻度の運動'),
                      ),
                    ],
                      value: _isSelectedDropDown,
                      onChanged: (double? value) {
                        setState(() {
                          _isSelectedDropDown = value!;
                        });
                      }
                    ),
                  Padding(
                  // 上下に16px余白を設定
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: ElevatedButton(
                      onPressed: () {
                        // バリデータチェックが正常の時
                        if (_formKey.currentState!.validate()) {
                          print("成功");
                          print(_Height.text);
                          print(_Weight.text);
                          print(_Age.text);
                          print(_category?.displayName);
                          setState(() {
                            // DBのユーザーテーブルを更新

                            // 元の画面に戻る
                            Navigator.pop(context);
                          });
                        }
                      },
                      style: TextButton.styleFrom(
                        textStyle: const TextStyle(fontSize: 13.0),
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white, // foreground
                        fixedSize: const Size(130, 5),
                        alignment: Alignment.center,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                      ),
                      child: const Text('登録'),
                    ),
                  )
                ],
              )
            ),
          ],
        ))
      );
  }
}
// settings設定アイコン、search検索アイコン



