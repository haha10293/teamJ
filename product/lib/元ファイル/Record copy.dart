import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// TextInputFormatter
import 'package:flutter/widgets.dart';


// 食品項目記録画面
class Record extends StatefulWidget {
  const Record({super.key});

  // This widget is the root of your application.
  @override
  RecordState createState() => RecordState();
}

class RecordState extends State<Record> {
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
        ),
        // コンテンツ
        body: Column(
          children: [
            Container(
            color: Theme.of(context).colorScheme.inversePrimary,
            child: 
            Form(
              key: _formKey,
              child: 
              // 入力欄
              textFormField(Icons.search,'検索語を入力してください。', _searchForm, '検索語', FilteringTextInputFormatter.deny(''), TextInputType.text, ),
            )),
                  // 食品追加画面
                  ListView.separated(
                    shrinkWrap: true, 
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 3,
                    separatorBuilder: (context, index) =>  Divider(height: 0.5,),
                    itemBuilder: (BuildContext context, int index) {
                      return
                          ListTile(
                            leading: 
                              Image.network('https://i.ytimg.com/vi/OGAGT-2w0ac/maxresdefault.jpg', fit: BoxFit.contain),
                            tileColor: Colors.amber,
                            title:Container(
                              decoration: BoxDecoration(
                                border: Border(bottom: BorderSide()),
                              ),
                              child:Text('カレーライス')
                              ),
                            subtitle: Text(
                              'カロリー：299kcal　たんぱく質：60g\n脂質：　　299kcal　炭水化物：　60g\n塩分：　　299kcal'
                              ),
                            // タップされたときの処理
                            onTap: () {
                              
                            },
                            // 一定時間タップしたとき
                            onLongPress: () {
                              // ダイアログを表示
                              showDialog<void>(
                                context: context,
                                builder: (_) {
                                  return AlertDialog(
                                    title: const Text('データを消してしまってもいいですか？'),
                                    content: const Text('内容'),
                                    actions: <Widget>[
                                      GestureDetector(
                                        child: const Text('いいえ'),
                                        // 元の画面に戻る
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                      GestureDetector(
                                        child: const Text('はい'),
                                        // その日の食品一覧から削除して元の画面に戻る
                                        onTap: () {
                                          // 削除処理（追加予定）

                                          // 元画面に戻る
                                          Navigator.pop(context);
                                        },
                                      )
                                    ],
                                  );
                                }
                              );
                            },
                        );
                    },
                  ),
          ],
        )
      );
  }
}
// settings設定アイコン、search検索アイコン



