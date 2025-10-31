import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/Controller/category_provider.dart';
import 'package:shopping_app/View/Admin/product/widget/addsubCategory.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  String? selectedCategoryId;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<CategoryProvider>(context, listen: false).fetchCategories();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CategoryProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Categories & Subcategories")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            provider.categories.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : DropdownButtonFormField<String>(
                    value: selectedCategoryId,
                    decoration: const InputDecoration(
                      labelText: "Select Category",
                      border: OutlineInputBorder(),
                    ),
                    items: provider.categories.map((cat) {
                      return DropdownMenuItem(
                        value: cat.id,
                        child: Text(cat.name),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedCategoryId = value;
                      });
                    },
                  ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              icon: const Icon(Icons.add),
              label: const Text("Add Subcategory"),
              onPressed: selectedCategoryId == null
                  ? null
                  : () {
                      showDialog(
                        context: context,
                        builder: (_) => AddSubcategoryDialog(
                          categoryId: selectedCategoryId!,
                        ),
                      );
                    },
            ),
          ],
        ),
      ),
    );
  }
}
