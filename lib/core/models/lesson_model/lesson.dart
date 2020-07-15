import 'package:StudyTrackingApp/core/database/database_model.dart';

class Lesson extends DatabaseModel<Lesson> {
  String id;
  String name;
  int lessonColorRed;
  int lessonColorGreen;
  int lessonColorBlue;

  Lesson(
      {this.id,
      this.name,
      this.lessonColorRed,
      this.lessonColorGreen,
      this.lessonColorBlue});

  Lesson.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    name = json['Name'];
    lessonColorRed = json['ColorRed'];
    lessonColorGreen = json['ColorGreen'];
    lessonColorBlue = json['ColorBlue'];
  }

  @override
  Lesson fromJson(Map<String, dynamic> json) {
    return Lesson.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['Name'] = this.name;
    data['ColorRed'] = this.lessonColorRed;
    data['ColorGreen'] = this.lessonColorGreen;
    data['ColorBlue'] = this.lessonColorBlue;
    return data;
  }
}
