class SubTopicModel {
  final String? id;
  final String? subject;
  final String? topic;
  final String? title;
  final String? content;
  final String? topicId;
  final String? subjectId;

  SubTopicModel({
    this.id,
    this.subject,
    this.topic,
    this.title,
    this.content,
    this.topicId,
    this.subjectId,
  });

  SubTopicModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String?,
        subject = json['subject'] as String?,
        topic = json['topic'] as String?,
        title = json['title'] as String?,
        content = json['content'] as String?,
        topicId = json['topicId'] as String?,
        subjectId = json['subjectId'] as String?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'subject' : subject,
    'topic' : topic,
    'title' : title,
    'content' : content,
    'topicId' : topicId,
    'subjectId' : subjectId
  };
}