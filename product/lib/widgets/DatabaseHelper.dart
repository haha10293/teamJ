// DB作成クエリ

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  // DB名
  static final _databaseName = "FoodDatabase.db";
  // DBバージョン
  static final _databaseVersion = 1;

  // プライベートコンストラクタ
  DatabaseHelper._internal();
  // シングルトンインスタンス（クラス唯一のインスタンス）
  static final DatabaseHelper instance = DatabaseHelper._internal();

  // DB参照
  // キャッシュ
  static Database? _database;
    // 初回起動の場合、DBを初期化、
    // DBが存在する場合、キャッシュを返却。
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!; 
  }

  // DB初期化
  Future<Database> _initDatabase() async {
    // データベースのパス
    String path = join(await getDatabasesPath(), _databaseName);
    // 存在しない場合DBが新規作成、存在する場合open
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  // テーブル作成
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

    // 栄養表(メイン)テーブル
    await db.execute('''
      CREATE TABLE nutrition_main_table (
        created_nutrition TEXT PRIMARY KEY,
        target_kcal REAL,
        target_protein REAL,
        target_lipids REAL,
        target_carbo REAL,
        target_salt REAL,
        total_kcal REAL,
        total_protein REAL,
        total_lipids REAL,
        total_carbo REAL,
        total_salt REAL,
      )
    ''');

    // 栄養表(食品)テーブル
    await db.execute('''
      CREATE TABLE nutrition_food_table (
        created_nutrition TEXT,
        food_id INTEGER,
        food_ratio REAL,
        PRIMARY KEY (created_nutrition, food_id),
        FOREIGN KEY (food_id) REFERENCES food_table (food_id)
      )
    ''');

    // 栄養表(食材)テーブル
    await db.execute('''
      CREATE TABLE nutrition_ingredient_table (
        created_nutrition TEXT,
        ingredient_id INTEGER,
        ingredient_ratio REAL,
        PRIMARY KEY (created_nutrition, ingredient_id),
        FOREIGN KEY (ingredient_id) REFERENCES ingredient_table (ingredient_id)
      )
    ''');

    // 自炊の食材テーブル
    await db.execute('''
      CREATE TABLE food_ingredient_table (
        food_id INTEGER,
        ingredient_id INTEGER,
        ingredient_ratio REAL,
        PRIMARY KEY (food_id, ingredient_id),
        FOREIGN KEY (food_id) REFERENCES food_table (food_id),
        FOREIGN KEY (ingredient_id) REFERENCES ingredient_table (ingredient_id)
      )
    ''');

    // ユーザーテーブル
    await db.execute('''
      CREATE TABLE user_table (
        user_id INTEGER PRIMARY KEY,
        uid TEXT,
        user_name TEXT,
        height REAL,
        weight REAL,
        age INTEGER,
        gender TEXT,
        target_kcal REAL,
        activity_level INTEGER
      )
    ''');
  }
}
