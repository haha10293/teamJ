import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Record extends StatefulWidget {
  const Record({super.key});

  @override
  RecordState createState() => RecordState();
}

class RecordState extends State<Record> {
  final _formKey = GlobalKey<FormState>();
  final _searchForm = TextEditingController();
  static const TextStyle optionStyle = TextStyle(fontSize: 25, fontWeight: FontWeight.bold);

  // リストデータ
  List<Map<String, dynamic>> foodList = [{"name": "カレーライス","image": "https://housefoods.jp/_sys/catimages/recipe/hfrecipe/items/00022588/0.485-310.jpeg"},{"name":"担々麵","image": "https://cdn.asagei.com/syokuraku/uploads/2020/01/20200112-newtantanmen01.jpg"},{"name": "イギー弁当","image": "https://img-global-jp.cpcdn.com/recipes/5769908/680x482cq70/%E3%82%B8%E3%83%A7%E3%82%B8%E3%83%A7-%E3%82%A4%E3%82%AE%E3%83%BC%E3%81%AE%E3%82%AD%E3%83%A3%E3%83%A9%E5%BC%81-%E3%83%AC%E3%82%B7%E3%83%94-%E3%83%A1%E3%82%A4%E3%83%B3-%E5%86%99%E7%9C%9F.jpg"},];
  List<Map<String, dynamic>> ingredientList = [{"name": "きゅうり","image": "https://video.kurashiru.com/production/articles/6691048b-ce2c-4aa9-85ac-db07b83ddb46/wide_thumbnail_large.jpg?1714620224"},{"name":"トマト","image": "https://agri.mynavi.jp/wp-content/uploads/2018/03/8567_tomato2_hosei-1.jpg.webp"},{"name": "鶏むね肉","image": "https://media.delishkitchen.tv/article/541/v2rtg1dggg.jpeg?version=1615430934"},];


  TextFormField textFormField(IconData a, String b, TextEditingController c, String d, TextInputFormatter e, TextInputType f, [int g = 15]) {
    return TextFormField(
      controller: c,
      decoration: InputDecoration(
        prefixIcon: Icon(a),
        counterText: '',
        hintText: b,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      inputFormatters: [e],
      keyboardType: f,
      maxLength: g,
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
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('食事を記録する'),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back),
          ),
          actions: [
            TextButton(
              onPressed: (){
                // データを更新処理

                // 前の画面に戻る。
                Navigator.pop(context);
              }, 
              child: 
                Text('決定' ,style: TextStyle(color: Colors.blue),)
            )
          ],
        ),
        body: Column(
          children: [
            Container(
              color: Theme.of(context).colorScheme.inversePrimary,
              child: Form(
                key: _formKey,
                child: textFormField(
                  Icons.search,
                  '検索語を入力してください。',
                  _searchForm,
                  '検索語',
                  FilteringTextInputFormatter.deny(''),
                  TextInputType.text,
                ),
              ),
            ),
            // TabBarをColumn内に配置
            TabBar(
              tabs: [
                Tab(text: '食品', ),
                Tab(text: '食材', ),
              ],
              labelColor: Theme.of(context).colorScheme.primary,
            ),
            Expanded(
              child: TabBarView(
                children: [
                  // タブ1: 食品一覧
                  Column(
                    children: [
                      Expanded(
                        child: ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: 3,
                          separatorBuilder: (context, index) => Divider(height: 0.5),
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                              leading: Image.network(
                                foodList[index]["image"],
                                fit: BoxFit.contain,
                              ),
                              tileColor: Colors.amber,
                              title: Container(
                                decoration: BoxDecoration(
                                  border: Border(bottom: BorderSide()),
                                ),
                                child: Text(foodList[index]["name"]),
                              ),
                              subtitle: Text(
                                'カロリー：299kcal　たんぱく質：60g\n脂質：299kcal　炭水化物：60g\n塩分：299kcal',
                              ),
                              onTap: () {},
                              onLongPress: () {
                                showDialog<void>(
                                  context: context,
                                  builder: (_) {
                                    return AlertDialog(
                                      title: const Text('データを消してしまってもいいですか？'),
                                      content: const Text('内容'),
                                      actions: <Widget>[
                                        GestureDetector(
                                          child: const Text('いいえ'),
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                        GestureDetector(
                                          child: const Text('はい'),
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  // タブ2: 食材
                  Column(
                    children: [
                      Expanded(
                        child: ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: 3,
                          separatorBuilder: (context, index) => Divider(height: 0.5),
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                              leading: Image.network(
                                ingredientList[index]["image"],
                                fit: BoxFit.contain,
                              ),
                              tileColor: Colors.blueAccent,
                              title: Container(
                                decoration: BoxDecoration(
                                  border: Border(bottom: BorderSide()),
                                ),
                                child: Text(ingredientList[index]["name"]),
                              ),
                              subtitle: Text(
                                'カロリー：299kcal　たんぱく質：60g\n脂質：299kcal　炭水化物：60g\n塩分：299kcal',
                              ),
                              onTap: () {},
                              onLongPress: () {
                                showDialog<void>(
                                  context: context,
                                  builder: (_) {
                                    return AlertDialog(
                                      title: const Text('データを消してしまってもいいですか？'),
                                      content: const Text('内容'),
                                      actions: <Widget>[
                                        GestureDetector(
                                          child: const Text('いいえ'),
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                        GestureDetector(
                                          child: const Text('はい'),
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
