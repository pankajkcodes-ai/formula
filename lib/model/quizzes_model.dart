class QuizzesModel {
  final String? id;
  final String? title;
  final String? status;
  final String? categoryId;
  final String? totalQuestions;
  final String? totalTime;
  final String? totalPoints;

  QuizzesModel({
    this.id,
    this.title,
    this.status,
    this.categoryId,
    this.totalQuestions,
    this.totalTime,
    this.totalPoints,
  });

  QuizzesModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String?,
        title = json['title'] as String?,
        status = json['status'] as String?,
        categoryId = json['categoryId'] as String?,
        totalQuestions = json['totalQuestions'] as String?,
        totalTime = json['totalTime'] as String?,
        totalPoints = json['totalPoints'] as String?;

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'status': status,
        'categoryId': categoryId,
        'totalQuestions': totalQuestions,
        'totalTime': totalTime,
        'totalPoints': totalPoints
      };

  @override
  String toString() {
    return toJson().toString();
  }
}
