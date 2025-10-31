import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class FirebaseProvider extends ChangeNotifier {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  Future<void> addUser(String name, String email, int age) {
    CollectionReference users = _firestore.collection('users');
    return users
        .add({'name': name, 'email': email, 'age': age, 'role': 'user'})
        .then((value) => print("User added successfully"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Future<void> fetchUsers() async {
    try {
      String uid = FirebaseAuth.instance.currentUser!.uid;
      DocumentSnapshot doc = await _firestore
          .collection('users')
          .doc(uid)
          .get();

      if (doc.exists) {
        print('User Data: ${doc.data()}');
      } else {
        print("No such user!");
      }
    } catch (e) {
      print("Failed to fetch user: $e");
    }
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  Future<bool> isAdmin() async {
    final user = _auth.currentUser;

    if (user == null) return false;

    final snap = await _firestore.collection('users').doc(user.uid).get();

    final data = snap.data();

    print("🔥 Firestore Data: $data");

    // Defensive checks to avoid null

    if (data == null) {
      print("⚠️ No document found for UID: ${user.uid}");

      return false;
    }

    final role = data['role'];

    print("👑 Role found: $role");

    return role == 'admin';
  }

 
}
