import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:helloworld/screen/Myhome.dart';

class RootPage extends StatefulWidget {
  // RootPage({required Key key}) : super(key: key);

  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  @override
  initState() {
    if (FirebaseAuth.instance.currentUser != null) {
      Navigator.pushReplacementNamed(context, "/login");
    }else {
      // 成功した場合uidとtitleを引数に渡して遷移。
      FirebaseFirestore
          .instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .get()
          .then((DocumentSnapshot result) =>
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MyHomePage(
                            title: 'test',
                            uid: FirebaseAuth.instance.currentUser!.uid,
                          ))))
          .catchError((err) => print('エエラー$err'));
    }
    super.initState();
    // FirebaseAuth.instance
    //     .currentUser()
    //     .then((currentUser) => {
    //           // ログインしていなかったらログインページへ
    //           if (currentUser == null)
    //             {Navigator.pushReplacementNamed(context, "/login")}
    //           else
    //             {
    //               // DBからログインしているユーザのuidに一致するものを取得
    //               // 成功した場合uidとtitleを引数に渡して遷移。
    //               FirebaseFirestore
    //                   .instance
    //                   .collection("users")
    //                   .doc(currentUser.uid)
    //                   .get()
    //                   .then((DocumentSnapshot result) =>
    //                       Navigator.pushReplacement(
    //                           context,
    //                           MaterialPageRoute(
    //                               builder: (context) => MyHomePage(
    //                                     title: 'test',
    //                                     uid: currentUser.uid,
    //                                   ))))
    //                   .catchError((err) => print(err))
    //             }
    //         })
    //     .catchError((err) => print(err));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Text("Loading..."),
        ),
      ),
    );
  }
}
