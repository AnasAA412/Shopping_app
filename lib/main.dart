import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/Controller/cart_provider.dart';
import 'package:shopping_app/Controller/category_provider.dart';
import 'package:shopping_app/Controller/product_provider.dart';
import 'package:shopping_app/Controller/provider.dart';
import 'package:shopping_app/Controller/wishlist_provider.dart';
import 'package:shopping_app/View/auth/auth_wrapper.dart';
import 'package:shopping_app/View/auth/login_screen.dart';
import 'package:shopping_app/View/auth/sign_up_screen.dart';

import 'package:shopping_app/View/common/bottomNavBar.dart';
import 'package:shopping_app/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => FirebaseProvider()),
        ChangeNotifierProvider(create: (context) => CategoryProvider()),
        ChangeNotifierProvider(create: (context) => ProductProvider()),
        ChangeNotifierProvider(create: (context) => CartProvider()),
        ChangeNotifierProvider(create: (context) => WishlistProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),

        routes: {
          '/': (context) => AuthWrapper(),
          'signup': (context) => SignupScreen(),
          'nav': (context) => BottomNavBar(),
          'login': (context) => LoginScreen(),
        },
        initialRoute: '/',
      ),
    );
  }
}
