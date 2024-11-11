// DB作成クエリ

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  // DB名
  static final _databaseName = "FoodDatabase.db";
  // DBバージョン
  static final _databaseVersion = 1;

  // シングルトンインスタンス
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // DB参照
  static Database? _database;
  Future<Database> get database async {
    // 始めて起動する場合、DBを初期化する.
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!; 
  }

  // DB初期化
  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  // データベースが存在しなかった場合、テーブル作成
  Future _onCreate(Database db, int version) async {

    // 食品テーブル
    await db.execute('''
      CREATE TABLE food_table (
        food_id INTEGER PRIMARY KEY,
        food_name TEXT,
        food_img TEXT,
        kcal REAL,
        protein REAL,
        lipids REAL,
        carbo REAL,
        salt REAL,
        amount REAL,
        unit TEXT
      )
    ''');

    // 食材テーブル
    await db.execute('''
      CREATE TABLE ingredient_table (
        ingredient_id INTEGER PRIMARY KEY,
        ingredient_name TEXT,
        ingredient_img TEXT,
        kcal REAL,
        protein REAL,
        lipids REAL,
        carbo REAL,
        salt REAL,
        amount REAL,
        unit TEXT
      )
    ''');

    // 栄養表(食品)テーブル
    await db.execute('''
      CREATE TABLE nutrition_food_table (
        created_nutrition TEXT,
        food_id INTEGER,
        food_ratio REAL,
        PRIMARY KEY (created_nutrition, food_id),
        FOREIGN KEY (food_id) REFERENCES food (food_id)
      )
    ''');

    // 栄養表(食材)テーブル
    await db.execute('''
      CREATE TABLE nutrition_ingredient_table (
        created_nutrition TEXT,
        ingredient_id INTEGER,
        ingredient_ratio REAL,
        PRIMARY KEY (created_nutrition, ingredient_id),
        FOREIGN KEY (ingredient_id) REFERENCES ingredient (ingredient_id)
      )
    ''');

    // 食品の食材テーブル
    await db.execute('''
      CREATE TABLE food_ingredient_table (
        food_id INTEGER,
        ingredient_id INTEGER,
        ingredient_ratio REAL,
        PRIMARY KEY (food_id, ingredient_id),
        FOREIGN KEY (food_id) REFERENCES food (food_id),
        FOREIGN KEY (ingredient_id) REFERENCES ingredient (ingredient_id)
      )
    ''');

    // ユーザーテーブル
    await db.execute('''
      CREATE TABLE user_table (
        user_id INTEGER PRIMARY KEY,
        height REAL,
        weight REAL,
        age INTEGER,
        gender TEXT
      )
    ''');
  }
}
