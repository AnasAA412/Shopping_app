import 'package:flutter/material.dart';

class WishlistCard extends StatelessWidget {
  final String imagePath;
  final String productName;
  final String price;
  final VoidCallback onMoveToCart;

  const WishlistCard({
    required this.imagePath,
    required this.productName,
    required this.price,
    required this.onMoveToCart,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      // margin: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,

      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                imagePath,
                width: 70,
                height: 70,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(width: 26),
            // Product Details
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  productName,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Text(
                  price,
                  style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
            SizedBox(width: 16),
            // Move to Cart Button
            ElevatedButton(
              onPressed: onMoveToCart,
              child: Text('Move to Cart'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                textStyle: TextStyle(fontSize: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
