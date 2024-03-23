import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'entry_data.dart';

const tableEntries = 'entries';

class EntryFields {
  static final List<String> values = [
    id, title, content
  ];
  static const String id = 'id';
  static const String title = 'title';
  static const String content = 'content';
  static const String time = 'time';
}

class DBHelper {
  static final DBHelper _instance = DBHelper._init();
  static Database? _database;

  DBHelper._init();

  factory DBHelper() {
    return _instance;
  }

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('entries.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 3, onCreate: _createDB, onUpgrade: _onUpgrade);
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (newVersion > oldVersion) {
      // Drop the old entries table
      await db.execute('DROP TABLE IF EXISTS $tableEntries');

      // Create a new entries table with the correct schema
      await _createDB(db, newVersion);
    }
  }
  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const integerType = 'INTEGER';

    await db.execute('''
CREATE TABLE $tableEntries (
  ${EntryFields.id} $idType,
  ${EntryFields.title} $textType,
  ${EntryFields.content} $textType,
  moodRating $integerType, 
  ${EntryFields.time} $integerType
  )
''');
  }

  Future<Entry> createEntry(Entry entry) async {
    final db = await _instance.database;
    final id = await db.insert(tableEntries, entry.toJson());
    return entry.copy(id: id);
  }

  Future<Entry> readEntry(int id) async {
    final db = await _instance.database;
    final maps = await db.query(
      tableEntries,
      columns: EntryFields.values,
      where: '${EntryFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Entry.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<Entry>> readAllEntries() async {
    final db = await _instance.database;
    const orderBy = '${EntryFields.time} ASC';
    final result = await db.query(tableEntries, orderBy: orderBy);
    return result.map((json) => Entry.fromJson(json)).toList();
  }

  Future<int> updateEntry(Entry entry) async {
    final db = await _instance.database;
    return db.update(
      tableEntries,
      entry.toJson(),
      where: '${EntryFields.id} = ?',
      whereArgs: [entry.id],
    );
  }

  Future<int> deleteEntry(int id) async {
    final db = await _instance.database;
    return await db.delete(
      tableEntries,
      where: '${EntryFields.id} = ?',
      whereArgs: [id],
    );
  }
}