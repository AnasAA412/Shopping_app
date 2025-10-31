import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/Controller/category_provider.dart';
import 'package:shopping_app/View/Admin/product/widget/addsubCategory.dart';
import 'package:shopping_app/View/common/bottomNavBar.dart';

class AddCategory extends StatefulWidget {
  AddCategory({super.key});

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  String? selectedCategory;

  // Dropdown items
  final List<String> fetch = [];
  final _formkey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController subCateController = TextEditingController();
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
    final categoryProvider = Provider.of<CategoryProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text("Add Category")),
      body: Padding(
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
                    "Add Category to continue",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ],
              ),
              SizedBox(height: 32),
              // Email TextFormField
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  hintText: 'Category Name',
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
              SizedBox(height: 32),
              ElevatedButton(
                onPressed: () => Provider.of<CategoryProvider>(
                  context,
                  listen: false,
                ).addCategory(name: nameController.text),
                child: Text('Submit'),
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

              /// 🟩 Category Dropdown
              categoryProvider.categories.isEmpty
                  ? const Center(child: CircularProgressIndicator())
                  : DropdownButtonFormField<String>(
                      value: selectedCategory,
                      decoration: const InputDecoration(
                        labelText: "Select Category",
                        border: OutlineInputBorder(),
                      ),
                      items: categoryProvider.categories.map((cat) {
                        return DropdownMenuItem(
                          value: cat.id,
                          child: Text(cat.name),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedCategory = value;
                        });
                      },
                    ),

              const SizedBox(height: 16),
              TextFormField(
                controller: subCateController,
                decoration: InputDecoration(
                  hintText: 'Sub Category Name',
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

              const SizedBox(height: 30),

              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => Provider.of<CategoryProvider>(
                  context,
                  listen: false,
                ).addSubcategory(selectedCategory!, subCateController.text),
                child: Text('Add Category'),
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
    );
  }
}
