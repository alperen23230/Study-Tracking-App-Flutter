class InputChartModel {
  String lessonName;
  int totalQuestion;
  int totalTrue;
  int totalFalse;
  double totalNet;

  InputChartModel(
      {this.lessonName,
      this.totalQuestion,
      this.totalTrue,
      this.totalFalse,
      this.totalNet});

  InputChartModel.fromJson(Map<String, dynamic> json) {
    lessonName = json['lessonName'];
    totalQuestion = json['TotalQuestion'];
    totalTrue = json['TotalTrue'];
    totalFalse = json['TotalFalse'];
    totalNet = json['TotalNet'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lessonName'] = this.lessonName;
    data['TotalQuestion'] = this.totalQuestion;
    data['TotalTrue'] = this.totalTrue;
    data['TotalFalse'] = this.totalFalse;
    data['TotalNet'] = this.totalNet;
    return data;
  }
}
