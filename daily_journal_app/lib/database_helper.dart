// ignore_for_file: constant_identifier_names

import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'entry_data.dart';

class DBHelper {
  static Database? _db;
  static const String ID = 'id';
  static const String TITLE = 'title';
  static const String CONTENT = 'content';
  static const String SLEEPRATING = 'sleep';
  static const String DIETRATING = 'diet';
  static const String MOODRATING = 'mood';
  static const String TABLE = 'entryTable';
  static const String DB_Name = 'entries.db';
  late Database _data;
  Future<Database?> get db async {
    if (null != _db) {
      return _db;
    }
    _db = await initDB();
    return _db;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, DB_Name);
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE $TABLE ($ID INTEGER PRIMARY KEY AUTOINCREMENT, $TITLE TEXT, $CONTENT TEXT, $DIETRATING INT, $MOODRATING INT, $SLEEPRATING INT)');
  }

  Future<Entry> save(Entry entry) async {
    await _data.insert(TABLE, entry.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return entry;
  }

  Future<List<Entry>> getEntries() async {
    var dbClient = await db;
    List<Map> maps = await dbClient!.query(TABLE,
        columns: [ID, TITLE, CONTENT, DIETRATING, MOODRATING, SLEEPRATING]);
    List<Entry> entries = [];
    if (maps.isNotEmpty) {
      for (int i = 0; i < maps.length; i++) {
        entries.add(Entry.fromMap(Map<String, dynamic>.from(maps[i])));
      }
    }
    return entries;
  }

  Future close() async {
    var dbClient = await db;
    dbClient!.close();
  }

  Future<List<Map<String, dynamic>>> refreshNotes() async {
    var dbClient = await db;
    final List<Map<String, dynamic>> entries = await dbClient!.query(TABLE);
    return entries;
  }
}




// import 'entry_data.dart';
// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';

// class DatabaseHelper {
//   static const int _version = 1;
//   static const String _dbName = "Entries.db";

//   static Future<Database> _getDB() async {
//     return openDatabase(join(await getDatabasesPath(), _dbName),
//         onCreate: (db, version) async => await db.execute(
//             "CREATE TABLE Entry(id INTEGER PRIMARY KEY, title TEXT NOT NULL, context TEXT NOT NULL, time TEXT NOT NULL);"),
//         version: _version);
//   }

//   static Future<int> addNote(Entry entry) async {
//     final db = await _getDB();
//     return await db.insert("Entry", entry.toJson(),
//         conflictAlgorithm: ConflictAlgorithm.replace);
//   }

//   static Future<int> updateNote(Entry entry) async {
//     final db = await _getDB();
//     return await db.update("Entry", entry.toJson(),
//         where: 'id = ?',
//         whereArgs: [entry.id],
//         conflictAlgorithm: ConflictAlgorithm.replace);
//   }

//   static Future<int> deleteNote(Entry entry) async {
//     final db = await _getDB();
//     return await db.delete(
//       "Entry",
//       where: 'id = ?',
//       whereArgs: [entry.id],
//     );
//   }

//   static Future<List<Entry>?> getAllNotes() async {
//     final db = await _getDB();

//     final List<Map<String, dynamic>> maps = await db.query("Entry");

//     if (maps.isEmpty) {
//       return null;
//     }

//     return List.generate(maps.length, (index) => Entry.fromJson(maps[index]));
//   }
// }
