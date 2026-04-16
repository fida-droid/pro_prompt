import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/prompt.dart';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  factory DatabaseService() => _instance;
  DatabaseService._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'pro_prompt.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE prompts(
            id TEXT PRIMARY KEY,
            title TEXT,
            text TEXT,
            imageUrl TEXT,
            category TEXT,
            isPremium INTEGER,
            isFavorite INTEGER
          )
        ''');
      },
    );
  }

  Future<void> insertPrompt(Prompt prompt) async {
    final db = await database;
    await db.insert('prompts', prompt.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Prompt>> getPrompts() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('prompts');
    return List.generate(maps.length, (i) => Prompt.fromMap(maps[i]));
  }

  Future<void> updateFavorite(String id, bool isFavorite) async {
    final db = await database;
    await db.update(
      'prompts',
      {'isFavorite': isFavorite ? 1 : 0},
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
