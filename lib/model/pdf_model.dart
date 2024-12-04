class PdfModel {
  final String? id;
  final String? pdfCategory;
  final String? title;
  final String? file;
  final String? fileType;
  final String? language;

  PdfModel({
    this.id,
    this.pdfCategory,
    this.title,
    this.file,
    this.fileType,
    this.language,
  });

  PdfModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String?,
        pdfCategory = json['pdf_category'] as String?,
        title = json['title'] as String?,
        file = json['file'] as String?,
        fileType = json['file_type'] as String?,
        language = json['language'] as String?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'pdf_category' : pdfCategory,
    'title' : title,
    'file' : file,
    'file_type' : fileType,
    'language' : language
  };
}