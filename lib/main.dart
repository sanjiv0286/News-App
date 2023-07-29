import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'Screen/splashscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "News App",
      home: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SplashScreen(),
        ),
      ),
    );
  }
}
