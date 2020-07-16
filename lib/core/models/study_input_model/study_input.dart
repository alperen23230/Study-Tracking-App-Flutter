import 'package:StudyTrackingApp/core/database/database_model.dart';

class StudyInput extends DatabaseModel<StudyInput> {
  String id;
  String subjectId;
  String lessonId;
  int questionNumber;
  int trueNumber;
  int falseNumber;
  double netNumber;
  int date;

  StudyInput(
      {this.id,
      this.subjectId,
      this.lessonId,
      this.questionNumber,
      this.trueNumber,
      this.falseNumber,
      this.netNumber,
      this.date});

  StudyInput.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subjectId = json['subjectId'];
    lessonId = json['lessonId'];
    questionNumber = json['questionNumber'];
    trueNumber = json['trueNumber'];
    falseNumber = json['falseNumber'];
    netNumber = json['netNumber'];
    date = json['date'];
  }

  @override
  StudyInput fromJson(Map<String, dynamic> json) {
    return StudyInput.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['subjectId'] = this.subjectId;
    data['lessonId'] = this.lessonId;
    data['questionNumber'] = this.questionNumber;
    data['trueNumber'] = this.trueNumber;
    data['falseNumber'] = this.falseNumber;
    data['netNumber'] = this.netNumber;
    data['date'] = this.date;
    return data;
  }
}
