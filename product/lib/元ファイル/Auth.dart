// firebase Databaseプラグイン
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:helloworld/screen/Myhome.dart';
// flutter
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Auth extends StatefulWidget { 
  const Auth(String s, {Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  AuthState createState() => AuthState();
}

class AuthState extends State<Auth> {
  // Registration Field Email Address
  String registerUserEmail = "";
  // Registration Field Password
  String registerUserPassword = "";
  // Login field email address
  String loginUserEmail = "";
  // Login field password (login)
  String loginUserPassword = "";
  // View information about registration and login
  String DebugText = "";
  // 文字列連結テスト
  List<String> testList = [];
  final data = {
    "ドキュメント名": "テスト",
    "書名": "テスト１",
    "著者名": "テスト１１",
    "出版社": "テスト１１１",
    "価格": 1000,
    "ページ数": 220,
    "分野": "情報",
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // 独自に設定しないと色がつかない
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              // TextFormField(
              //   // Set labels for text input
              //   decoration: InputDecoration(labelText: "メールアドレス"),
              //   onChanged: (String value) {
              //     setState(() {
              //       registerUserEmail = value;
              //     });
              //   },
              // ),
              // TextFormField(
              //   decoration: InputDecoration(labelText: "6 character long Password"),
              //   // Mask not to show password
              //   obscureText: true,
              //   onChanged: (String value) {
              //     setState(() {
              //       registerUserPassword = value;
              //     });
              //   },
              // ),
              // const SizedBox(height: 1),
              // ElevatedButton(
              //   onPressed: () async {
              //     try {
              //       // ユーザー登録
              //       final FirebaseAuth auth = FirebaseAuth.instance;
              //       final UserCredential result =
              //       await auth.createUserWithEmailAndPassword(
              //         email: registerUserEmail,
              //         password: registerUserPassword,
              //       );
              //       // ユーザ登録完了時の処理
              //       final User user = result.user!;
              //       setState(() {
              //         DebugText = "登録完了：${user.email}";
              //       });
              //     } catch (e) {
              //       // エラー発生時の内容出力
              //       setState(() {
              //         DebugText = "登録失敗：${e.toString()}";
              //       });
              //     }
              //   },
              //   child: Text("ユーザー登録"),
              // ),

              const SizedBox(height: 1),
              TextFormField(
                decoration: InputDecoration(labelText: "メールアドレス"),
                onChanged: (String value) {
                  setState(() {
                    loginUserEmail = value;
                  });
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "パスワード"),
                obscureText: true,
                onChanged: (String value) {
                  setState(() {
                    loginUserPassword = value;
                  });
                },
              ),
              const SizedBox(height: 1),
              ElevatedButton(
                onPressed: () async {
                  try {
                    // ログイン認証
                    final FirebaseAuth auth = FirebaseAuth.instance;
                    final UserCredential result =
                    await auth.signInWithEmailAndPassword(
                      email: loginUserEmail,
                      password: loginUserPassword,
                    );
                    // ログイン成功時
                    final User user = result.user!;
                    print('ユーザー：$user');
                    setState(() {
                      // DebugText = "Succeeded to Login：${user.email}";
                      // FirebaseFirestore
                      //     .instance
                      //     .collection("users")
                      //     .doc(FirebaseAuth.instance.currentUser?.uid)
                      //     .collection("books")
                      //     .add(data)
                      //     .then((documentSnapshot) => {
                      //       print("Added Data with ID: ${documentSnapshot.id}")
                      //     })
                      //     .catchError((e) => print(e));
                      FirebaseFirestore
                          .instance
                          .collection("users")
                          .doc(FirebaseAuth.instance.currentUser?.uid)
                          .get()
                          .then((DocumentSnapshot result) => {
                              print('結果：${result.data()}'),
                              // print('結果2：${result}'),
                              // print('結果2：${result.get('Age')}'),
                              // print('結果2：${result.data().runtimeType}'),
                              // データを取得出来たらuidを渡して遷移。
                              if (result.data() != null) {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MyHomePage(
                                          title: '課題アプリ',
                                          uid: FirebaseAuth.instance.currentUser!.uid,
                                      )
                                    )
                                  )
                                }else {
                                  print("失敗"),
                                  setState(() {
                                    DebugText = "アカウントが存在していません。";
                                  })
                                }
                              })
                          .catchError((err) => print('エラー$err'));
                                    });
                  } catch (e) {
                    // Failed to login
                    setState(() {
                      DebugText = "ログインに失敗しました：${e.toString()}";
                    });
                  }
                },
                child: Text("ログイン"),
              ),
              const SizedBox(height: 8),
              Text(DebugText),
            ],
          ),
        ),
      ),
    );
  }
}