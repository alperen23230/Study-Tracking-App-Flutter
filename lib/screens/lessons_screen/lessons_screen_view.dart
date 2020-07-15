import 'package:StudyTrackingApp/screens/lessons_screen/lessons_screen_view_model.dart';
import 'package:StudyTrackingApp/widgets/lesson_item_widget.dart';
import 'package:StudyTrackingApp/widgets/lottie_custom_widget.dart';
import 'package:flutter/material.dart';

class LessonsScreenView extends LessonsScreenViewModel {
  @override
  Widget build(BuildContext context) {
    print("build");
    return !isLoading
        ? ListView.builder(
            itemCount: lessonsList.length,
            itemBuilder: (context, index) {
              return LessonItem(
                lesson: lessonsList[index],
              );
            },
          )
        : Center(
            child: LottieCustomWidget(path: "time"),
          );
  }
}
