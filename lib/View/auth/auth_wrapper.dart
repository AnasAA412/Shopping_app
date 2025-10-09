import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/Controller/provider.dart';
import 'package:shopping_app/View/auth/login_screen.dart';
import 'package:shopping_app/View/common/bottomNavBar.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<FirebaseProvider>(
      builder: (context, value, child) {
        return StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            // 1️⃣ While waiting for auth state
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            }

            // 2️⃣ If not logged in → LoginScreen
            if (!snapshot.hasData) {
              return LoginScreen();
            }

            // 3️⃣ Logged in → check if admin
            return FutureBuilder<bool>(
              future: value.isAdmin(), // your function that checks Firestore
              builder: (context, adminSnapshot) {
                if (adminSnapshot.connectionState == ConnectionState.waiting) {
                  return const Scaffold(
                    body: Center(child: CircularProgressIndicator()),
                  );
                }

                if (adminSnapshot.hasData && adminSnapshot.data == true) {
                  // ✅ Admin user
                  return const Text('vxfg'); // your admin home screen
                } else {
                  // 👤 Normal user
                  return const BottomNavBar(); // user home
                }
              },
            );
          },
        );
      },
    );
  }
}
