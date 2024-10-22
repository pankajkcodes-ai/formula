class SubjectModel {
  final String? id;
  final String? icon;
  final String? title;
  final String? title_hi;

  SubjectModel({
    this.id,
    this.icon,
    this.title,
    this.title_hi,
  });

  SubjectModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String?,
        icon = json['icon'] as String?,
        title = json['title'] as String?,
        title_hi = json['title_hi'] as String?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'icon' : icon,
    'title' : title,
    'title_hi' : title_hi,
  };

  @override
  String toString() {
    return toJson().toString();
  }

}