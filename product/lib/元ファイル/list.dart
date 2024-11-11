import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
// firebase
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyList extends StatefulWidget {
  const MyList({super.key});

  // This widget is the root of your application.
  @override
  MyListState createState() => MyListState();
}

class MyListState extends State<MyList> {
  bool moji = false;
  // 文字列連結テスト
  List<String> docs = [];
  
  // 画像を変更する関数。
  void _printList() {
    // setStateを使って、ウィジェットの状態を更新する。
    setState(() {
      // 画像のURLを切り替える。条件演算子で現在のURLが特定のURLならもう一方のURLに、そうでなければ元のURLに戻す。
      moji = true;
    });
  }

  // ログインしているユーザーの書籍一覧を取得
  Future<void> getUserDocuments() async {
    // 文字一時保存用のローカルリスト
    var tempList = [];
    // setState( await () {
      docs.clear();
      // DBからログインしたユーザのIDが持つ書籍一覧を検索し取得。
      await FirebaseFirestore
        .instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("books")
        .get()
        // 取得できた場合書籍ごとの文字列をリストに格納する。
        .then((QuerySnapshot) => {
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
              // // debug
              // print('${docSnapshot.id} => ${docSnapshot.data()}'),
              // docSnapshot.data().forEach((k,v) => print('$k:${v.runtimeType}')),
              // // 書籍内のデータを文字列に変換しリストに格納
              // docSnapshot.data().forEach((k,v) => tempList.add('$k: $v')),
              // // リスト内の文字列を結合し、docsに追加
              // docs.add(tempList.join('|')),
              // // 一時保存リストをクリア。
              // tempList.clear()
            },
            // debug
            print(docs)
        })
        // エラーログ表示
        .catchError((err) => print('エラー$err'));
        // 一覧を表示
        // moji = true;
    // });
  }

  List<String> items = [
    'ドキュメント名あいあいあおｆじょあｆじょあｊふぁふぉあおあおあおあおおあおあおあ',
    'ドキュメント名あいあいあおｆじょあｆじょあｊふぁふぉあおあおあおあおおあおあおあ', 
    'Item 3'];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {
            // 書籍一覧を取得し一覧を表示。
            getUserDocuments();
          },
          style: TextButton.styleFrom(
            textStyle: const TextStyle(fontSize: 13.0),
            backgroundColor: Colors.green,
            foregroundColor: Colors.white, // foreground
            fixedSize: const Size(100, 5),
            alignment: Alignment.center,
            shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.0),
                    ),
        ),
          child: const Text("書籍一覧")),
        // リストの一覧を生成
        // if(moji)
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
      ]
    );
  }
}




