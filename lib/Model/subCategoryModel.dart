class SubCategory {
  final String id;
  final String name;

  SubCategory({required this.id, required this.name});

  factory SubCategory.fromDoc(Map<String, dynamic> data, String id) {
    return SubCategory(id: id, name: data['name'] ?? '');
  }
}
