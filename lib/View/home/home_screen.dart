import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/View/category/category_card.dart';
import 'package:shopping_app/View/common/product_card.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    // print("...................................${user}");
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "Ecom Wala",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        actions: [Icon(Icons.shopping_cart), SizedBox(width: 10)],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  Text(
                    "Welcome, ${user?.displayName ?? "User"}",
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: 48,
              padding: EdgeInsets.symmetric(horizontal: 12),

              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Search Products....",
                    prefixIcon: Icon(Icons.search),
                    suffixIcon: Icon(Icons.mic),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 0,
                      horizontal: 8,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: CarouselSlider(
                options: CarouselOptions(
                  height: 160,
                  autoPlay: true,
                  enlargeCenterPage: true,
                  viewportFraction: 0.9,
                ),
                items:
                    [
                      'assets/amazon-deals.jpg',
                      'assets/Amazon-Deals-34.jpg',
                      'assets/amazon_deals1.jpg',
                    ].map((imagePath) {
                      return Builder(
                        builder: (BuildContext context) {
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.asset(
                              imagePath,
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                          );
                        },
                      );
                    }).toList(),
              ),
            ),
            SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  // Sort Button
                  ElevatedButton.icon(
                    onPressed: () {
                      // TODO: Add sort logic
                    },
                    icon: Icon(Icons.sort),
                    label: Text('Sort'),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      elevation: 1,
                    ),
                  ),
                  SizedBox(width: 8),
                  // Price Dropdown Button
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: DropdownButton<String>(
                      elevation: 2,

                      value: 'Price',
                      items: <String>['Price', 'Low to High', 'High to Low']
                          .map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          })
                          .toList(),
                      onChanged: (String? newValue) {
                        // TODO: Handle price filter change
                      },

                      borderRadius: BorderRadius.circular(20),
                      underline: SizedBox(),

                      style: TextStyle(color: Colors.black, fontSize: 16),
                      dropdownColor: Colors.white,
                    ),
                  ),
                  SizedBox(width: 8),
                  // Filter Button
                  ElevatedButton(
                    onPressed: () {
                      // TODO: Add filter logic
                    },
                    child: Text('Filter'),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      elevation: 1,
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  Text(
                    "Featured Categories",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            CategoryCard(name: 'Notebooks', imagePath: 'assets/google.png'),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  Text(
                    "Trending Products",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(12.0),
              child: SizedBox(
                height: 150,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    ProductCard(
                      name: 'Notebook',
                      price: '₹120',
                      imagePath: 'assets/notebook.webp',
                    ),
                    ProductCard(
                      name: 'Pen',
                      price: '₹20',
                      imagePath: 'assets/women.jpg',
                    ),
                    ProductCard(
                      name: 'Chips',
                      price: '₹40',
                      imagePath: 'assets/chips.png',
                    ),
                    ProductCard(
                      name: 'Earphones',
                      price: '₹499',
                      imagePath: 'assets/earphones.png',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
