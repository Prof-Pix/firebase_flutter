import 'package:firebase_flutter/screens/login_page.dart';
import 'package:firebase_flutter/screens/signup_page.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool showLoginPage = true;

  void toggleAuthPage() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginPage(
        showSignupPage: toggleAuthPage,
      );
    } else {
      return SignupPage(
        showLoginPage: toggleAuthPage,
      );
    }
  }
}
