import 'package:StudyTrackingApp/core/database/database_provider.dart';
import 'package:StudyTrackingApp/core/models/subject_model/subject.dart';
import 'package:sqflite/sqflite.dart';

class SubjectDatabaseProvider extends DatabaseProvider<Subject> {
  String _subjectDBPath = "subjectDB";
  String _subjectTableName = "subjectTable";
  int _version = 1;

  String columnId = "id";
  String columnName = "name";
  String columnLessonId = "lessonId";

  @override
  Future open() async {
    database = await openDatabase(
      _subjectDBPath,
      version: _version,
      onCreate: (db, version) {
        createTable(db);
      },
    );
  }

  Future<void> createTable(Database db) async {
    await db.execute(
      '''CREATE TABLE $_subjectTableName ($columnId TEXT PRIMARY KEY, 
            $columnName TEXT, $columnLessonId TEXT)''',
    );
  }

  @override
  Future<List<Subject>> getList() async {
    List<Map> subjectMaps = await database.query(_subjectTableName);

    return subjectMaps.map((e) => Subject.fromJson(e)).toList();
  }

  Future<List<Subject>> getListByLesson(String lessonId) async {
    List<Map> subjectMaps = await database.query(
      _subjectTableName,
      where: '$columnLessonId = ?',
      whereArgs: [lessonId],
    );

    return subjectMaps.map((e) => Subject.fromJson(e)).toList();
  }

  @override
  Future<Subject> getItem(String id) async {
    final subjectMap = await database.query(
      _subjectTableName,
      where: '$columnId = ?',
      columns: [columnId, columnName],
      whereArgs: [id],
    );

    if (subjectMap.isNotEmpty)
      return Subject.fromJson(subjectMap.first);
    else
      return null;
  }

  @override
  Future<bool> removeItem(String id) async {
    final subjectMap = await database.delete(
      _subjectTableName,
      where: '$columnId = ?',
      whereArgs: [id],
    );

    return subjectMap != null;
  }

  @override
  Future<bool> updateItem(String id, Subject model) async {
    final subjectMap = await database.update(
      _subjectTableName,
      model.toJson(),
      where: '$columnId = ?',
      whereArgs: [id],
    );

    return subjectMap != null;
  }

  @override
  Future<bool> insertItem(Subject model) async {
    final subjectMap = await database.insert(
      _subjectTableName,
      model.toJson(),
    );

    return subjectMap != null;
  }
}
