import 'package:StudyTrackingApp/core/models/lesson_model/lesson.dart';
import 'package:StudyTrackingApp/core/models/lesson_model/lesson_database_provider.dart';
import 'package:StudyTrackingApp/screens/add_lesson_screen/add_lesson_screen.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

abstract class AddLessonViewModel extends State<AddLessonScreen> {
  TextEditingController lessonNameController = TextEditingController(text: "");
  Color pickerColor = Colors.deepPurpleAccent;
  Color currentColor = Colors.deepPurpleAccent;

  LessonDatabaseProvider lessonsDB;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  final uuid = Uuid();

  @override
  void initState() {
    super.initState();
    lessonsDB = LessonDatabaseProvider();
    lessonsDB.open();
  }

  void changeColor(Color color) {
    setState(() => pickerColor = color);
  }

  Future<void> addLesson() async {
    if (lessonNameController.text.isNotEmpty &&
        lessonNameController.text != "") {
      Lesson lesson = Lesson(
          id: uuid.v4(),
          name: lessonNameController.text,
          lessonColorRed: currentColor.red,
          lessonColorBlue: currentColor.blue,
          lessonColorGreen: currentColor.green);
      await lessonsDB.insertItem(lesson).then((isSuccess) {
        if (isSuccess) {
          setState(() {
            lessonNameController.text = "";
          });
          scaffoldKey.currentState.showSnackBar(SnackBar(
            content: Text("Ders başarıyla kaydedildi"),
            backgroundColor: Colors.green,
          ));
        } else {
          print("ders kayıt başarısız");
        }
      });
    } else {
      //popup error later
      scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text("Lütfen boş alanları doldurunuz!"),
        backgroundColor: Colors.red,
      ));
    }
  }
}
