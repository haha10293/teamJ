import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
// firebase Databaseプラグイン
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// 検索widget
class Search extends StatefulWidget { 
  const Search({super.key});

  @override
  SearchState createState() => SearchState();
}

enum Category { 
  bookTitle('書名'),
  authorName('著者名'),
  publisher('出版社'),
  price('価格'),
  numberOfPage('ページ数'),
  field('分野')
  ;
  final String displayName;
  const Category(this.displayName);
}

class SearchState extends State<Search> {
  // radio:初期値
  Category? _category = Category.bookTitle;
  // 文字列連結テスト
  List<String> docs = [];

  // ここで作成したformkeyを基にformを作成
  final _formKey = GlobalKey<FormState>();
  final _searchForm = TextEditingController();

  String _title = '';
  // getter
  String get title => _title;
  // setter
  set title(String s){
    _title = s;
  }

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
  Future<void> getSearch() async {
    // 文字一時保存用のローカルリスト
    var tempList = [];
    // 文字列連結リストクリア。
    var results;
    docs.clear();
    // booksコレクションへの参照を取得
    final booksRef = await FirebaseFirestore
      .instance
      .collection("users")
      .doc(FirebaseAuth.instance.currentUser?.uid)
      .collection("books");
    // 数値型に変換できるか検証
    if (int.tryParse(_searchForm.text) != null){
      // 値型に変換してクエリ実行(入力された数値未満の値)
      results = booksRef.where(_category?.displayName as Object, isEqualTo: int.parse(_searchForm.text));
    }else {
      // results = booksRef.where(_category?.displayName as Object, whereIn:[_searchForm.text]);
      results = booksRef.orderBy(_category?.displayName as Object).startAt([_searchForm.text]).endAt(['${_searchForm.text}\uf8ff'])
      ;
    }
    // クエリ実行
    results.get().then((QuerySnapshot) => {
      // debug
      print(QuerySnapshot.docs.isEmpty),
      // ドキュメントが存在しない場合、
      if (QuerySnapshot.docs.isEmpty) {
        // 書籍が存在しないことを通知
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('書籍が存在しません')),
        )
      }else {
        // 条件に一致するデータを一覧表示
        for (var docSnapshot in QuerySnapshot.docs) {
          setState(() {
            // debug
            print('${docSnapshot.id} => ${docSnapshot.data()}');
            docSnapshot.data().forEach((k,v) => print('$k:${v.runtimeType}'));
            // 書籍内のデータを文字列に変換しリストに格納
            // docSnapshot.data().forEach((k,v) => tempList.add('$k: $v'));
            tempList.add('ドキュメント名: ${docSnapshot.data()["ドキュメント名"]}');
            tempList.add('書名: ${docSnapshot.data()["書名"]}');
            tempList.add('著者名: ${docSnapshot.data()["著者名"]}');
            tempList.add('出版社: ${docSnapshot.data()["出版社"]}');
            tempList.add('ページ数: ${docSnapshot.data()["ページ数"]}');
            tempList.add('価格: ${docSnapshot.data()["価格"]}');
            tempList.add('分野: ${docSnapshot.data()["分野"]}');
            // リスト内の文字列を結合し、docsに追加
            docs.add(tempList.join('|'));
            // 一時保存リストをクリア。
            tempList.clear();
          }),
        }
      }
    })
      .catchError((err) => print('エラー$err'));
    // 入力欄初期化
    _searchForm.clear();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _searchForm.dispose();
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
            Text('検索のタイプを選択'),
            // タイトル
            // radioButton
            listTitle(Category.bookTitle),
            listTitle(Category.authorName),
            listTitle(Category.publisher),
            listTitle(Category.price),
            listTitle(Category.numberOfPage),
            listTitle(Category.field),
            // 入力欄
            textFormField(Icons.search,'検索語を入力してください。', _searchForm, '検索語', FilteringTextInputFormatter.deny(''), TextInputType.text),
            Padding(
              // 上下に16px余白を設定
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: ElevatedButton(
                  onPressed: () {
                    // バリデータチェックが正常の時
                    if (_formKey.currentState!.validate()) {
                      print("成功");
                      print(_searchForm.text);
                      print(_category?.displayName);
                      setState(() {
                        title = _searchForm.text;
                        getSearch();
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
                  child: const Text('条件取得実行'),
                ),
              )
            ],
          ),
      ),
      // 検索結果一覧表示
      ListView.builder(
          shrinkWrap: true, //追加
          physics: const NeverScrollableScrollPhysics(),//追加
          // リストの数
          itemCount: docs.length,
          // 生成する内容
          itemBuilder: (BuildContext context, int index) {
            return
                ListTile(
                  title:
                    Center(
                      child: Text(
                          docs[index],
                          style: 
                            const TextStyle(
                            fontSize: 12, 
                            fontWeight: FontWeight.bold,
                            color: Colors.blue                        
                          ),
                        )
                    ),
              );  
          },
        ),
    ]);
  }
}