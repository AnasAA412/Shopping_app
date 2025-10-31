import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/Controller/category_provider.dart';
import 'package:shopping_app/Controller/product_provider.dart';
import 'package:shopping_app/Model/productModel.dart';
import 'package:shopping_app/View/Admin/product/widget/addsubCategory.dart';
import 'package:shopping_app/View/Admin/product/widget/drop_down.dart';
import 'package:shopping_app/View/common/bottomNavBar.dart';

class AddProduct extends StatefulWidget {
  AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  String? selectedCategory;
  String? selectedSubCategory;

  // Dropdown items
  final List<String> fetch = [];

  final _formkey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController brandController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController imageController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  final _FirebaseAuth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<CategoryProvider>(context, listen: false).fetchCategories();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductProvider>(context);
    final categoryProvider = Provider.of<CategoryProvider>(context);
    return Consumer<CategoryProvider>(
      builder: (context, ctryPrvdr, child) => Scaffold(
        appBar: AppBar(title: Text("Add Product")),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Form(
              key: _formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,

                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Add Product to continue",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 32),
                  // Email TextFormField
                  TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                      hintText: 'Product title',
                      prefixIcon: Icon(Icons.category),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 0,
                        horizontal: 8,
                      ),
                    ),
                  ),

                  SizedBox(height: 16),
                  TextFormField(
                    controller: brandController,
                    decoration: InputDecoration(
                      hintText: 'Brand Name',
                      prefixIcon: Icon(Icons.category),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 0,
                        horizontal: 8,
                      ),
                    ),
                  ),

                  SizedBox(height: 16),

                  /// 🟩 Category Dropdown
                  ctryPrvdr.categories.isEmpty
                      ? const Center(child: CircularProgressIndicator())
                      : DropdownButtonFormField<String>(
                          value: selectedCategory,
                          decoration: const InputDecoration(
                            labelText: "Select Category",
                            border: OutlineInputBorder(),
                          ),
                          items: ctryPrvdr.categories.map((cat) {
                            return DropdownMenuItem(
                              value: cat.id,
                              child: Text(cat.name),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              ctryPrvdr.fetchSubcategory(id: value!);
                              selectedCategory = value;
                            });
                          },
                        ),

                  const SizedBox(height: 16),

                  /// 🟩Sub Category Dropdown
                  ctryPrvdr.subList.isEmpty
                      ? const Center(child: CircularProgressIndicator())
                      : DropdownButtonFormField<String>(
                          value: selectedSubCategory,
                          decoration: const InputDecoration(
                            labelText: "Select Sub Category",
                            border: OutlineInputBorder(),
                          ),
                          items: categoryProvider.subList.map((cat) {
                            return DropdownMenuItem(
                              value: cat.id,
                              child: Text(cat.name),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedSubCategory = value;
                            });
                          },
                        ),

                  const SizedBox(height: 16),

                  SizedBox(height: 16),
                  TextFormField(
                    controller: descriptionController,
                    decoration: InputDecoration(
                      hintText: 'Description',
                      prefixIcon: Icon(Icons.category),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 0,
                        horizontal: 8,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: imageController,
                    decoration: InputDecoration(
                      hintText: 'Upload Image',
                      prefixIcon: Icon(Icons.category),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 0,
                        horizontal: 8,
                      ),
                    ),
                  ),

                  SizedBox(height: 16),
                  TextFormField(
                    controller: priceController,
                    decoration: InputDecoration(
                      hintText: 'Price',
                      prefixIcon: Icon(Icons.category),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 0,
                        horizontal: 8,
                      ),
                    ),
                  ),

                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () async {
                      final FirebaseFirestore _firestore =
                          FirebaseFirestore.instance;
                      final docRef = _firestore
                          .collection('products')
                          .doc(); // create new doc ref
                      final productId = docRef.id;
                      final product = Product(
                        id: productId,
                        name: nameController.text,
                        category: selectedCategory!,
                        brand: brandController.text,
                        subcategory: selectedSubCategory!,
                        description: descriptionController.text,
                        price: priceController.text,
                        imageUrl: imageController.text.trim(),
                      );
                      await provider.addProduct(product);

                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text("Product Added")));

                      nameController.clear();
                      priceController.clear();
                      imageController.clear();
                      brandController.clear();
                      descriptionController.clear();
                    },
                    child: Text('Add Product'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      minimumSize: Size(double.infinity, 48),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      textStyle: TextStyle(fontSize: 16),
                      elevation: 2,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
