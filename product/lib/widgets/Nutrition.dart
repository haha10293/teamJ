import 'package:flutter/material.dart'hide DatePickerTheme;
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
// 外部ライブラリ
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
// 自作widgets
import 'package:product/widgets/Record.dart';
import 'package:product/widgets/food_details.dart';

class Nutrition extends StatefulWidget {
  const Nutrition({super.key});

  // This widget is the root of your application.
  @override
  NutritionState createState() => NutritionState();
}

class NutritionState extends State<Nutrition> {
  // 自作widgetsをインスタンス化
  static const record = Record();
  static const foodDetails = FoodDetails();
  // テキストオプション
  static const TextStyle optionStyle = TextStyle(fontSize: 25, fontWeight: FontWeight.bold);
  // 
  double _progress = 0;
  List<int> rgbo = [63, 81, 181];
  double _opacity = 1.0;
  // 曜日/今日の日付
  late int _weekDay = DateTime.now().weekday;
  DateTime _time = DateTime.now();

  // 現在の日付
  DateTime _focusedDay = DateTime.now();
  // 選択中の日付
  DateTime? _selectedDay;   

  // 栄養素進捗メータ作成
  Expanded nutritionProgress() {
    return 
      Expanded(
        child: Container(
          color: Colors.green,
          child: 
            Column( 
              // 横軸の配置設定
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('data',style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                SizedBox(height: 5),
                // Container(margin: EdgeInsets.fromLTRB(0, 0, 10, 0), child: Align(child: Text('100g/158g'), alignment: Alignment.centerRight,)),
                Align(child: Text('100g/158g', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),), alignment: Alignment.centerRight,),
                SizedBox(height: 5),

                Row(
                  children: [
                    Expanded(
                      child: 
                        Container(
                          color: Colors.red,
                          child: 
                            ClipRRect(
                              borderRadius: const BorderRadius.all(Radius.circular(30)),
                              // 線形インジケータ
                              child: 
                                LinearProgressIndicator(
                                  backgroundColor: Colors.grey,
                                  // valueColor: new AlwaysStoppedAnimation<Color>(Color.fromRGBO(63, 81, 181, 1.0)),
                                  valueColor: new AlwaysStoppedAnimation<Color>(Color.fromRGBO(rgbo[0], rgbo[1], rgbo[2], _opacity)),
                                  // valueColor:  AlwaysStoppedAnimation(_colors),
                                  minHeight: 20,
                                  value: _progress,
                                )
                            ),
                        ),
                      ),
                ],)
              ])
            ,)
    );
  }

  @override
  Widget build(BuildContext context) {
    return 
    SingleChildScrollView(
      child: 
    Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      // 子要素
      children: [
        // カード
        Card(
          color: Colors.white, // Card自体の色
          // 外側の余白
          margin: const EdgeInsets.all(20),
          elevation: 10, // 影の離れ具合
          shadowColor: Colors.black, // 影の色
          // 枠線を変更できる
          shape: const RoundedRectangleBorder(),
          // 列方向
          child: 
          Padding(padding: EdgeInsets.all(15), child: 
          Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Text('栄養Card', style: optionStyle,),
              SizedBox(height: 10),
              Row(children: [
              nutritionProgress(),
              ],),
              SizedBox(height: 10),
              Row(
                // 横軸の並び
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  nutritionProgress(),
                  SizedBox(width: 10,),
                  nutritionProgress(),
                ],
              ),
              SizedBox(height: 5,),
              Row(
                // 横軸の並び
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  nutritionProgress(),
                  SizedBox(width: 10,),
                  nutritionProgress(),
                ],
              ),
              SizedBox(height: 5,),
              Row(
                // 横軸の並び
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  nutritionProgress(),
                  SizedBox(width: 10,),
                  nutritionProgress(),
                ],
              ),
            ],
          ),
          ),
        ),
        // 食品記録項目
        Container(
          color: Colors.blueGrey,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
            Text('食品項目'),
            Text('12品目'),
            // 記録ボタン
            ElevatedButton(onPressed: (){
              // 食品・食材記録画面へ遷移
              Navigator.push(context, MaterialPageRoute(builder: (context) => record));
              //   setState(() {
                
              // }
            // );
            }, child: Text('記録')),
          ],),
        ),
        // 摂取した食品一覧
        // ListView.builderの区切り追加版。
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
                    print('hello');
                    Navigator.push(context, MaterialPageRoute(builder: (context) => foodDetails));

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
      ]
    ));
  }
}
// settings設定アイコン、search検索アイコン



