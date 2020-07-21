import 'package:StudyTrackingApp/core/models/study_input_model/study_input.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart' as intl_local_date_data;

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
    intl_local_date_data.initializeDateFormatting();
    final format = DateFormat.yMMMd('tr-TR');
    return ExpansionTile(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "${studyInputList[index].lessonName} - ${studyInputList[index].subjectName} ",
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            "(${format.format(DateTime.fromMillisecondsSinceEpoch(studyInputList[index].date))})",
            style: TextStyle(fontSize: 14, color: Colors.grey),
          )
        ],
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
              SizedBox(
                width: 15,
              ),
              FlatButton(
                child: Text(
                  "Düzenle",
                  style: TextStyle(color: Theme.of(context).accentColor),
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    '/add-study-input',
                    arguments: {
                      'input': studyInputList[index],
                      'forEdit': true
                    },
                  );
                },
              )
            ],
          ),
        )
      ],
    );
  }
}
