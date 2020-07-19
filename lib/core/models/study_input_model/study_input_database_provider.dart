import 'package:StudyTrackingApp/core/database/database_provider.dart';
import 'package:StudyTrackingApp/core/models/chart_model/input_chart_model.dart';
import 'package:StudyTrackingApp/core/models/lesson_model/lesson.dart';
import 'package:StudyTrackingApp/core/models/study_input_model/study_input.dart';
import 'package:sqflite/sqflite.dart';

class StudyInputDatabaseProvider extends DatabaseProvider<StudyInput> {
  String _studyInputDBPath = "studyInputDB";
  String _studyInputTableName = "studyInputTable";
  int _version = 6;

  String columnId = "id";
  String columnSubjectId = "subjectId";
  String columnLessonId = "lessonId";
  String columnQuestionNumber = "questionNumber";
  String columnTrueNumber = "trueNumber";
  String columnFalseNumber = "falseNumber";
  String columnNetNumber = "netNumber";
  String columnDate = "date";
  String columnLessonName = "lessonName";
  String columnSubjectName = "subjectName";

  @override
  Future open() async {
    database = await openDatabase(
      _studyInputDBPath,
      version: _version,
      onCreate: (db, version) {
        createTable(db);
      },
      onUpgrade: (db, oldVersion, newVersion) {
        print(oldVersion);
        print(newVersion);
        onUpgradeDB(db, oldVersion, newVersion);
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

  void onUpgradeDB(Database db, int oldVersion, int newVersion) {
    if (oldVersion < newVersion) {
      db.execute(
          "ALTER TABLE $_studyInputTableName ADD COLUMN $columnLessonName TEXT");
      db.execute(
          "ALTER TABLE $_studyInputTableName ADD COLUMN $columnSubjectName TEXT");
    }
  }

  @override
  Future<List<StudyInput>> getList() async {
    List<Map> studyInputMaps = await database.query(_studyInputTableName);

    return studyInputMaps.map((e) => StudyInput.fromJson(e)).toList();
  }

  Future<List<InputChartModel>> getSumListByDate(int timestamp) async {
    final inputMaps = await database.rawQuery("""SELECT
          $columnLessonName,
          SUM($columnQuestionNumber) as TotalQuestion, 
          SUM($columnTrueNumber) as TotalTrue,
          SUM($columnFalseNumber) as TotalFalse, 
          SUM($columnNetNumber) as TotalNet
          FROM $_studyInputTableName WHERE $columnDate = $timestamp GROUP BY $columnLessonName""");
    return inputMaps.map((e) => InputChartModel.fromJson(e)).toList();
  }

  Future<List<InputChartModel>> getSumListByDateRange(
      int startTimeStamp, int endTimeStamp) async {
    final inputMaps = await database.rawQuery("""SELECT
          $columnLessonName,
          SUM($columnQuestionNumber) as TotalQuestion, 
          SUM($columnTrueNumber) as TotalTrue,
          SUM($columnFalseNumber) as TotalFalse, 
          SUM($columnNetNumber) as TotalNet
          FROM $_studyInputTableName WHERE $columnDate >= $startTimeStamp and $columnDate <= $endTimeStamp GROUP BY $columnLessonName""");
    return inputMaps.map((e) => InputChartModel.fromJson(e)).toList();
  }

  Future<List<StudyInput>> getListByDate(int timestamp) async {
    final studyInputMaps = await database.query(
      _studyInputTableName,
      where: '$columnDate = ?',
      whereArgs: [timestamp],
    );

    return studyInputMaps.map((e) => StudyInput.fromJson(e)).toList();
  }

  Future<List<StudyInput>> getListByDateAndLesson(
      int timestamp, String lessonId) async {
    final studyInputMaps = await database.query(
      _studyInputTableName,
      where: '$columnDate = ? and $columnLessonId = ?',
      whereArgs: [timestamp, lessonId],
    );

    return studyInputMaps.map((e) => StudyInput.fromJson(e)).toList();
  }

  Future<List<StudyInput>> getListByDateRangeAndLesson(
      int startTimeStamp, int endTimeStamp, String lessonId) async {
    final studyInputMaps = await database.query(
      _studyInputTableName,
      where: '$columnDate >= ? and $columnDate <= ? and $columnLessonId = ?',
      whereArgs: [startTimeStamp, endTimeStamp, lessonId],
    );

    return studyInputMaps.map((e) => StudyInput.fromJson(e)).toList();
  }

  Future<List<StudyInput>> getListByDateRange(
      int startTimeStamp, int endTimeStamp) async {
    final studyInputMaps = await database.query(
      _studyInputTableName,
      where: '$columnDate >= ? and $columnDate <= ?',
      whereArgs: [startTimeStamp, endTimeStamp],
    );

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
