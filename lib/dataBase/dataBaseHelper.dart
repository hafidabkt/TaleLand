import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import '../class/profileClass.dart';
import '../class/bookClass.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  factory DatabaseHelper() => _instance;

  static late Database _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database;

    // If _database is null, initialize it
    _database = await initDatabase();
    return _database;
  }

  Future<Database> initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'your_database_name.db');

    // Open the database
    return await openDatabase(path,
        version: 2, onCreate: _createTables, onUpgrade: _onUpgrade);
  }

  Future<void> _createTables(Database db, int version) async {
    // Create your tables here
    await db.execute('''
      CREATE TABLE IF NOT EXISTS books (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        category INTEGER,
        title TEXT,
        image TEXT,
        description TEXT,
        authorId INTEGER,
        likes INTEGER,
        rating INTEGER,
        views INTEGER,
        comments INTEGER,
        isPublished INTEGER,
        tags TEXT,
        bookId INTEGER
      )
    ''');

    await db.execute('''
      CREATE TABLE IF NOT EXISTS parts (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        bookId INTEGER,
        title TEXT,
        content TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE IF NOT EXISTS profiles (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        imageUrl TEXT,
        bio TEXT,
        followers TEXT,
        views TEXT,
        bookList INTEGER,
        published INTEGER,
        gender TEXT,
        publishedBooks TEXT,
        readingList TEXT,
        favoriteBooks TEXT,
        followersList TEXT,
        followeesList TEXT,
        blockedList TEXT,
        forYou TEXT
      )
    ''');
  }

  Future<int> insertBook(Book book) async {
    Database db = await database;
    return await db.insert('books', book.toMap());
  }

  Future<void> printBookDetails(int bookId) async {
    Database db = await database;

    List<Map<String, dynamic>> result = await db.query(
      'books',
      where: 'bookId = ?',
      whereArgs: [bookId],
    );

    if (result.isNotEmpty) {
      Book book = Book.fromMap(result.first);
      // Print book details
      book.printDetails();
    } else {
      print('Book not found in the database.');
    }
  }



  Future<int> insertPart(Part part, int bookId) async {
    Database db = await database;
    return await db.insert('parts', {...part.toMap(), 'bookId': bookId});
  }

  Future<int> insertProfile(Profile profile) async {
    Database db = await database;
    return await db.insert('profiles', profile.toMap());
  }

  Future<Profile?> getProfile(int profileId) async {
    Database db = await database;
    List<Map<String, dynamic>> result = await db.query(
      'profiles',
      where: 'id = ?',
      whereArgs: [profileId],
    );

    if (result.isNotEmpty) {
      return Profile.fromMap(result.first);
    }

    return null;
  }

  void _onUpgrade(Database db, int oldVersion, int newVersion) {
    if (oldVersion < 2) {
      // Add migration steps here
    }
  }

  Future<Profile?> getProfileById(int profileId) async {
    Database db = await database;
    List<Map<String, dynamic>> result = await db.query(
      'profiles',
      where: 'id = ?',
      whereArgs: [profileId],
    );

    if (result.isNotEmpty) {
      return Profile.fromMap(result.first);
    }

    return null;
  }

  Future<Book?> getBookById(int bookId) async {
    Database db = await database;
    List<Map<String, dynamic>> result = await db.query(
      'books',
      where: 'bookId = ?',
      whereArgs: [bookId],
    );

    if (result.isNotEmpty) {
      // Assume the 'authorId' in the 'books' table corresponds to the 'id' in the 'profiles' table
      int authorId = result.first['authorId'];
      Profile author = await getProfileById(authorId) ??
          authors[0]; // Replace 'Profile()' with appropriate default value

      List<Map<String, dynamic>> partResults = await db.query(
        'parts',
        where: 'bookId = ?',
        whereArgs: [bookId],
      );

      List<Part> parts =
          partResults.map((partMap) => Part.fromMap(partMap)).toList();
      Book book = Book.fromMap(result.first);
      book.setAuthorAndParts(author, parts);
      return book;
    }

    return null;
  }
}
