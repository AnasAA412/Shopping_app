import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/Model/categoryModel.dart';
import 'package:shopping_app/Model/subCategoryModel.dart';

class CategoryProvider with ChangeNotifier {
  final _firestore = FirebaseFirestore.instance;
  List<Category> _categories = [];
  List<SubCategory> subList = [];

  List<Category> get categories => _categories;

  /// Fetch all categories
  Future<void> fetchCategories() async {
    try {
      // fetch collection
      final categorySnapshot = await _firestore.collection("categories").get();

      List<Category> loadedCategories = [];

      for (var catDoc in categorySnapshot.docs) {
        //convert main category
        Category category = Category.fromDoc(catDoc);

        //fetch subcategories

        //Add combined category
        loadedCategories.add(category.copyWith(subcategories: subList));
      }

      _categories = loadedCategories;
      notifyListeners();
    } catch (e) {
      debugPrint("Error fetching categories: $e");
    }
  }

  Future<void> fetchSubcategory({required String id}) async {
    try {
      final subcategoryshot = await _firestore
          .collection("categories")
          .doc(id)
          .collection("subcategories")
          .get();

      subList = subcategoryshot.docs
          .map((subDoc) => SubCategory.fromDoc(subDoc.data(), subDoc.id))
          .toList(); //refresh list
      notifyListeners();
    } catch (e) {
      debugPrint("Error adding category: $e");
    }
  }

  ///Add a new Category
  Future<void> addCategory({required String name}) async {
    try {
      await _firestore.collection("categories").add({"name": name});
      await fetchCategories(); //refresh list
    } catch (e) {
      debugPrint("Error adding category: $e");
    }
  }

  //delete category

  Future<void> deleteCategory(String id) async {
    try {
      await _firestore.collection("categories").doc(id).delete();
      _categories.removeWhere((cat) => cat.id == id);
      notifyListeners();
    } catch (e) {
      debugPrint("Error deleting category: $e");
    }
  }

  Future<void> addSubcategory(String categoryId, String name) async {
    try {
      await _firestore
          .collection("categories")
          .doc(categoryId)
          .collection("subcategories")
          .add({"name": name});
    } catch (e) {
      debugPrint("Error adding subcategory: $e");
    }
  }
}
