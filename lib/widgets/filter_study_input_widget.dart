import 'package:StudyTrackingApp/core/models/lesson_model/lesson.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRagePicker;

class FilterStudyInput extends StatefulWidget {
  final List<Lesson> lessonsList;
  final Function filterClicked;

  FilterStudyInput({this.lessonsList, this.filterClicked});

  @override
  _FilterStudyInputState createState() => _FilterStudyInputState(
      lessonsList: lessonsList, filterClicked: filterClicked);
}

class _FilterStudyInputState extends State<FilterStudyInput> {
  Lesson selectedLesson;
  List<Lesson> lessonsList;
  Function filterClicked;

  _FilterStudyInputState({this.lessonsList, this.filterClicked});
  DateTime selectedDate =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  DateTime _startDate =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day)
          .subtract(Duration(days: 7));
  DateTime _endDate =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  var isDateRange = false;

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        selectedDate = pickedDate;
      });
    });
  }

  void _presentDateRangePicker() async {
    final List<DateTime> picked = await DateRagePicker.showDatePicker(
      context: context,
      initialFirstDate: _startDate,
      initialLastDate: _endDate,
      firstDate: DateTime(2019),
      lastDate: DateTime(2050),
    );
    if (picked != null && picked.length == 2) {
      setState(() {
        _startDate = picked[0];
        _endDate = picked[1];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: screenSize.height * 0.4,
      child: Card(
        elevation: 6,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            DropdownButton<Lesson>(
              hint: Text("Ders Seçiniz"),
              value: selectedLesson,
              elevation: 16,
              onChanged: (Lesson newLesson) {
                setState(() {
                  selectedLesson = newLesson;
                });
              },
              items: lessonsList.map<DropdownMenuItem<Lesson>>((Lesson value) {
                return DropdownMenuItem<Lesson>(
                  value: value,
                  child: Text(value.name),
                );
              }).toList(),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Tarih aralığı"),
                Switch(
                  value: isDateRange,
                  onChanged: (value) {
                    setState(() {
                      isDateRange = value;
                    });
                  },
                )
              ],
            ),
            FlatButton(
              child: Text(
                "Tarih Seç",
                style: TextStyle(color: Theme.of(context).accentColor),
              ),
              onPressed:
                  isDateRange ? _presentDateRangePicker : _presentDatePicker,
            ),
            Text(
              isDateRange
                  ? "Seçilen tarih aralığı: ${DateFormat.yMd().format(_startDate)} - ${DateFormat.yMd().format(_endDate)}"
                  : "Seçilen Tarih: ${DateFormat.yMd().format(selectedDate)}",
            ),
            SizedBox(
              height: 15,
            ),
            RaisedButton(
              child: Text(
                "Filtrele",
                style: TextStyle(color: Colors.white),
              ),
              color: Theme.of(context).primaryColor,
              onPressed: () => filterClicked(
                isDateRange,
                selectedDate,
                _startDate,
                _endDate,
                selectedLesson == null ? "" : selectedLesson.id,
              ),
            )
          ],
        ),
      ),
    );
  }
}
