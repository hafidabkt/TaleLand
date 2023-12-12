import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';

class DatabaseHelper {
  static Database? _database;
  static const String dbName = 'categories.db';

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    final path = await getDatabasesPath();
    final databasePath = join(path, dbName);

    return await openDatabase(
      databasePath,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE IF NOT EXISTS categories (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            imageUrl TEXT
          )
        ''');
      },
    );
  }

  Future<int> insertCategory(Category category) async {
    final db = await database;
    return await db.insert('categories', category.toMap());
  }

  Future<List<Category>> getAllCategories() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('categories');

    return List.generate(maps.length, (index) {
      return Category.fromMap(maps[index]);
    });
  }
}

class Category {
  int? id;
  final String name;
  final String imageUrl;

  Category({this.id, required this.name, required this.imageUrl});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
    };
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['id'],
      name: map['name'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
    );
  }
}

void main() async {
  final dbHelper = DatabaseHelper();

  // Insert categories
  await dbHelper.insertCategory(Category(name: 'Adventure', imageUrl: 'assets/Adventure.png'));
  await dbHelper.insertCategory(Category(name: 'Fantasy', imageUrl: 'assets/Fantasy.png'));

  // Retrieve all categories
  final categories = await dbHelper.getAllCategories();
  categories.forEach((category) {
    print(category.toMap());
  });
}
