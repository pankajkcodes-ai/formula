class PdfCategoryModel {
  final String? id;
  final String? title;
  final String? titleHi;
  final String? status;

  PdfCategoryModel({
    this.id,
    this.title,
    this.titleHi,
    this.status,
  });

  PdfCategoryModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String?,
        title = json['title'] as String?,
        titleHi = json['title_hi'] as String?,
        status = json['status'] as String?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'title' : title,
    'title_hi' : titleHi,
    'status' : status
  };
}