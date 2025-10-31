import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/Controller/category_provider.dart';
import 'package:shopping_app/Controller/product_provider.dart';
import 'package:shopping_app/View/category/category_card.dart';
import 'package:shopping_app/View/common/product_card.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:shopping_app/View/home/widgets/product_details.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isLoading = true;
  @override
  void initState() {
    super.initState();

    _loadData();
  }

  Future<void> _loadData() async {
    final productProvider = Provider.of<ProductProvider>(
      context,
      listen: false,
    );
    final categoryProvider = Provider.of<CategoryProvider>(
      context,
      listen: false,
    );

    await Future.wait([
      categoryProvider.fetchCategories(),
      productProvider.fetchProducts(),
    ]);

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    // final ProductProvider = Provider.of<ProductProvider>(context);
    // final CategoryProvider = Provider.of<CategoryProvider>(context);

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
            Consumer<CategoryProvider>(
              builder: (context, providerrr, child) => FutureBuilder(
                future: providerrr.fetchCategories(),
                builder: (context, snapShot) => Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SizedBox(
                    height: 100,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: providerrr.categories.length,
                      itemBuilder: (context, index) {
                        final category = providerrr.categories[index];
                        return CategoryCard(name: category.name, imagePath: '');
                      },
                    ),
                  ),
                ),
              ),
            ),

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

            Consumer<ProductProvider>(
              builder: (context, provider, child) => FutureBuilder(
                future: provider.fetchProducts(),
                builder: (context, snapshot) => Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SizedBox(
                    height: 370,
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 5,
                        crossAxisSpacing: 5,
                      ),
                      itemCount: provider.products.length,
                      itemBuilder: (context, index) {
                        print(provider.products);
                        final singleProduct = provider.products[index];
                        return ProductCard(
                          imagePath: singleProduct.imageUrl,
                          name: singleProduct.name,
                          price: singleProduct.price,
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ProductDetailsScreen(
                                productId: singleProduct.id,
                              ),
                            ),
                          ),
                        );
                      },
                      // scrollDirection: Axis.horizontal,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
