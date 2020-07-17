import 'package:StudyTrackingApp/core/models/lesson_model/lesson_database_provider.dart';
import 'package:StudyTrackingApp/core/models/study_input_model/study_input.dart';
import 'package:StudyTrackingApp/core/models/study_input_model/study_input_database_provider.dart';
import 'package:StudyTrackingApp/core/models/subject_model/subject_database_provider.dart';
import 'package:StudyTrackingApp/screens/study_input_screen/study_input_screen.dart';
import 'package:flutter/material.dart';

abstract class StudyInputScreenViewModel extends State<StudyInputScreen> {
  List<StudyInput> studyInputList = [];

  LessonDatabaseProvider lessonDB;
  SubjectDatabaseProvider subjectDB;
  StudyInputDatabaseProvider studyInputDB;

  @override
  void initState() {
    super.initState();
    lessonDB = LessonDatabaseProvider();
    subjectDB = SubjectDatabaseProvider();
    studyInputDB = StudyInputDatabaseProvider();
    lessonDB.open();
    subjectDB.open();
    studyInputDB.open().then((_) => getStudyInputs());
  }

  void getStudyInputs() async {
    await studyInputDB.getList().then((list) {
      setState(() {
        studyInputList = list;
      });
    });
  }
}
