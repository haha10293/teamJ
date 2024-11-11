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
                                'https://i.ytimg.com/vi/OGAGT-2w0ac/maxresdefault.jpg',
                                fit: BoxFit.contain,
                              ),
                              tileColor: Colors.amber,
                              title: Container(
                                decoration: BoxDecoration(
                                  border: Border(bottom: BorderSide()),
                                ),
                                child: Text('カレーライス'),
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
                                'https://i.ytimg.com/vi/OGAGT-2w0ac/maxresdefault.jpg',
                                fit: BoxFit.contain,
                              ),
                              tileColor: Colors.blueAccent,
                              title: Container(
                                decoration: BoxDecoration(
                                  border: Border(bottom: BorderSide()),
                                ),
                                child: Text('カレーライス'),
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
