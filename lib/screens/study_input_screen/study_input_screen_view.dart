import 'package:StudyTrackingApp/screens/study_input_screen/study_input_screen_view_model.dart';
import 'package:StudyTrackingApp/widgets/study_input_item.dart';
import 'package:flutter/material.dart';

class StudyInputScreenView extends StudyInputScreenViewModel {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: studyInputList.length,
      itemBuilder: (context, index) {
        return StudyInputItem(studyInputList: studyInputList, index: index);
      },
    );
  }
}
