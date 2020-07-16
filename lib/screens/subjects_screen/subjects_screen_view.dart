import 'package:StudyTrackingApp/core/models/lesson_model/lesson.dart';
import 'package:StudyTrackingApp/screens/subjects_screen/subjects_screen_view_model.dart';
import 'package:flutter/material.dart';

class SubjectsScreenView extends SubjectsScreenViewModel {
  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, Lesson>;
    final lesson = routeArgs['lesson'];
    final lessonColor = Color.fromRGBO(lesson.lessonColorRed,
        lesson.lessonColorGreen, lesson.lessonColorBlue, 1);
    lessonId = lesson.id;
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            color: lessonColor.computeLuminance() > 0.5
                ? Colors.grey[700]
                : Colors.white,
            onPressed: () => startAddSubjectFlow(context, lesson),
          ),
        ],
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: lessonColor.computeLuminance() > 0.5
                ? Colors.grey[700]
                : Colors.white,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          lesson.name,
          style: TextStyle(
            color: lessonColor.computeLuminance() > 0.5
                ? Colors.grey[700]
                : Colors.white,
          ),
        ),
        backgroundColor: lessonColor,
      ),
      body: ListView.builder(
        itemCount: subjectsList.length,
        itemBuilder: (context, index) {
          return Dismissible(
            key: Key(subjectsList[index].id),
            background: Container(
              alignment: AlignmentDirectional.centerEnd,
              padding: EdgeInsets.symmetric(horizontal: 20),
              color: Colors.red,
              child: Icon(
                Icons.delete,
                color: Colors.white,
              ),
            ),
            onDismissed: (direction) {
              deleteSubject(subjectsList[index].id).then((isSuccess) {
                if (isSuccess) {
                  setState(() {
                    subjectsList.remove(subjectsList[index]);
                  });
                }
              });
            },
            child: Card(
              child: ListTile(
                title: Text(subjectsList[index].name),
              ),
            ),
          );
        },
      ),
    );
  }
}
