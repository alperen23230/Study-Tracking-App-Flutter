import 'package:StudyTrackingApp/core/database/database_provider.dart';
import 'package:StudyTrackingApp/core/models/lesson_model/lesson.dart';
import 'package:sqflite/sqflite.dart';

class LessonDatabaseProvider extends DatabaseProvider<Lesson> {
  String _lessonDBPath = "lessonDB";
  String _lessonTableName = "lessonTable";
  int _version = 1;

  String columnId = "Id";
  String columnName = "Name";
  String columnColorRed = "ColorRed";
  String columnColorGreen = "ColorGreen";
  String columnColorBlue = "ColorBlue";

  @override
  Future open() async {
    database = await openDatabase(
      _lessonDBPath,
      version: _version,
      onCreate: (db, version) {
        createTable(db);
      },
    );
  }

  Future<void> createTable(Database db) async {
    await db.execute(
      '''CREATE TABLE $_lessonTableName ($columnId TEXT PRIMARY KEY, 
            $columnName TEXT, $columnColorRed INTEGER, $columnColorGreen INTEGER, $columnColorBlue INTEGER)''',
    );
  }

  @override
  Future<List<Lesson>> getList() async {
    List<Map> lessonMaps = await database.query(_lessonTableName);

    return lessonMaps.map((e) => Lesson.fromJson(e)).toList();
  }

  @override
  Future<Lesson> getItem(String id) async {
    final lessonMap = await database.query(
      _lessonTableName,
      where: '$columnId = ?',
      columns: [columnId, columnName],
      whereArgs: [id],
    );

    if (lessonMap.isNotEmpty)
      return Lesson.fromJson(lessonMap.first);
    else
      return null;
  }

  @override
  Future<bool> removeItem(String id) async {
    final lessonMap = await database.delete(
      _lessonTableName,
      where: '$columnId = ?',
      whereArgs: [id],
    );

    return lessonMap != null;
  }

  @override
  Future<bool> updateItem(String id, Lesson model) async {
    final lessonMap = await database.update(
      _lessonTableName,
      model.toJson(),
      where: '$columnId = ?',
      whereArgs: [id],
    );

    return lessonMap != null;
  }

  @override
  Future<bool> insertItem(Lesson model) async {
    final lessonMap = await database.insert(
      _lessonTableName,
      model.toJson(),
    );

    return lessonMap != null;
  }
}
