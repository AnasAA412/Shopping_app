import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/Model/productModel.dart';

class ProductProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<Product> _products = [];
  List<Product> get products => _products;
  String? productId;

  //Fetch products form Firestore
  Future<void> fetchProducts() async {
    try {
      final snapshot = await _firestore.collection("products").get();
      _products = snapshot.docs.map((doc) {
        final data = doc.data();
        productId = doc.id;
        print('Id..................... $productId');
        debugPrint('Product Data......................: $data');
        debugPrint('Product iddd......................: $productId');
        return Product.fromDoc(doc);
      }).toList();
      notifyListeners();
    } catch (e) {
      debugPrint("Error fetching product: $e");
    }
  }

  Product? getProductById(String id) {
    try {
      return _products.firstWhere((prod) => prod.id == id);
    } catch (e) {
      return null;
    }
  }

  //add new Product
  Future<void> addProduct(Product product) async {
    try {
      await _firestore.collection("products").add(product.toMap());
      await fetchProducts();
    } catch (e) {
      debugPrint("Error adding products: $e");
    }
  }
}
