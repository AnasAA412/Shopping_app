import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/Controller/cart_provider.dart';
import 'package:shopping_app/Controller/product_provider.dart';
import 'package:shopping_app/Model/productModel.dart';

class ProductDetailsScreen extends StatelessWidget {
  final String productId; // Firestore doc id

  const ProductDetailsScreen({required this.productId, super.key});

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(
      context,
      listen: false,
    );
    final Product? product = productProvider.getProductById(
      productId,
    ); // helper from provider

    if (product == null) {
      return const Scaffold(body: Center(child: Text('Product not found')));
    }

    return Consumer<ProductProvider>(
      builder: (context, ProductProvider, child) => Scaffold(
        backgroundColor: Colors.grey[50],
        appBar: AppBar(
          title: Text(product.name),
          elevation: 0,
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: Colors.black),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 🔹 Product Image
              Center(
                child: Container(
                  height: 250,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: product.imageUrl.isNotEmpty
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.network(
                            product.imageUrl,
                            fit: BoxFit.contain,
                            errorBuilder: (_, __, ___) =>
                                const Icon(Icons.image_not_supported, size: 80),
                          ),
                        )
                      : const Icon(Icons.image, size: 100, color: Colors.grey),
                ),
              ),
              const SizedBox(height: 20),

              // 🔹 Product Name
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Icon(Icons.favorite_outline_sharp, size: 40),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Text(
                    "by ",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black54,
                    ),
                  ),
                  Text(
                    product.brand.isNotEmpty ? product.brand : "Unknown",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // 🔹 Price
              Text(
                "₹${product.price}",
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.green,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),

              // 🔹 Size Selector
              const Text(
                "Select Size",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  _buildSizeOption("M"),
                  const SizedBox(width: 8),
                  _buildSizeOption("L"),
                  const SizedBox(width: 8),
                  _buildSizeOption("XL"),
                  const SizedBox(width: 8),
                  _buildSizeOption("XXL"),
                ],
              ),
              const SizedBox(height: 16),

              // 🔹 Rating or Stock
              // Row(
              //   children: [
              //     Icon(Icons.star, color: Colors.amber[600], size: 20),
              //     const SizedBox(width: 4),
              //     Text(
              //       product.rating?.toString() ?? "4.5",
              //       style: const TextStyle(fontWeight: FontWeight.w500),
              //     ),
              //     const SizedBox(width: 16),
              //     Text(
              //       product.inStock ? "In Stock" : "Out of Stock",
              //       style: TextStyle(
              //         color: product.inStock ? Colors.green : Colors.red,
              //         fontWeight: FontWeight.w500,
              //       ),
              //     ),
              //   ],
              // ),
              const SizedBox(height: 24),

              // 🔹 Description
              const Text(
                "Description",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                product.description.isNotEmpty
                    ? product.description
                    : "No description available.",
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.black87,
                  height: 1.5,
                ),
              ),

              const SizedBox(height: 30),

              // 🔹 Add to Cart Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    final products = Product(
                      id: product.id,
                      name: product.name,
                      description: product.description,
                      brand: product.brand,
                      category: product.category,
                      subcategory: product.subcategory,
                      price: product.price,
                      imageUrl: product.imageUrl,
                    );
                    final cartProvider = Provider.of<CartProvider>(
                      context,
                      listen: false,
                    );

                    cartProvider.addToCart(products);
                  },
                  icon: const Icon(Icons.shopping_cart_outlined),
                  label: const Text(
                    "Add to Cart",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildSizeOption(String size) {
  return GestureDetector(
    onTap: () {
      // TODO: Handle size selection
    },
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[400]!),
      ),
      child: Text(
        size,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
    ),
  );
}
