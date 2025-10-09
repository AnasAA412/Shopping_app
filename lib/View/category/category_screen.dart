import 'package:flutter/material.dart';
import 'package:shopping_app/View/common/OutlinedButton.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "Ecom Wala",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            // Category Cards Row
            Row(
              children: [
                Text(
                  "Sort",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 16),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // TODO: Add button action
                  },
                  child: Text('Newest'),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    elevation: 2,
                    padding: EdgeInsets.all(10),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    // TODO: Add button action
                  },
                  icon: Icon(Icons.keyboard_double_arrow_up),
                  label: Text('Price'),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    elevation: 2,
                    padding: EdgeInsets.all(10),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    // TODO: Add button action
                  },
                  icon: Icon(Icons.keyboard_double_arrow_down),
                  label: Text('Price'),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    elevation: 2,
                    padding: EdgeInsets.all(10),
                  ),
                ),

                ElevatedButton(
                  onPressed: () {
                    // TODO: Add button action
                  },
                  child: Text('Rating'),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    elevation: 2,
                    padding: EdgeInsets.all(10),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Text(
                  "Filters",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 16),
            SizedBox(
              height: 50,
              child: ListView(
                scrollDirection: Axis.horizontal,

                children: [
                  CustomOutlinedButton(label: "Category"),
                  SizedBox(width: 10),
                  CustomOutlinedButton(label: "Price Range"),
                  SizedBox(width: 10),
                  CustomOutlinedButton(label: "Brand"),
                  SizedBox(width: 10),
                  CustomOutlinedButton(label: "In Stock"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
