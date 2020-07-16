import 'package:StudyTrackingApp/core/database/database_provider.dart';
import 'package:StudyTrackingApp/core/models/study_input_model/study_input.dart';
import 'package:sqflite/sqflite.dart';

class StudyInputDatabaseProvider extends DatabaseProvider<StudyInput> {
  String _studyInputDBPath = "studyInputDB";
  String _studyInputTableName = "studyInputTable";
  int _version = 1;

  String columnId = "id";
  String columnSubjectId = "subjectId";
  String columnLessonId = "lessonId";
  String columnQuestionNumber = "questionNumber";
  String columnTrueNumber = "trueNumber";
  String columnFalseNumber = "falseNumber";
  String columnNetNumber = "netNumber";
  String columnDate = "date";

  @override
  Future open() async {
    database = await openDatabase(
      _studyInputDBPath,
      version: _version,
      onCreate: (db, version) {
        createTable(db);
      },
    );
  }

  Future<void> createTable(Database db) async {
    await db.execute(
      '''CREATE TABLE $_studyInputTableName ($columnId TEXT PRIMARY KEY, 
            $columnSubjectId TEXT, $columnLessonId TEXT, $columnQuestionNumber INTEGER, 
            $columnTrueNumber INTEGER, $columnFalseNumber INTEGER, $columnNetNumber DOUBLE, $columnDate INTEGER)''',
    );
  }

  @override
  Future<List<StudyInput>> getList() async {
    List<Map> studyInputMaps = await database.query(_studyInputTableName);

    return studyInputMaps.map((e) => StudyInput.fromJson(e)).toList();
  }

  @override
  Future<StudyInput> getItem(String id) async {
    final studyInputMap = await database.query(
      _studyInputTableName,
      where: '$columnId = ?',
      columns: [columnId],
      whereArgs: [id],
    );

    if (studyInputMap.isNotEmpty)
      return StudyInput.fromJson(studyInputMap.first);
    else
      return null;
  }

  @override
  Future<bool> removeItem(String id) async {
    final studyInputMap = await database.delete(
      _studyInputTableName,
      where: '$columnId = ?',
      whereArgs: [id],
    );

    return studyInputMap != null;
  }

  @override
  Future<bool> updateItem(String id, StudyInput model) async {
    final studyInputMap = await database.update(
      _studyInputTableName,
      model.toJson(),
      where: '$columnId = ?',
      whereArgs: [id],
    );

    return studyInputMap != null;
  }

  @override
  Future<bool> insertItem(StudyInput model) async {
    final studyInputMap = await database.insert(
      _studyInputTableName,
      model.toJson(),
    );

    return studyInputMap != null;
  }
}
