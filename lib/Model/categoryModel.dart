// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopping_app/Model/subCategoryModel.dart';

class Category {
  final String id;
  final String name;

  final List<SubCategory> subcategories;

  Category({
    required this.id,
    required this.name,

    this.subcategories = const [],
  });

  factory Category.fromDoc(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Category(id: doc.id, name: data["name"] ?? "");
  }

  Category copyWith({List<SubCategory>? subcategories}) {
    return Category(
      id: id,
      name: name,
      subcategories: subcategories ?? this.subcategories,
    );
  }
}
