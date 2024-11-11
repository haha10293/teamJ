import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
// firebase Databaseプラグイン
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyForm extends StatefulWidget { 
  const MyForm({super.key});

  @override
  MyFormState createState() => MyFormState();
}

enum Category { 
  info('情報'),
  jpLiterature('国文学'),
  foreignLiterature('海外文学'),
  naturalScience('自然文学'),
  humanities('人文文学'),
  philosophy('哲学')
  ;
  final String displayName;
  const Category(this.displayName);
}

class MyFormState extends State<MyForm> {
  // radio:初期値
  Category? _category = Category.info;

  // ここで作成したformkeyを基にformを作成
  final _formKey = GlobalKey<FormState>();
  final _tec1 = TextEditingController();
  final _tec2 = TextEditingController();
  final _tec3 = TextEditingController();
  final _tec4 = TextEditingController();
  final _tec5 = TextEditingController();
  final _tec6 = TextEditingController();

  // テキストフォーム作成
  TextFormField textFormField(IconData a, String b, TextEditingController c, String d, TextInputFormatter e, TextInputType f) {
    return TextFormField(
      controller: c,
      // テキストフィールドの装飾
      decoration: InputDecoration(
        labelText: d,
        hintText: b,
        border: const OutlineInputBorder(),
        icon: Icon(a),
      ),
      // 入力制限
      inputFormatters: [e],
      // キーボードのタイプを指定
      keyboardType: f,
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
  ListTile listTitle(Category a) {
    return 
    ListTile(
      title: Text(a.displayName),
      leading: Radio<Category>(
      value: a,
      groupValue: _category,
      onChanged: (Category? value) {
          setState(() {
            _category = value;
          });
        },
      ),
    );
  }

  // 書籍の追加
  Future<void> addDocs() async {
    // データの追加・更新
    await FirebaseFirestore
      .instance
      .collection("users")
      .doc(FirebaseAuth.instance.currentUser?.uid)
      .collection("books")
      .doc(_tec1.text)
      .set({
        "ドキュメント名": _tec1.text,
        "書名": _tec2.text,
        "著者名": _tec3.text,
        "出版社": _tec4.text,
        "価格": int.parse(_tec5.text),
        "ページ数": int.parse(_tec6.text),
        "分野": _category?.displayName,
      })
      .then((DocumentSnapshot) => {
        // 入力欄初期化
        _tec1.clear(),
        _tec2.clear(),
        _tec3.clear(),
        _tec4.clear(),
        _tec5.clear(),
        _tec6.clear(),
        setState(() => _category = Category.info),
        // debug
        // print("データ追加成功 with ID: ${documentSnapshot.id}"),
        // データの追加の成功を通知
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('ok!')),
        )
      })
      .catchError((e) => {
        print('エラー: $e'),
        // データの追加の失敗を通知
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('書籍の追加に失敗しました。')),
        )
      });
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _tec1.dispose();
    _tec2.dispose();
    _tec3.dispose();
    _tec4.dispose();
    _tec5.dispose();
    _tec6.dispose();
    super.dispose();
  }
  
  // テキスト名とIconDataの連想配列
  @override
  Widget build(BuildContext context) {
    return 
    ListView(children: <Widget>[
    Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          // タイトル
          Text('書籍情報入力'),
          // field
          textFormField(Icons.info,'ドキュメント名を入力してください。', _tec1, 'ドキュメント名', FilteringTextInputFormatter.deny(''), TextInputType.text),
          textFormField(Icons.book,'書名を入力してください。', _tec2,'書名', FilteringTextInputFormatter.deny(''), TextInputType.text),
          textFormField(Icons.face,'著者名を入力してください。', _tec3,'著者名', FilteringTextInputFormatter.deny(''), TextInputType.text),
          textFormField(Icons.file_upload,'出版社を入力してください。', _tec4,'出版社', FilteringTextInputFormatter.deny(''), TextInputType.text),
          textFormField(Icons.currency_yen,'価格（円）を入力してください。', _tec5,'価格（円）', FilteringTextInputFormatter.digitsOnly, TextInputType.number),
          textFormField(Icons.find_in_page,'ページ数を入力してください。', _tec6,'ページ数', FilteringTextInputFormatter.digitsOnly, TextInputType.number),
          // タイトル
          Text('書籍の分野を選択'),
          // radioButton
          listTitle(Category.info),
          listTitle(Category.jpLiterature),
          listTitle(Category.foreignLiterature),
          listTitle(Category.naturalScience),
          listTitle(Category.humanities),
          listTitle(Category.philosophy),
          Padding(
            // 上下に16px余白を設定
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: ElevatedButton(
                onPressed: () {
                  // バリデータチェックが正常の時
                  if (_formKey.currentState!.validate()) {
                    print("成功");
                    print(_tec1.text);
                    print(_tec2.text);
                    print(_tec3.text);
                    print(_tec4.text);
                    print(int.parse(_tec5.text));
                    print(int.parse(_tec6.text));
                    print(_category?.displayName);
                    setState(() {
                      addDocs();
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
                child: const Text('書籍情報追加'),
              ),
            )
          ],
        ),
    )]);
  }
}