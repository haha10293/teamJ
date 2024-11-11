import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // FilteringTextInputFormatter
import 'package:sqflite/sqflite.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'sqflite practice',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'sqflite practice'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late String path;
  late Database database;
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  List _messages = [];

  @override
  void initState() {
    super.initState();
    createDB();
  }

  // DB関連の初期設定
  void createDB() async {
    final databasesPath = await getDatabasesPath();
    path = '$databasesPath/practice.db';
    database = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
            'CREATE TABLE message (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, message TEXT)'
        );
      }
    );
    _updateStatus();
  }

  // 状態更新
  void _updateStatus() async {
    // SELECT
    var listMap = await database.rawQuery('SELECT * FROM message');
    setState(() {
      _messages = listMap;
    });
  }

  void _dbInsert(String name, String message) async {
    // INSERT
    await database.insert(
      'message', // テーブル名
      {'name': name, 'message': message}, // データ
    );
    // 状態更新
    _updateStatus();
  }

  void _dbUpdate(int id, String name, String message) async {
    // idをキーとしてUPDATE
    await database.update(
        'message',
        {'name': name, 'message': message},
        where: 'id = ?',
        whereArgs: [id]
    );
    _updateStatus();
  }

  void _dbDelete(int id) async {
    await database.delete(
        'message',
        where: 'id = ?',
        whereArgs: [id]
    );
    _updateStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _idController,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly]
            ),
            TextField(
              controller: _nameController
            ),
            TextField(
              controller: _messageController,
            ),
            Row(
              children: <Widget>[
                TextButton(onPressed: () => _dbInsert(_nameController.text, _messageController.text), child: const Text("insert")),
                TextButton(onPressed: () => _dbUpdate(int.parse(_idController.text), _nameController.text, _messageController.text), child: const Text("update")),
                TextButton(onPressed: () => _dbDelete(int.parse(_idController.text)), child: const Text("delete")),
              ]
            ),
            for(final message in _messages) ...{
              Text('id = ${message["id"]}, name = ${message["name"]}, message = ${message["message"]}')
            }
          ],
        ),
      ),
    );
  }
}
