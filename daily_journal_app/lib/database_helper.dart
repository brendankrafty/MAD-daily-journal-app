import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'entry_data.dart';

class DBHelper {
  static final DBHelper _instance = DBHelper._init();
  static Database? _database;

  DBHelper._init();

  factory DBHelper() {
    return _instance;
  }

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await openDatabase(join(await getDatabasesPath(), 'entries.db'), version: 3, onCreate: _createDB, onUpgrade: _onUpgrade);
    return _database!;
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
CREATE TABLE entries (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  title TEXT NOT NULL,
  content TEXT NOT NULL,
  moodRating INTEGER,
  time INTEGER
  )
''');
  }

  Future _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (newVersion > oldVersion) {
      await db.execute('DROP TABLE IF EXISTS entries');
      await _createDB(db, newVersion);
    }
  }

  Future<Entry> createEntry(Entry entry) async {
    final id = await (await _instance.database).insert('entries', entry.toJson());
    return entry.copy(id: id);
  }

  Future<Entry> readEntry(int id) async {
    final maps = await (await _instance.database).query('entries', columns: ['id', 'title', 'content', 'time'], where: 'id = ?', whereArgs: [id]);
    if (maps.isNotEmpty) return Entry.fromJson(maps.first);
    else throw Exception('ID $id not found');
  }

  Future<List<Entry>> readAllEntries() async {
    final result = await (await _instance.database).query('entries', orderBy: 'time ASC');
    return result.map((json) => Entry.fromJson(json)).toList();
  }

  Future<int> updateEntry(Entry entry) async {
    return (await _instance.database).update('entries', entry.toJson(), where: 'id = ?', whereArgs: [entry.id]);
  }

  Future<int> deleteEntry(int id) async {
    return await (await _instance.database).delete('entries', where: 'id = ?', whereArgs: [id]);
  }
}