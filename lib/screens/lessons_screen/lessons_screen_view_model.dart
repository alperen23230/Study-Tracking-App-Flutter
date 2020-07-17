import 'package:StudyTrackingApp/core/models/lesson_model/lesson.dart';
import 'package:StudyTrackingApp/core/models/lesson_model/lesson_database_provider.dart';
import 'package:StudyTrackingApp/screens/lessons_screen/lessons_screen.dart';
import 'package:flutter/material.dart';

abstract class LessonsScreenViewModel extends State<LessonsScreen> {
  List<Lesson> lessonsList = [];
  LessonDatabaseProvider lessonsDB;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    print("state initialize");
    lessonsDB = LessonDatabaseProvider();
    lessonsDB.open().then((_) {
      Future.delayed(const Duration(milliseconds: 1000), () {
        getLessons();
      });
    });
  }

  Future<void> getLessons() async {
    await lessonsDB.getList().then((lessonList) {
      setState(() {
        isLoading = false;
        lessonsList = lessonList;
      });
    });
  }

  Future<bool> deleteLessonFromDB(String id) async {
    var isSuccessful = false;
    await lessonsDB.removeItem(id).then((isSuccess) {
      isSuccessful = isSuccess;
    });
    return isSuccessful;
  }
}
