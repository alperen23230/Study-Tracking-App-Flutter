import 'package:StudyTrackingApp/core/models/lesson_model/lesson.dart';
import 'package:StudyTrackingApp/screens/statistics_screen/statistics_screen_view_model.dart';
import 'package:StudyTrackingApp/widgets/lottie_custom_widget.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:date_range_picker/date_range_picker.dart' as DateRagePicker;
import 'package:intl/intl.dart';

class StatisticsScreenView extends StatisticsScreenViewModel {
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
      getChartList();
    });
  }

  void _presentDateRangePicker() async {
    final List<DateTime> picked = await DateRagePicker.showDatePicker(
      context: context,
      initialFirstDate: startDate,
      initialLastDate: endDate,
      firstDate: DateTime(2019),
      lastDate: DateTime(2050),
    );
    if (picked != null && picked.length == 2) {
      setState(() {
        startDate = picked[0];
        endDate = picked[1];
      });
      getChartList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        chartList.isEmpty
            ? LottieCustomWidget(path: "empty")
            : (selectedLesson != null ? buildPieChart() : buildLegendChart()),
        SizedBox(
          height: 20,
        ),
        DropdownButton<Lesson>(
          hint: Text("Ders Seçiniz"),
          value: selectedLesson,
          elevation: 16,
          onChanged: (Lesson newLesson) {
            setState(() {
              selectedLesson = newLesson;
              getChartList();
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
                  getChartList();
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
          onPressed: isDateRange ? _presentDateRangePicker : _presentDatePicker,
        ),
        Text(
          isDateRange
              ? "Seçilen tarih aralığı: ${DateFormat.yMd().format(startDate)} - ${DateFormat.yMd().format(endDate)}"
              : "Seçilen Tarih: ${DateFormat.yMd().format(selectedDate)}",
        ),
      ],
    );
  }

  Container buildPieChart() {
    return Container(
      height: 200,
      child: Card(
        elevation: 6,
        child: new charts.PieChart(
          pieChartList,
          animate: true,
          defaultRenderer: new charts.ArcRendererConfig(
            arcRendererDecorators: [
              new charts.ArcLabelDecorator(
                  labelPosition: charts.ArcLabelPosition.outside)
            ],
          ),
        ),
      ),
    );
  }

  Container buildLegendChart() {
    return Container(
      height: 200,
      child: Card(
        elevation: 6,
        child: charts.BarChart(
          legendChartList,
          animate: true,
          barGroupingType: charts.BarGroupingType.grouped,
          animationDuration: Duration(milliseconds: 500),
          behaviors: [
            new charts.SeriesLegend(
              position: charts.BehaviorPosition.end,
              outsideJustification: charts.OutsideJustification.endDrawArea,
              horizontalFirst: false,
              desiredMaxRows: 4,
              cellPadding: new EdgeInsets.only(right: 4.0, bottom: 4.0),
              entryTextStyle: charts.TextStyleSpec(
                color: charts.Color(r: 127, g: 63, b: 191),
                fontFamily: 'Roboto',
                fontSize: 12,
              ),
            )
          ],
        ),
      ),
    );
  }
}
