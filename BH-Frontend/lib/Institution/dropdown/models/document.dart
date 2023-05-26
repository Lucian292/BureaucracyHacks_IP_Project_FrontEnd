class Document {
  final int documentId;
  final String name;
  final String description;
  final String price;
  final int institutionId;
  final String path;
  final String file;

  Document({
    required this.documentId,
    required this.name,
    required this.description,
    required this.price,
    required this.institutionId,
    required this.path,
    required this.file,
  });

  factory Document.fromJson(Map<String, dynamic> json) {
    return Document(
      documentId: json['document_id'] ?? 0,
      name: json['name'] ?? '0',
      description: json['description'] ?? '0',
      price: json['price'] ?? '0',
      institutionId: json['institution_id'] ?? 0,
      path: json['path'] ?? '0',
      file: json['file'] ?? '0',
    );
  }
}