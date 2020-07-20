import 'package:StudyTrackingApp/core/helper/custom_color.dart';
import 'package:StudyTrackingApp/core/models/chart_model/input_chart_model.dart';
import 'package:StudyTrackingApp/core/models/chart_model/legend_chart_model.dart';
import 'package:StudyTrackingApp/core/models/chart_model/pie_chart_model.dart';
import 'package:StudyTrackingApp/core/models/lesson_model/lesson.dart';
import 'package:StudyTrackingApp/core/models/lesson_model/lesson_database_provider.dart';
import 'package:StudyTrackingApp/core/models/study_input_model/study_input_database_provider.dart';
import 'package:StudyTrackingApp/screens/statistics_screen/statistics_screen.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

abstract class StatisticsScreenViewModel extends State<StatisticsScreen> {
  StudyInputDatabaseProvider studyInputDB;
  LessonDatabaseProvider lessonDB;

  List<charts.Series<LegendChartModel, String>> legendChartList = [];
  List<charts.Series<PieChartModel, String>> pieChartList = [];
  List<InputChartModel> chartList = [];
  DateTime selectedDate =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  DateTime startDate =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day)
          .subtract(Duration(days: 7));
  DateTime endDate =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  var isDateRange = false;
  Lesson selectedLesson;
  List<Lesson> lessonsList = [];

  @override
  void initState() {
    super.initState();
    studyInputDB = StudyInputDatabaseProvider();
    lessonDB = LessonDatabaseProvider();
    studyInputDB.open().then((_) {
      getChartList();
    });
    lessonDB.open().then((_) {
      getLessons();
    });
  }

  Future<void> getChartList() async {
    if (selectedLesson == null) {
      if (isDateRange) {
        await studyInputDB
            .getSumListByDateRange(startDate.millisecondsSinceEpoch,
                endDate.millisecondsSinceEpoch)
            .then((list) {
          chartList = list;
        }).then((_) {
          createLegendChartData();
        });
      } else {
        await studyInputDB
            .getSumListByDate(selectedDate.millisecondsSinceEpoch)
            .then((list) {
          chartList = list;
        }).then((_) {
          createLegendChartData();
        });
      }
    } else {
      if (isDateRange) {
        await studyInputDB
            .getSumListByDateRange(startDate.millisecondsSinceEpoch,
                endDate.millisecondsSinceEpoch)
            .then((list) {
          chartList = list;
        }).then((_) {
          createPieChartData();
        });
      } else {
        await studyInputDB
            .getSumListByDate(selectedDate.millisecondsSinceEpoch)
            .then((list) {
          chartList = list;
        }).then((_) {
          createPieChartData();
        });
      }
    }
  }

  Future<void> getLessons() async {
    await lessonDB.getList().then((list) {
      setState(() {
        lessonsList = list;
      });
    });
  }

  void createPieChartData() {
    List<PieChartModel> data = [];
    for (var element in chartList) {
      if (selectedLesson.name == element.lessonName) {
        data.add(PieChartModel('S', element.totalQuestion));
        data.add(PieChartModel('D', element.totalTrue));
        data.add(PieChartModel('Y', element.totalFalse));
        data.add(PieChartModel('Net', element.totalNet.round()));
        break;
      }
    }
    setState(() {
      pieChartList = [
        new charts.Series<PieChartModel, String>(
          id: 'Ders',
          domainFn: (PieChartModel inputs, _) => inputs.numberName,
          measureFn: (PieChartModel inputs, _) => inputs.number,
          data: data,
          // Set a label accessor to control the text of the arc label.
          labelAccessorFn: (PieChartModel row, _) =>
              '${row.numberName}: ${row.number}',
        )
      ];
    });
  }

  void createLegendChartData() {
    List<LegendChartModel> questionData = [];
    List<LegendChartModel> trueData = [];
    List<LegendChartModel> falseData = [];
    List<LegendChartModel> netData = [];
    for (var element in chartList) {
      questionData
          .add(LegendChartModel(element.lessonName, element.totalQuestion));
      trueData.add(LegendChartModel(element.lessonName, element.totalTrue));
      falseData.add(LegendChartModel(element.lessonName, element.totalFalse));
      netData
          .add(LegendChartModel(element.lessonName, element.totalNet.round()));
    }
    setState(() {
      legendChartList = [
        new charts.Series<LegendChartModel, String>(
          seriesColor:
              charts.ColorUtil.fromDartColor(CustomColor.purpleMaterialColor),
          id: 'Soru',
          domainFn: (LegendChartModel inputs, _) => inputs.lessonName,
          measureFn: (LegendChartModel inputs, _) => inputs.number,
          data: questionData,
        ),
        new charts.Series<LegendChartModel, String>(
          seriesColor: charts.ColorUtil.fromDartColor(
              CustomColor.purpleMaterialColor[800]),
          id: 'Doğru',
          domainFn: (LegendChartModel inputs, _) => inputs.lessonName,
          measureFn: (LegendChartModel inputs, _) => inputs.number,
          data: trueData,
        ),
        new charts.Series<LegendChartModel, String>(
          seriesColor: charts.ColorUtil.fromDartColor(
              CustomColor.purpleMaterialColor[500]),
          id: 'Yanlış',
          domainFn: (LegendChartModel inputs, _) => inputs.lessonName,
          measureFn: (LegendChartModel inputs, _) => inputs.number,
          data: falseData,
        ),
        new charts.Series<LegendChartModel, String>(
          seriesColor: charts.ColorUtil.fromDartColor(
              CustomColor.purpleMaterialColor[200]),
          id: 'Net',
          domainFn: (LegendChartModel inputs, _) => inputs.lessonName,
          measureFn: (LegendChartModel inputs, _) => inputs.number,
          data: netData,
        ),
      ];
    });
  }
}
