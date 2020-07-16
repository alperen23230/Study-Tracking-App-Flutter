import 'package:flutter/material.dart';
import '../core/models/lesson_model/lesson.dart';

class LessonItem extends StatelessWidget {
  final Lesson lesson;
  LessonItem({this.lesson});

  void lessonClicked(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(
      '/subjects',
      arguments: {
        'lesson': lesson,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final lessonColor = Color.fromRGBO(lesson.lessonColorRed,
        lesson.lessonColorGreen, lesson.lessonColorBlue, 1);
    return InkWell(
      onTap: () => lessonClicked(context),
      splashColor: Theme.of(context).accentColor,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        width: screenSize.width * 0.8,
        height: 75,
        child: Card(
          elevation: 6,
          color: lessonColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Center(
            child: Text(
              lesson.name,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: lessonColor.computeLuminance() > 0.5
                    ? Colors.grey[700]
                    : Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
