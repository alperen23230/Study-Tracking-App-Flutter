import 'package:StudyTrackingApp/screens/splash_screen/splash_screen.dart';
import 'package:StudyTrackingApp/screens/tabs_screen/tabs_screen.dart';
import 'package:flutter/material.dart';
import 'core/helper/custom_color.dart';
//TO-DO use library on sqlite debug!!!
//import 'package:appspector/appspector.dart';

void main() {
  //WidgetsFlutterBinding.ensureInitialized();
  //runAppSpector();
  runApp(MyApp());
}

/* void runAppSpector() {
  final config = Config()
    ..androidApiKey =
        "android_MmRiNDM2NzItZDcyNi00M2IyLTliYzItZGYzYjkzMGMyZmU2";

  AppSpectorPlugin.run(config);
} */

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
      },
    );
  }
}
