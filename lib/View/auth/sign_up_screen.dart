import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/Controller/provider.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emaileditingController = TextEditingController();
  TextEditingController passwordeditingController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  final _firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Login Ecom wala",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
              ),
              SizedBox(height: 32),
              // Email TextFormField
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  hintText: 'Name',
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 0,
                    horizontal: 8,
                  ),
                ),
              ),
              TextFormField(
                controller: ageController,
                decoration: InputDecoration(
                  hintText: 'Age',
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 0,
                    horizontal: 8,
                  ),
                ),
                keyboardType: TextInputType.numberWithOptions(),
              ),
              TextFormField(
                controller: emaileditingController,
                decoration: InputDecoration(
                  hintText: 'Email',
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 0,
                    horizontal: 8,
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'Enter a valid email';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              // Password TextFormField
              TextFormField(
                controller: passwordeditingController,
                decoration: InputDecoration(
                  hintText: 'Password',
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 0,
                    horizontal: 8,
                  ),
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  if (value.length < 6) {
                    return 'Password must be at least 6 characters';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  String message = '';
                  UserCredential createUser;
                  if (_formKey.currentState!.validate()) {
                    try {
                      createUser = await _firebaseAuth
                          .createUserWithEmailAndPassword(
                            // instantiated earlier on: final _firebaseAuth = FirebaseAuth.instance;
                            email: emaileditingController.text.trim(),
                            password: passwordeditingController.text.trim(),
                          );

                      await createUser.user!.updateDisplayName(
                        nameController.text.trim(),
                      );
                      await createUser.user!.reload();
                      Provider.of<FirebaseProvider>(
                        context,
                        listen: false,
                      ).addUser(
                        nameController.text,
                        emaileditingController.text,
                        int.parse(ageController.text),
                      );
                      Future.delayed(const Duration(seconds: 3), () {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          'nav',
                          (route) => false,
                        );
                      });
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'weak-password') {
                        message = 'The password provided is too weak.';
                      } else if (e.code == 'email-already-in-use') {
                        message = 'An account already exists with that email.';
                      }
                      Fluttertoast.showToast(
                        msg: message,
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.SNACKBAR,
                        backgroundColor: Colors.black54,
                        textColor: Colors.white,
                        fontSize: 14.0,
                      );
                    } catch (e) {
                      Fluttertoast.showToast(
                        msg: "Failed: $e",
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.SNACKBAR,
                        backgroundColor: Colors.black54,
                        textColor: Colors.white,
                        fontSize: 14.0,
                      );
                    }
                  }
                },
                child: Text('Sign Up'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  minimumSize: Size(double.infinity, 48),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  textStyle: TextStyle(fontSize: 16),
                  elevation: 2,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text("if you have an account "),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, 'login');
                    },
                    child: Text("Login"),
                  ),
                ],
              ),
              SizedBox(height: 86),

              ElevatedButton.icon(
                icon: Image.asset(
                  'assets/google.png', // Make sure you have this asset
                  height: 24,
                  width: 24,
                ),
                label: Text('Continue with Google'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  minimumSize: Size(double.infinity, 48),
                  side: BorderSide(color: Colors.grey.shade300),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  textStyle: TextStyle(fontSize: 16),
                  elevation: 2,
                ),
                onPressed: () {
                  // TODO: Implement Google Sign-In logic here
                },
              ),

              SizedBox(height: 86),

              Text("@ 2025 CampusCart. All rights reserved"),
            ],
          ),
        ),
      ),
    );
  }
}
