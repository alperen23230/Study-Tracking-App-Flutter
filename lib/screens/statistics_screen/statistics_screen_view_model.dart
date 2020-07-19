import 'package:StudyTrackingApp/core/database/database_provider.dart';
import 'package:StudyTrackingApp/core/models/study_input_model/study_input_database_provider.dart';
import 'package:StudyTrackingApp/screens/statistics_screen/statistics_screen.dart';
import 'package:flutter/material.dart';

abstract class StatisticsScreenViewModel extends State<StatisticsScreen> {
  StudyInputDatabaseProvider db = StudyInputDatabaseProvider();
}
