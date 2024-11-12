class TopicModel {
  final String? id;
  final String? subject;
  final String? title;
  final String? title_hi;
  final String? subjectId;

  TopicModel({
    this.id,
    this.subject,
    this.title,
    this.title_hi,
    this.subjectId,
  });

  TopicModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String?,
        subject = json['subject'] as String?,
        title = json['title'] as String?,
        title_hi = json['title_hi'] as String?,
        subjectId = json['subjectId'] as String?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'subject' : subject,
    'title' : title,
    'title_hi' : title_hi,
    'subjectId' : subjectId
  };
  @override
  String toString() {
    return toJson().toString();
  }
}
