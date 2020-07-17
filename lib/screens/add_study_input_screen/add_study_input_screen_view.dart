import 'package:StudyTrackingApp/core/models/lesson_model/lesson.dart';
import 'package:StudyTrackingApp/core/models/subject_model/subject.dart';
import 'package:StudyTrackingApp/screens/add_study_input_screen/add_study_input_view_model.dart';
import 'package:flutter/material.dart';

class AddStudyInputScreenView extends AddStudyInputScreenViewModel {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text("Çalışma Ekle"),
      ),
      body: Center(
        child: Container(
          width: screenSize.width * 0.8,
          height: screenSize.height * 0.5,
          child: Card(
            elevation: 6,
            child: Container(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  buildLessonDropdown(),
                  buildSubjectDropdown(),
                  SizedBox(
                    height: 15,
                  ),
                  buildStudyNumbersRow(),
                  SizedBox(
                    height: 15,
                  ),
                  buildNetNumberText(context),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    width: screenSize.width * 0.5,
                    child: RaisedButton(
                      child: Text(
                        "Ekle",
                        style: TextStyle(color: Colors.white),
                      ),
                      color: Theme.of(context).primaryColor,
                      onPressed: () => addStudyInput(context),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Text buildNetNumberText(BuildContext context) {
    return Text(
      "Net Sayısı: $netNumber",
      style: TextStyle(
        fontSize: 17,
        color: Theme.of(context).primaryColor,
      ),
    );
  }

  Row buildStudyNumbersRow() {
    return Row(
      children: <Widget>[
        Flexible(
          child: TextField(
            keyboardType: TextInputType.number,
            controller: questionNumberController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'S',
            ),
          ),
        ),
        SizedBox(
          width: 5,
        ),
        Flexible(
          child: TextField(
            keyboardType: TextInputType.number,
            controller: trueNumberController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'D',
            ),
            onChanged: (_) {
              calculateNetNumber();
            },
          ),
        ),
        SizedBox(
          width: 5,
        ),
        Flexible(
          child: TextField(
            keyboardType: TextInputType.number,
            controller: falseNumberController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Y',
            ),
            onChanged: (_) {
              calculateNetNumber();
            },
          ),
        ),
      ],
    );
  }

  DropdownButton<Subject> buildSubjectDropdown() {
    return DropdownButton<Subject>(
      hint: Text("Konu Seçiniz"),
      value: selectedSubject,
      elevation: 16,
      onChanged: (Subject newSubject) {
        setState(() {
          selectedSubject = newSubject;
        });
      },
      items: subjectsList.map<DropdownMenuItem<Subject>>((Subject value) {
        return DropdownMenuItem<Subject>(
          value: value,
          child: Text(value.name),
        );
      }).toList(),
    );
  }

  DropdownButton<Lesson> buildLessonDropdown() {
    return DropdownButton<Lesson>(
      hint: Text("Ders Seçiniz"),
      value: selectedLesson,
      elevation: 16,
      onChanged: (Lesson newLesson) {
        setState(() {
          selectedLesson = newLesson;
          getSubjects().then((_) {
            selectedSubject = subjectsList.first;
          });
        });
      },
      items: lessonsList.map<DropdownMenuItem<Lesson>>((Lesson value) {
        return DropdownMenuItem<Lesson>(
          value: value,
          child: Text(value.name),
        );
      }).toList(),
    );
  }
}
