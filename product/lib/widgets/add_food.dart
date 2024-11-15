import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// 食品
class AddFood extends StatefulWidget {
  const AddFood({super.key});

  @override
  AddFoodState createState() => AddFoodState();
}

class AddFoodState extends State<AddFood> {
  static const TextStyle optionStyle = TextStyle(fontSize: 25, fontWeight: FontWeight.bold);
  double _progress = 0;
  List<int> rgbo = [63, 81, 181];
  double _opacity = 1.0;
   // ドロップダウンリストのアイテム
  final List<String> items = ['g', 'ml', 'cc', '個', '袋'];
  // クラスメンバとして初期化
  String? selectedValue = 'g'; 


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
                  keyboardType: TextInputType.number, // キーボードの種類を指定
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
            // 食品名
            textForm(1, 15, 1, 10, "食品名", "食品名を入力してください", "", deviceWidth),
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
                    const Text('食品の画像', style: optionStyle,),
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
                const Text("栄養素", style: optionStyle,),
                Padding(
                  padding: EdgeInsets.only(top: 8, right: 0, bottom: 10, left: deviceWidth-350),
                  // SizedBoxはサイズ変更できんくて入れたけど多分もっといいやつありそう
                  child: SizedBox(
                    height: 60, 
                    width: 140,
                    child: ElevatedButton(
                      onPressed: (){}, 
                      style:ButtonStyle(
                        shape: WidgetStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(6))),
                      ),
                      child:const Column(children: [
                        Padding(
                          padding: EdgeInsets.only(top: 8, right: 5, bottom: 5, left: 5),
                          child: 
                          Icon(Icons.camera_alt),
                        ),
                        Text('スキャン'),
                      ],),
                    )
                  ),
                ) 
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
                      labelText: "単位量",
                      hintText: '単位量を入力してください',
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
              // 栄養素の入力欄
              // エネルギー 
              textForm(8, 15, 1, 10, "エネルギー(kcal)", "エネルギー量を入力してください", "kcal", deviceWidth),
              // たんぱく質 
              textForm(1, 15, 1, 10, "たんぱく質(g)", "たんぱく質量を入力してください", "g", deviceWidth),
              // 脂質 
              textForm(1, 15, 1, 10, "脂質(g)", "脂質を入力してください", "g", deviceWidth),
              // 炭水化物
              textForm(1, 15, 1, 10, "炭水化物(g)", "炭水化物量を入力してください", "g", deviceWidth),
              // 食塩相当量   
              textForm(1, 15, 1, 10, "食塩相当量(g)", "食塩相当量を入力してください", "g", deviceWidth),
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
