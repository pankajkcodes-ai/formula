class SubjectModel {
  final String? id;
  final String? icon;
  final String? title;

  SubjectModel({
    this.id,
    this.icon,
    this.title,
  });

  SubjectModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String?,
        icon = json['icon'] as String?,
        title = json['title'] as String?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'icon' : icon,
    'title' : title
  };

  @override
  String toString() {
    return 'SubjectModel(id: $id, icon: $icon, title: $title)';
  }

}