class ResultModel {
  final double totalMarks;
  final double obtainMarks;
  final double percentage;
  final int totalQuestions;
  final int correctAnswers;
  final int wrongAnswers;
  final int notAttempt;
  final int totalTime;
 final  Map<int, String> selectedOptionIndices;

  ResultModel(
      {required this.totalMarks,
      required this.obtainMarks,
      required this.percentage,
      required this.totalQuestions,
      required this.correctAnswers,
      required this.wrongAnswers,
      required this.notAttempt,
      required this.totalTime,
      required this.selectedOptionIndices});

  factory ResultModel.fromJson(Map<String, dynamic> json) {
    return ResultModel(
      totalMarks: json['totalMarks'],
      obtainMarks: json['obtainMarks'],
      percentage: json['percentage'],
      totalQuestions: json['totalQuestions'],
      correctAnswers: json['correctAnswers'],
      wrongAnswers: json['wrongAnswers'],
      notAttempt: json['notAttempt'],
      totalTime: json['totalTime'],
      selectedOptionIndices: json['selectedOptionIndices'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'totalMarks': totalMarks,
      'obtainMarks': obtainMarks,
      'percentage': percentage,
      'totalQuestions': totalQuestions,
      'correctAnswers': correctAnswers,
      'wrongAnswers': wrongAnswers,
      'notAttempt': notAttempt,
      'totalTime': totalTime,
      'selectedOptionIndices': selectedOptionIndices,
    };
  }

  @override
  String toString() {
    return toJson().toString();
  }
}
