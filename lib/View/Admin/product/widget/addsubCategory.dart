import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/Controller/category_provider.dart';


class AddSubcategoryDialog extends StatefulWidget {
  final String categoryId;
  const AddSubcategoryDialog({super.key, required this.categoryId});

  @override
  State<AddSubcategoryDialog> createState() => _AddSubcategoryDialogState();
}

class _AddSubcategoryDialogState extends State<AddSubcategoryDialog> {
  final TextEditingController _controller = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CategoryProvider>(context, listen: false);

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      title: const Text("Add Subcategory"),
      content: TextField(
        controller: _controller,
        decoration: const InputDecoration(
          labelText: "Subcategory Name",
          border: OutlineInputBorder(),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: _isLoading
              ? null
              : () async {
                  final name = _controller.text.trim();
                  if (name.isEmpty) return;
                  setState(() => _isLoading = true);
                  await provider.addSubcategory(widget.categoryId, name);
                  setState(() => _isLoading = false);
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('✅ Subcategory Added')),
                  );
                },
          child: _isLoading
              ? const SizedBox(
                  height: 18,
                  width: 18,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text("Save"),
        ),
      ],
    );
  }
}
