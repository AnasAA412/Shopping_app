import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final String name;
  final String imagePath;
  const CategoryCard({required this.name, required this.imagePath, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90,
      margin: EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.blue.shade100),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Category image
          Container(
            height: 48,
            width: 48,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            child: Image.asset(imagePath, fit: BoxFit.contain),
          ),
          SizedBox(height: 8),
          // Category name
          Text(
            name,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade700,
              fontSize: 15,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
