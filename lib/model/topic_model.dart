class TopicModel {
  final String? id;
  final String? subject;
  final String? title;
  final String? subjectId;

  TopicModel({
    this.id,
    this.subject,
    this.title,
    this.subjectId,
  });

  TopicModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String?,
        subject = json['subject'] as String?,
        title = json['title'] as String?,
        subjectId = json['subjectId'] as String?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'subject' : subject,
    'title' : title,
    'subjectId' : subjectId
  };
  @override
  String toString() {
    return 'TopicModel(id: $id, subject: $subject, title: $title)';
  }
}