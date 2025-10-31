import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final String id;
  final String name;
  final String description;
  final String price;
  final String brand;
  final String category;
  final String subcategory;
  final String imageUrl;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.brand,
    required this.category,
    required this.subcategory,
    required this.price,
    required this.imageUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "price": price,
      "imageUrl": imageUrl,
      "brand": brand,
      "category": category,
      "subcategory": subcategory,
      "description": description,
    };
  }

  factory Product.fromDoc(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>? ?? {};
    return Product(
      id: doc['id'],
      name: doc['name']?.toString() ?? 'Unknown',
      description: doc['description']?.toString() ?? 'Unknown',
      brand: doc['brand']?.toString() ?? 'Unknown',
      category: doc['category']?.toString() ?? 'Unknown',
      subcategory: doc['subcategory']?.toString() ?? 'Unknown',
      price: doc["price"]?.toString() ?? '0',
      imageUrl: doc['imageUrl']?.toString() ?? '',
    );
  }
}
