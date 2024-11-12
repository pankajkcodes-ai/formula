class SubTopicModel {
  final String? id;
  final String? subject;
  final String? topic;
  final String? title;
  final String? title_hi;
  final String? content;
  final String? content_hi;
  final String? topicId;
  final String? subjectId;

  SubTopicModel( {
    this.id,
    this.subject,
    this.topic,
    this.title,
    this.title_hi,
    this.content,
    this.content_hi,
    this.topicId,
    this.subjectId,
  });

  SubTopicModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String?,
        subject = json['subject'] as String?,
        topic = json['topic'] as String?,
        title = json['title'] as String?,
        title_hi = json['title_hi'] as String?,
        content = json['content'] as String?,
        content_hi = json['content_hi'] as String?,
        topicId = json['topicId'] as String?,
        subjectId = json['subjectId'] as String?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'subject' : subject,
    'topic' : topic,
    'title' : title,
    'title_hi' : title_hi,
    'content' : content,
    'content_hi' : content_hi,
    'topicId' : topicId,
    'subjectId' : subjectId
  };

  @override
  String toString() {
    return toJson().toString();
  }
}