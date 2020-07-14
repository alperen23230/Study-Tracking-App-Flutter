import 'package:StudyTrackingApp/widgets/lottie_custom_widget.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 4), () {
      Navigator.of(context).pushReplacementNamed("/tabs-screen");
    });
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: LottieCustomWidget(path: "calender"),
      ),
    );
  }
}
