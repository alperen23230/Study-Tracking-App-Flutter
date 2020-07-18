import 'package:StudyTrackingApp/core/models/lesson_model/lesson.dart';
import 'package:StudyTrackingApp/core/models/lesson_model/lesson_database_provider.dart';
import 'package:StudyTrackingApp/core/models/study_input_model/study_input.dart';
import 'package:StudyTrackingApp/core/models/study_input_model/study_input_database_provider.dart';
import 'package:StudyTrackingApp/core/models/subject_model/subject_database_provider.dart';
import 'package:StudyTrackingApp/screens/study_input_screen/study_input_screen.dart';
import 'package:StudyTrackingApp/widgets/filter_study_input_widget.dart';
import 'package:flutter/material.dart';

abstract class StudyInputScreenViewModel extends State<StudyInputScreen> {
  List<StudyInput> studyInputList = [];
  List<Lesson> lessonsList = [];

  LessonDatabaseProvider lessonDB;
  SubjectDatabaseProvider subjectDB;
  StudyInputDatabaseProvider studyInputDB;

  Lesson selectedLesson;

  @override
  void initState() {
    super.initState();
    lessonDB = LessonDatabaseProvider();
    subjectDB = SubjectDatabaseProvider();
    studyInputDB = StudyInputDatabaseProvider();
    lessonDB.open().then((_) => getLessons());
    subjectDB.open();
    studyInputDB.open().then((_) => getStudyInputs());
  }

  Future<void> getLessons() async {
    await lessonDB.getList().then((list) {
      setState(() {
        lessonsList = list;
      });
    });
  }

  void getStudyInputs() async {
    final now = DateTime.now();
    final todayTimeStamp =
        DateTime(now.year, now.month, now.day).millisecondsSinceEpoch;
    await studyInputDB.getListByDate(todayTimeStamp).then((list) {
      setState(() {
        studyInputList = list;
      });
    });
  }

  void startFilterFlow(BuildContext ctx) {
    showBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          child: FilterStudyInput(
            lessonsList: lessonsList,
            filterClicked: filterClicked,
          ),
          onTap: () {},
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  void filterClicked(bool isDateRange, DateTime selectedDate, DateTime startDay,
      DateTime endDay, String lessonId) async {
    if (isDateRange) {
      //Get list by date range
      if (lessonId == "") {
        await studyInputDB
            .getListByDateRange(
                startDay.millisecondsSinceEpoch, endDay.millisecondsSinceEpoch)
            .then((list) {
          setState(() {
            studyInputList = list;
          });
        });
      } else {
        await studyInputDB
            .getListByDateRangeAndLesson(startDay.millisecondsSinceEpoch,
                endDay.millisecondsSinceEpoch, lessonId)
            .then((list) {
          setState(() {
            studyInputList = list;
          });
        });
      }
    } else {
      //Get list by date
      if (lessonId == "") {
        await studyInputDB
            .getListByDate(selectedDate.millisecondsSinceEpoch)
            .then((list) {
          setState(() {
            studyInputList = list;
          });
        });
      } else {
        await studyInputDB
            .getListByDateAndLesson(
                selectedDate.millisecondsSinceEpoch, lessonId)
            .then((list) {
          setState(() {
            studyInputList = list;
          });
        });
      }
    }
    Navigator.of(context).pop();
  }
}
