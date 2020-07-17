import 'package:StudyTrackingApp/core/models/study_input_model/study_input.dart';
import 'package:flutter/material.dart';

class StudyInputItem extends StatelessWidget {
  const StudyInputItem({
    Key key,
    @required this.studyInputList,
    @required this.index,
  }) : super(key: key);

  final List<StudyInput> studyInputList;
  final int index;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        "${studyInputList[index].lessonName} - ${studyInputList[index].subjectName}",
        style: TextStyle(
          fontSize: 20,
        ),
      ),
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                width: 15,
              ),
              Text(
                "S: ${studyInputList[index].questionNumber}",
                style: TextStyle(fontSize: 17),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                "D: ${studyInputList[index].trueNumber}",
                style: TextStyle(fontSize: 17),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                "Y: ${studyInputList[index].falseNumber}",
                style: TextStyle(fontSize: 17),
              ),
              SizedBox(
                width: 15,
              ),
              Text(
                "Net: ${studyInputList[index].netNumber}",
                style: TextStyle(
                  fontSize: 17,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
