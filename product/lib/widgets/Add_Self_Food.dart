import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:product/widgets/foodRegister.dart';

// 食材
class Add_Self_Food extends StatefulWidget {
  const Add_Self_Food({super.key});

  @override
  Add_Self_FoodState createState() => Add_Self_FoodState();
}

class Add_Self_FoodState extends State<Add_Self_Food> {
  static const TextStyle optionStyle = TextStyle(fontSize: 25, fontWeight: FontWeight.bold);
  double _progress = 0;
  List<int> rgbo = [63, 81, 181];
  double _opacity = 1.0;
   // ドロップダウンリストのアイテム
  final List<String> items = ['人前', '個', '袋'];
  // クラスメンバとして初期化
  String? selectedValue = '人前'; 
   // 食品記録画面
  static const foodRegister = FoodRegister();


  // 入力欄widgets作成
  Widget textForm(int t, r, b, l, String label, hint, suffix, double deviceWidth) {
    return 
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
              // ここ
              padding: EdgeInsets.only(top: t.toDouble(), right: r.toDouble(), bottom: b.toDouble(), left: l.toDouble()),
              child: SizedBox(
                  
              width: deviceWidth-50,
              child: TextField(
                  keyboardType: TextInputType.text, // キーボードの種類を指定
                  onChanged: (String value) {
                            setState(() {
                              // _BookName = value;
                            });
                          },
                  // フォームの装飾
                  decoration: InputDecoration(
                    labelText: label,
                    hintText: hint,
                    hintStyle: const TextStyle(color: Colors.grey, fontWeight: FontWeight.w300),
                    fillColor: Colors.yellow[50],
                    filled: true, //これ入れないとfillColorが表示されない
                    suffix: Text(suffix),
                    suffixStyle: const TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontWeight: FontWeight.w500),
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

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 1, right: 15, bottom: 1, left: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          // 子要素
          children: [
            // 食材名
            textForm(1, 15, 1, 10, "食材名", "食材名を入力してください", "", deviceWidth),
            //-- 画像入力部分 --//
            // カード
            Card(
              color: Colors.white, // Card自体の色
              // 外側の余白
              margin: const EdgeInsets.all(10),
              // elevation: 10, // 影の離れ具合
              shadowColor: Colors.black, // 影の色
              // 枠線を変更できる
              shape: const RoundedRectangleBorder(),
              // 列方向
              child: Padding(
                padding: const EdgeInsets.only(top: 5, right: 15, bottom: 15, left: 10),            
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    // 既にある画像からアップロードボタンと今カメラで撮影するボタンを横並びで置く
                    const Text('食材の画像', style: optionStyle,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(child: 
                          Row(
                            children: [
                            ElevatedButton(
                              onPressed: (){}, 
                              style: ButtonStyle(
                                shape: WidgetStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)))
                              ),
                              child: const Column(children: [
                                Padding(
                                  padding: EdgeInsets.only(top: 8, right: 15, bottom: 5, left: 10),
                                  child: Icon(Icons.photo_size_select_actual_rounded),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 0, right: 15, bottom: 8, left: 10),
                                  child: Text('写真を登録'),
                                ),
                              ],),
                              )
                            ],
                          )
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          //- 入力欄 -//
          Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // const Text("栄養素", style: optionStyle,),
              ],
            ),
            // 単位
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: deviceWidth-175,
                  child: TextField(
                    keyboardType: TextInputType.number, // キーボードの種類を指定
                    onChanged: (String value) {
                      setState(() {
                        // _BookName = value;
                      });
                    },
                    // フォームの装飾
                    decoration: InputDecoration(
                      labelText: "分量",
                      hintText: '分量を入力してください',
                      hintStyle: const TextStyle(color: Colors.grey, fontWeight: FontWeight.w300),
                      fillColor: Colors.yellow[50],
                      filled: true, //これ入れないとfillColorが表示されない
                      // suffix: Text('kcal'),
                      suffixStyle: const TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontWeight: FontWeight.w500),
                      border:  
                      OutlineInputBorder(borderRadius: BorderRadius.circular(2),)
                    ),
                  ),
                ),
                // ドロップダウンリスト
                SizedBox(
                  width: 125, // 横幅を指定
                  child:DropdownButtonFormField<String>(
                    hint: const Text("単位を選択"),
                    value: selectedValue,
                    decoration: InputDecoration(
                      labelText: '単位を選択',
                      filled: true,
                      fillColor: Colors.yellow[50],
                      border: const OutlineInputBorder()
                    ),
                    style: const TextStyle(
                      color: Colors.black, // 文字色
                      fontWeight: FontWeight.bold,
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedValue = newValue;
                      });
                    },
                    items: items.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ]),
              // 栄養素の表示欄
              Card(
                color: Colors.white, // Card自体の色
                // 外側の余白
                margin: const EdgeInsets.all(10),
                // elevation: 10, // 影の離れ具合
                shadowColor: Colors.black, // 影の色
                // 枠線を変更できる
                shape: const RoundedRectangleBorder(),
                child:
                Padding(padding: EdgeInsets.only(top: 1, right: 15, bottom: 1, left: 10),child: 
              Table(
                columnWidths: const <int, TableColumnWidth>{
                  0: IntrinsicColumnWidth(),
                  1: FlexColumnWidth(8),
                  2: FixedColumnWidth(80),
                },
                children: const <TableRow>[
                  // エネルギー
                  TableRow(
                    children: <Widget>[
                      Text("エネルギー",style: TextStyle(fontSize: 23),),
                      Align(
                        alignment: Alignment.centerRight,  // 右寄せ
                        child: Text("64",style: TextStyle(fontSize: 23)),
                      ),
                      Align(
                        alignment: Alignment.center,  
                        child: Text("kcal",style: TextStyle(fontSize: 23),),
                      ),
                    ],
                  ),
                  // たんぱく質
                  TableRow(
                    children: <Widget>[
                      Text("たんぱく質",style: TextStyle(fontSize: 23),),
                      Align(
                        alignment: Alignment.centerRight,  // 右寄せ
                        child: Text("1.9",style: TextStyle(fontSize: 23)),
                      ),
                      Align(
                        alignment: Alignment.center,  
                        child: Text("g",style: TextStyle(fontSize: 23),),
                      ),
                    ],
                  ),
                  // 脂質
                  TableRow(
                    children: <Widget>[
                      Text("脂質",style: TextStyle(fontSize: 23),),
                      Align(
                        alignment: Alignment.centerRight,  // 右寄せ
                        child: Text("1.9",style: TextStyle(fontSize: 23)),
                      ),
                      Align(
                        alignment: Alignment.center,  
                        child: Text("g",style: TextStyle(fontSize: 23),),
                      ),
                    ],
                  ),
                  // 炭水化物
                  TableRow(
                    children: <Widget>[
                      Text("炭水化物",style: TextStyle(fontSize: 23),),
                      Align(
                        alignment: Alignment.centerRight,  // 右寄せ
                        child: Text("9.3",style: TextStyle(fontSize: 23)),
                      ),
                      Align(
                        alignment: Alignment.center,  
                        child: Text("g",style: TextStyle(fontSize: 23),),
                      ),
                    ],
                  ),
                  // 食塩相当量
                  TableRow(
                    children: <Widget>[
                      Text("食塩相当量",style: TextStyle(fontSize: 23),),
                      Align(
                        alignment: Alignment.centerRight,  // 右寄せ
                        child: Text("0.1",style: TextStyle(fontSize: 23)),
                      ),
                      Align(
                        alignment: Alignment.center,  
                        child: Text("g",style: TextStyle(fontSize: 23),),
                      ),
                    ],
                  ),
                ],
              ),
              
                ),
              ),

 // 食品記録項目
  Padding(padding: EdgeInsets.only(top: 10, right: 15, bottom: 1, left: 10),child: 
        Container(
          color: Colors.blueGrey,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
            Text('食品項目'),
            Text('12品目'),
            // 記録ボタン
            ElevatedButton(onPressed: (){
              // 食品記録画面へ遷移
              Navigator.push(context, MaterialPageRoute(builder: (context) => foodRegister));

            //   setState(() {
              
            // }
            // );
            }, child: Text('記録')),
          ],),
        ),
        ),
        // 摂取した食品一覧
        // Listview.builderの区切り追加版。
        Padding(padding: EdgeInsets.only(top: 0, right: 15, bottom: 0, left: 10),child: 
        ListView.separated(
          // スクロール可能にする/正しitemCountにしてした要素分確保されるので容量的にはよくない。
          shrinkWrap: true, 
          // スクロールの種類を指定
          physics: const NeverScrollableScrollPhysics(),
          // リストの数
          itemCount: 3,
          // 区切り線
          separatorBuilder: (context, index) =>  Divider(height: 0.5,),
          // 生成する内容
          itemBuilder: (BuildContext context, int index) {
            return
                ListTile(
                  // 前後画像
                  // leading: Icon(Icons.abc_rounded),
                  leading: 
                    Image.network('https://i.ytimg.com/vi/OGAGT-2w0ac/maxresdefault.jpg', fit: BoxFit.contain),
                    // 画像を決めた幅で表示する場合
                    // Container(
                    //   width: 90,
                    //   height: 60,
                    //   child: Image.network('https://pbs.twimg.com/media/GEf7bkQacAA_mHV.jpg:large', fit: BoxFit.cover),
                    // ),
                  // trailing: Icon(Icons.list),
                  // タイルの背景色
                  tileColor: Colors.amber,
                  // タイトル/サブ
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
      ),


              // 登録ボタン
              Padding(
                padding: const EdgeInsets.only(top: 8, right: 5, bottom: 5, left: 5),
                child:ElevatedButton(
                  onPressed: (){}, 
                  style:ButtonStyle(
                    shape: WidgetStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(6))),
                  ),
                  child:const Column(children: [
                    Padding(
                      padding: EdgeInsets.only(top: 10, right: 15, bottom: 15, left: 10),
                      child:
                      Text('内容を登録'),
                    ),],
                  ),
                ),
              ),
          ],
          ),]
        )
      ),
    );
  }
}
