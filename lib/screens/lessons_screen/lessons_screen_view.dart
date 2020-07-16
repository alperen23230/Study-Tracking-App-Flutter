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
              return Dismissible(
                key: Key(lessonsList[index].id),
                background: Container(
                  alignment: AlignmentDirectional.centerEnd,
                  // padding: EdgeInsets.symmetric(horizontal: 20),
                  color: Colors.red,
                  child: Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                ),
                onDismissed: (direction) {
                  deleteLessonFromDB(lessonsList[index].id).then((isSuccess) {
                    if (isSuccess) {
                      setState(() {
                        lessonsList.remove(lessonsList[index]);
                      });
                    }
                  });
                },
                child: LessonItem(
                  lesson: lessonsList[index],
                ),
              );
            },
          )
        : Center(
            child: LottieCustomWidget(path: "time"),
          );
  }
}
