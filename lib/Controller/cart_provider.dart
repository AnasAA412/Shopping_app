import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/Model/cartModel.dart';
import 'package:shopping_app/Model/productModel.dart';

class CartProvider with ChangeNotifier {
  final _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  List<CartItem> _cartItems = [];

  List<CartItem> get cartItems => _cartItems;

  String? get _userId => _auth.currentUser?.uid;

  // Future<void> addToCart({
  //   required String productId,
  //   required String name,
  //   required String price,
  //   required String imageUrl,
  // }) async {
  //   try {
  //     final user = _auth.currentUser;
  //     if (user == null) return;

  //     final userCart = _firestore
  //         .collection('users')
  //         .doc(user.uid)
  //         .collection('cart')
  //         .doc(productId);

  //     await userCart.set({
  //       'productId': productId,
  //       'name': name,
  //       'price': price,
  //       'imageUrl': imageUrl,
  //       'quantity': 1,
  //       'timestamp': FieldValue.serverTimestamp(),
  //     });

  //     _cartItems.add({
  //       'productId': productId,
  //       'name': name,
  //       'price': price,
  //       'imageUrl': imageUrl,
  //       'quantity': 1,
  //     });

  //     notifyListeners();
  //     debugPrint('Product added to cart');
  //   } catch (e) {
  //     debugPrint('Error adding to cart: $e');
  //   }
  // }

  Future<void> addToCart(Product product) async {
    if (_userId == null) return;

    final ref = _firestore
        .collection('users')
        .doc(_userId)
        .collection('cart')
        .doc(product.id);

    try {
      final doc = await ref.get();
      if (doc.exists) {
        await ref.update({'quantity': FieldValue.increment(1)});
      } else {
        await ref.set({
          'name': product.name,
          'price': product.price,
          'imageUrl': product.imageUrl,
          'quantity': 1,
        });
      }
      await fetchCartItems();
    } catch (e) {
      debugPrint('Error adding to cart: $e');
    }
  }

  Future<void> fetchCartItems() async {
    try {
      if (_userId == null) return;

      final snapshot = await _firestore
          .collection('users')
          .doc(_userId)
          .collection('cart')
          .get();

      _cartItems = snapshot.docs.map((doc) => CartItem.fromDoc(doc)).toList();
      print('Cart Itermssssssssss..........$_cartItems');

      notifyListeners();
    } catch (e) {
      debugPrint('Error fetching cart items: $e');
    }
  }

  // Future<void> increment(String productId) async {
  //   if (_userId == null) return;
  //   await _firestore
  //       .collection('users')
  //       .doc(_userId)
  //       .collection('cart')
  //       .doc(productId)
  //       .update({'quantity': FieldValue.increment(1)});

  //   await fetchCartItems();
  //   notifyListeners();
  // }
  Future<void> increment(String productId) async {
    try {
      if (_userId == null) return;

      final docRef = _firestore
          .collection('users')
          .doc(_userId)
          .collection('cart')
          .doc(productId);

      final doc = await docRef.get();

      if (doc.exists) {
        await docRef.update({'quantity': FieldValue.increment(1)});
        print(
          "Quantity updated''''''''''''''''''''''''''''''''''''''''''''''''''''",
        );
      } else {
        debugPrint('Cart item with productId $productId does not exist');
        print(
          "Quantity not updated''''''''''''''''''''''''''''''''''''''''''''''''''''",
        );
      }

      await fetchCartItems();
      notifyListeners();
    } catch (e) {
      debugPrint('Error incrementing item: $e');
    }
  }

  Future<void> decrement(String productId) async {
  try {
    if (_userId == null) return;

    final docRef = _firestore
        .collection('users')
        .doc(_userId)
        .collection('cart')
        .doc(productId);

    final doc = await docRef.get();

    if (doc.exists) {
      final data = doc.data() as Map<String, dynamic>;
      final currentQty = data['quantity'] ?? 1;

      if (currentQty > 1) {
        await docRef.update({'quantity': FieldValue.increment(-1)});
      } else {
        await docRef.delete(); // remove item if quantity goes to 0
      }
    }

    await fetchCartItems();
    notifyListeners();
  } catch (e) {
    debugPrint('Error decrementing item: $e');
  }
}


  // Future<void> removeFromCart(String productId) async {
  //   try {
  //     final user = _auth.currentUser;
  //     if (user == null) return;

  //     await _firestore
  //         .collection('users')
  //         .doc(user.uid)
  //         .collection('cart')
  //         .doc(productId)
  //         .delete();

  //     _cartItems.removeWhere((item) => item[''] == productId);
  //     notifyListeners();
  //     debugPrint('Product removed from cart');
  //   } catch (e) {
  //     debugPrint('Error removing cart item: $e');
  //   }
  // }
}
