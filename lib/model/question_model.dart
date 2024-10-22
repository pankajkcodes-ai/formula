class QuestionModel {
  final String? id;
  final String? categoryId;
  final String? quizId;
  final String? question;
  final String? question_hi;
  final String? optionA;
  final String? optionB;
  final String? optionC;
  final String? optionD;
  final String? correctOption;
  final String? solution;
  final String? solution_hi;
  final String? createdAt;
  final String? updatedAt;

  QuestionModel({
    this.id,
    this.categoryId,
    this.quizId,
    this.question,
    this.question_hi,
    this.optionA,
    this.optionB,
    this.optionC,
    this.optionD,
    this.correctOption,
    this.solution,
    this.solution_hi,
    this.createdAt,
    this.updatedAt,
  });

  QuestionModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String?,
        categoryId = json['categoryId'] as String?,
        quizId = json['quizId'] as String?,
        question = json['question'] as String?,
        question_hi = json['question_hi'] as String?,
        optionA = json['optionA'] as String?,
        optionB = json['optionB'] as String?,
        optionC = json['optionC'] as String?,
        optionD = json['optionD'] as String?,
        correctOption = json['correctOption'] as String?,
        solution = json['solution'] as String?,
        solution_hi = json['solution_hi'] as String?,
        createdAt = json['created_at'] as String?,
        updatedAt = json['updated_at'] as String?;

  Map<String, dynamic> toJson() => {
        'id': id,
        'categoryId': categoryId,
        'quizId': quizId,
        'question': question,
        'question_hi': question_hi,
        'optionA': optionA,
        'optionB': optionB,
        'optionC': optionC,
        'optionD': optionD,
        'correctOption': correctOption,
        'solution': solution,
        'solution_hi': solution_hi,
        'created_at': createdAt,
        'updated_at': updatedAt
      };

  @override
  String toString() {
    return toJson().toString();
  }
}
