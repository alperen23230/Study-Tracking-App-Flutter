import 'package:StudyTrackingApp/core/database/database_model.dart';

class Subject extends DatabaseModel<Subject> {
  String id;
  String name;
  String lessonId;

  Subject({this.id, this.name, this.lessonId});

  Subject.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    lessonId = json['lessonId'];
  }

  @override
  Subject fromJson(Map<String, dynamic> json) {
    return Subject.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['lessonId'] = this.lessonId;
    return data;
  }
}
