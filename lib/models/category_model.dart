class CategoryModel {
  String id = '', title = '', description = '', image = '';

  CategoryModel({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
  });

  CategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'] ?? '';
    title = json['title'] ?? '';
    description = json['description'] ?? '';
    image = json['image'] ?? '';
  }
}
