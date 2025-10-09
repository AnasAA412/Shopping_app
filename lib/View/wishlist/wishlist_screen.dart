import 'package:flutter/material.dart';
import 'package:shopping_app/View/wishlist/widget/wishlist_card.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> wishlistItems = [
      {
        'imagePath': 'assets/google.png',
        'productName': 'Notebook',
        'price': '₹120',
      },
      {'imagePath': 'assets/google.png', 'productName': 'Pen', 'price': '₹20'},
      {
        'imagePath': 'assets/google.png',
        'productName': 'Chips',
        'price': '₹40',
      },
      {
        'imagePath': 'assets/google.png',
        'productName': 'Earphones',
        'price': '₹499',
      },
    ];
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "Wishlist",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        actions: [Icon(Icons.shopping_cart), SizedBox(width: 10)],
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemCount: wishlistItems.length,
        itemBuilder: (context, index) {
          final item = wishlistItems[index];
          return WishlistCard(
            imagePath: item['imagePath']!,
            productName: item['productName']!,
            price: item['price']!,
            onMoveToCart: () {},
          );
        },
      ),
    );
  }
}
