import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirebaseProvider extends ChangeNotifier {
  Future<void> addUser(String name, String email, int age) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    return users
        .add({'name': name, 'email': email, 'age': age, 'role': 'user'})
        .then((value) => print("User added successfully"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Future<void> fetchUsers() async {
    try {
      String uid = FirebaseAuth.instance.currentUser!.uid;
      DocumentSnapshot doc = await FirebaseFirestore.instance
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
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final snap = await FirebaseFirestore.instance
        .collection('user')
        .doc(uid)
        .get();
    print(
      '.hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh.......................................${snap.data()?['role']}',
    );
    // log(".hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh.......................................${snap.data()?['role']}");
    return snap.data()?['role'] == 'admin';
  }
}
