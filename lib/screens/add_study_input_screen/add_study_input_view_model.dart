import 'package:StudyTrackingApp/core/models/lesson_model/lesson.dart';
import 'package:StudyTrackingApp/core/models/lesson_model/lesson_database_provider.dart';
import 'package:StudyTrackingApp/core/models/study_input_model/study_input.dart';
import 'package:StudyTrackingApp/core/models/study_input_model/study_input_database_provider.dart';
import 'package:StudyTrackingApp/core/models/subject_model/subject.dart';
import 'package:StudyTrackingApp/core/models/subject_model/subject_database_provider.dart';
import 'package:StudyTrackingApp/screens/add_study_input_screen/add_study_input_screen.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

abstract class AddStudyInputScreenViewModel extends State<AddStudyInputScreen> {
  Lesson selectedLesson;
  Subject selectedSubject;
  StudyInput currentStudyInput;
  bool isEditMode;

  TextEditingController questionNumberController =
      TextEditingController(text: "");
  TextEditingController trueNumberController = TextEditingController(text: "");
  TextEditingController falseNumberController = TextEditingController(text: "");

  double netNumber = 0.0;

  List<Lesson> lessonsList = [];
  List<Subject> subjectsList = [];

  LessonDatabaseProvider lessonsDB;
  SubjectDatabaseProvider subjectsDB;
  StudyInputDatabaseProvider studyInputDB;

  final uuid = Uuid();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    studyInputDB = StudyInputDatabaseProvider();
    lessonsDB = LessonDatabaseProvider();
    subjectsDB = SubjectDatabaseProvider();
    studyInputDB.open();
    lessonsDB.open().then((_) {
      getLessons().then((_) {
        selectedLesson = lessonsList.first;
        subjectsDB.open();
      });
    });
  }

  Future<void> getLessons() async {
    await lessonsDB.getList().then((lessonList) {
      setState(() {
        lessonsList = lessonList;
      });
    });
  }

  Future<void> getSubjects() async {
    await subjectsDB.getListByLesson(selectedLesson.id).then((subjects) {
      setState(() {
        if (subjects != null) {
          subjectsList = subjects;
        } else {
          subjectsList = [];
        }
      });
    });
  }

  calculateNetNumber() {
    if (trueNumberController.text.isNotEmpty &&
        falseNumberController.text.isNotEmpty) {
      double net = int.parse(trueNumberController.text) -
          (int.parse(falseNumberController.text) * 0.25);
      setState(() {
        netNumber = net;
      });
    } else {
      setState(() {
        netNumber = 0.0;
      });
    }
    print(netNumber.toString());
  }

  void addStudyInput(BuildContext ctx) async {
    if (selectedLesson != null &&
        selectedSubject != null &&
        questionNumberController.text.isNotEmpty &&
        trueNumberController.text.isNotEmpty &&
        falseNumberController.text.isNotEmpty) {
      int questionNumber = int.parse(questionNumberController.text);
      int trueNumber = int.parse(trueNumberController.text);
      int falseNumber = int.parse(falseNumberController.text);
      if (questionNumber >= trueNumber + falseNumber) {
        StudyInput studyInputModel = StudyInput(
            id: uuid.v4(),
            lessonId: selectedLesson.id,
            subjectId: selectedSubject.id,
            questionNumber: questionNumber,
            trueNumber: trueNumber,
            falseNumber: falseNumber,
            netNumber: netNumber,
            date: DateTime(
              DateTime.now().year,
              DateTime.now().month,
              DateTime.now().day,
            ).millisecondsSinceEpoch,
            lessonName: selectedLesson.name,
            subjectName: selectedSubject.name);
        if (isEditMode) {
          await studyInputDB
              .updateItem(currentStudyInput.id, studyInputModel)
              .then((isSuccess) {
            if (isSuccess) {
              Navigator.of(ctx).pushNamedAndRemoveUntil(
                '/tabs-screen',
                (route) => false,
              );
            } else {
              print("error");
            }
          });
        } else {
          await studyInputDB.insertItem(studyInputModel).then((isSuccess) {
            if (isSuccess) {
              Navigator.of(ctx).pushNamedAndRemoveUntil(
                '/tabs-screen',
                (route) => false,
              );
            } else {
              print("error");
            }
          });
        }
      } else {
        scaffoldKey.currentState.showSnackBar(
          SnackBar(
            content: Text("Girdiğiniz sayılar birbiriyle uyuşmamaktadır!"),
            backgroundColor: Colors.red,
          ),
        );
      }
    } else {
      scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text("Lütfen boş alanları doldurunuz!"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
