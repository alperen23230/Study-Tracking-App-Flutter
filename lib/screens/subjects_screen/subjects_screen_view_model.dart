import 'package:StudyTrackingApp/core/models/lesson_model/lesson.dart';
import 'package:StudyTrackingApp/core/models/subject_model/subject.dart';
import 'package:StudyTrackingApp/core/models/subject_model/subject_database_provider.dart';
import 'package:StudyTrackingApp/screens/subjects_screen/subjects_screen.dart';
import 'package:StudyTrackingApp/widgets/add_subject_widget.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

abstract class SubjectsScreenViewModel extends State<SubjectsScreen> {
  SubjectDatabaseProvider subjectsDB;

  final uuid = Uuid();
  var lessonId = "";

  List<Subject> subjectsList = [];

  @override
  void initState() {
    super.initState();
    subjectsDB = SubjectDatabaseProvider();
    subjectsDB.open().then((_) {
      getSubjects();
    });
  }

  void startAddSubjectFlow(BuildContext ctx, Lesson lesson) {
    showModalBottomSheet(
        context: ctx,
        isScrollControlled: true,
        builder: (_) {
          return GestureDetector(
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(ctx).viewInsets.bottom,
                ),
                child: AddSubjectWidget(
                  addSubject: addSubjectToDB,
                  lesson: lesson,
                ),
              ),
            ),
            onTap: () {},
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  void addSubjectToDB(String name, String lessonId) async {
    if (name.isNotEmpty && lessonId.isNotEmpty) {
      Subject subject = Subject(id: uuid.v4(), name: name, lessonId: lessonId);
      await subjectsDB.insertItem(subject).then((isSuccess) {
        if (isSuccess) {
          print("Subject success");
          getSubjects();
          Navigator.of(context).pop();
        } else {
          print("Subject not successful");
        }
      });
    } else {
      print("alanları doldurun");
    }
  }

  Future<void> getSubjects() async {
    await subjectsDB.getListByLesson(lessonId).then((subjects) {
      setState(() {
        subjectsList = subjects;
      });
    });
  }

  Future<bool> deleteSubject(String id) async {
    var isSuccessfull = false;
    await subjectsDB.removeItem(id).then((isSuccess) {
      isSuccessfull = isSuccess;
    });

    return isSuccessfull;
  }
}
