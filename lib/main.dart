import 'package:StudyTrackingApp/screens/add_lesson_screen/add_lesson_screen.dart';
import 'package:StudyTrackingApp/screens/add_study_input_screen/add_study_input_screen.dart';
import 'package:StudyTrackingApp/screens/splash_screen/splash_screen.dart';
import 'package:StudyTrackingApp/screens/subjects_screen/subjects_screen.dart';
import 'package:StudyTrackingApp/screens/tabs_screen/tabs_screen.dart';
import 'package:flutter/material.dart';
import 'core/helper/custom_color.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Study Tracking App',
      theme: ThemeData(
        primarySwatch: CustomColor.purpleMaterialColor,
        accentColor: CustomColor.tealMaterialColor,
      ),
      initialRoute: "/",
      routes: {
        '/': (ctx) => SplashScreen(),
        '/tabs-screen': (ctx) => TabsScreen(),
        '/add-lesson': (ctx) => AddLessonScreen(),
        '/subjects': (ctx) => SubjectsScreen(),
        '/add-study-input': (ctx) => AddStudyInputScreen(),
      },
    );
  }
}
