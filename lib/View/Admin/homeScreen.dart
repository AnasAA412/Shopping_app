import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/Controller/provider.dart';
import 'package:shopping_app/View/Admin/product/addProduct.dart';
import 'package:shopping_app/View/Admin/category/add_category.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Drawer Example')),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            // Drawer Header
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person, size: 40, color: Colors.blue),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Ahmed Anas',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  Text(
                    'anas@example.com',
                    style: TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),
            // Drawer Menu Items
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.category),
              title: Text('Add Category'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddCategory()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.category),
              title: Text('Add Product'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddProduct()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.logout, color: Colors.red),
              title: Text('Logout', style: TextStyle(color: Colors.red)),
              onTap: () => Provider.of<FirebaseProvider>(
                context,
                listen: false,
              ).signOut(),
            ),
          ],
        ),
      ),
      body: Center(
        child: Text(
          'Swipe from the left or tap the menu icon to open the drawer.',
        ),
      ),
    );
  }
}
