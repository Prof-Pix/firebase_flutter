import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import './screens/login.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          scaffoldBackgroundColor: const Color(0xffe8e8e8),
          fontFamily: "Poppins"),
      title: 'Flutter Demo',
      home: const Login(),
    );
  }
}
