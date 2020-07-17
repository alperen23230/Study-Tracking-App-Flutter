import 'package:StudyTrackingApp/screens/add_lesson_screen/add_lesson_screen_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class AddLessonScreenView extends AddLessonViewModel {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context)
              .pushNamedAndRemoveUntil('/tabs-screen', (route) => false),
        ),
        title: Text("Ders Ekle"),
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
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  buildTextField(),
                  SizedBox(
                    height: 10,
                  ),
                  buildColorPickerRow(context),
                  SizedBox(
                    height: 10,
                  ),
                  buildAddLessonButton(screenSize, context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Container buildAddLessonButton(Size screenSize, BuildContext context) {
    return Container(
      width: screenSize.width * 0.5,
      child: RaisedButton(
        child: Text(
          "Ekle",
          style: TextStyle(color: Colors.white),
        ),
        color: Theme.of(context).primaryColor,
        onPressed: addLesson,
      ),
    );
  }

  Row buildColorPickerRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        FlatButton(
          child: Text(
            "Renk Seçiniz",
            style: TextStyle(
              fontSize: 17,
              color: Theme.of(context).primaryColor,
            ),
          ),
          onPressed: showColorPicker,
        ),
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: currentColor,
          ),
        ),
      ],
    );
  }

  TextField buildTextField() {
    return TextField(
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Ders Adı',
      ),
      controller: lessonNameController,
    );
  }

  void showColorPicker() {
    showDialog(
      context: context,
      child: AlertDialog(
        title: const Text('Renk Seçin!'),
        content: SingleChildScrollView(
          child: ColorPicker(
            pickerColor: pickerColor,
            onColorChanged: changeColor,
            showLabel: true,
            pickerAreaHeightPercent: 0.8,
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: const Text('Onayla'),
            onPressed: () {
              setState(() => currentColor = pickerColor);
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
