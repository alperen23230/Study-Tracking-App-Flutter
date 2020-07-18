import 'package:StudyTrackingApp/screens/study_input_screen/study_input_screen_view_model.dart';
import 'package:StudyTrackingApp/widgets/lottie_custom_widget.dart';
import 'package:StudyTrackingApp/widgets/study_input_item.dart';
import 'package:flutter/material.dart';

class StudyInputScreenView extends StudyInputScreenViewModel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.filter_list),
        onPressed: () => startFilterFlow(context),
      ),
      body: studyInputList.isEmpty
          ? Center(child: LottieCustomWidget(path: "empty"))
          : ListView.builder(
              itemCount: studyInputList.length,
              itemBuilder: (context, index) {
                return Dismissible(
                  key: Key(studyInputList[index].id),
                  background: Container(
                    alignment: AlignmentDirectional.centerStart,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    color: Colors.amber,
                    child: Icon(
                      Icons.edit,
                      color: Colors.white,
                    ),
                  ),
                  secondaryBackground: Container(
                    alignment: AlignmentDirectional.centerEnd,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    color: Colors.red,
                    child: Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                  ),
                  onDismissed: (direction) {
                    if (direction == DismissDirection.startToEnd) {
                      print("edit");
                    } else {
                      studyInputDB
                          .removeItem(studyInputList[index].id)
                          .then((isSuccess) {
                        setState(() {
                          studyInputList.remove(studyInputList[index]);
                        });
                      });
                    }
                  },
                  child: StudyInputItem(
                      studyInputList: studyInputList, index: index),
                );
              },
            ),
    );
  }
}
