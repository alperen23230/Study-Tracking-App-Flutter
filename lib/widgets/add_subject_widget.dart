import 'package:StudyTrackingApp/core/models/lesson_model/lesson.dart';
import 'package:flutter/material.dart';

class AddSubjectWidget extends StatefulWidget {
  final Function addSubject;
  final Lesson lesson;
  AddSubjectWidget({this.addSubject, this.lesson});

  @override
  _AddSubjectWidgetState createState() =>
      _AddSubjectWidgetState(addSubject: addSubject, lesson: lesson);
}

class _AddSubjectWidgetState extends State<AddSubjectWidget> {
  TextEditingController subjectNameController = TextEditingController(text: "");
  Function addSubject;
  Lesson lesson;

  _AddSubjectWidgetState({this.addSubject, this.lesson});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Card(
      elevation: 6,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: screenSize.width * 0.8,
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Konu Adı',
              ),
              controller: subjectNameController,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            width: screenSize.width * 0.5,
            child: RaisedButton(
              child: Text(
                "Ekle",
                style: TextStyle(color: Colors.white),
              ),
              color: Theme.of(context).primaryColor,
              onPressed: () =>
                  addSubject(subjectNameController.text, lesson.id),
            ),
          )
        ],
      ),
    );
  }
}
