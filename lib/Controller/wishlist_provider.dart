
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class WishlistProvider with ChangeNotifier{
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  String? get _userId => _auth.currentUser?.uid;


  List<Map<String, dynamic>> _wishlistItems = [];
  List<Map<String, dynamic>> get wishlistItems => _wishlistItems;


  Future<void> fetchWishlist() async{
    try{
      if(_userId == null) return;

      final snapshot = await _firestore
      .collection('users')
      .doc(_userId)
      .collection('wishlist')
      .get();

      _wishlistItems = snapshot.docs.map((doc) {
        final data = doc.data();
        return {
          'id': doc.id,
          'name': data['name'],
          'imageUrl': data['imageUrl'],
          'price': data['price'],
        };
      }).toList();
      notifyListeners();
    }catch(e){
      debugPrint('Error fetching wishlist: $e');
    }
  }


  /// ❤️ Add item to wishlist
  Future<void> addToWishlist(Map<String, dynamic> product) async {
    try {
      final user = _auth.currentUser;
      if (user == null) return;

      await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('wishlist')
          .doc(product['id'])
          .set(product);

      _wishlistItems.add(product);
      notifyListeners();
    } catch (e) {
      debugPrint("Error adding to wishlist: $e");
    }
  }

  /// 💔 Remove item from wishlist
  Future<void> removeFromWishlist(String productId) async {
    try {
      final user = _auth.currentUser;
      if (user == null) return;

      await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('wishlist')
          .doc(productId)
          .delete();

      _wishlistItems.removeWhere((item) => item['id'] == productId);
      notifyListeners();
    } catch (e) {
      debugPrint("Error removing from wishlist: $e");
    }
  }

  /// 🧠 Check if product is in wishlist
  bool isInWishlist(String productId) {
    return _wishlistItems.any((item) => item['id'] == productId);
  }
}


