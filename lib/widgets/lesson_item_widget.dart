import 'package:flutter/material.dart';
import '../core/models/lesson_model/lesson.dart';

class LessonItem extends StatelessWidget {
  final Lesson lesson;
  LessonItem({this.lesson});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Container(
      width: screenSize.width * 0.8,
      height: 75,
      child: Card(
        elevation: 6,
        color: Color.fromRGBO(lesson.lessonColorRed, lesson.lessonColorGreen,
            lesson.lessonColorBlue, 1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Center(
          child: Text(
            lesson.name,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(
                              lesson.lessonColorRed,
                              lesson.lessonColorGreen,
                              lesson.lessonColorBlue,
                              1)
                          .computeLuminance() >
                      0.5
                  ? Colors.black
                  : Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
