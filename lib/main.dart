import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
// import 'package:newsapp/Screen/homepage.dart';

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
          // appBar: AppBar(
          //   backgroundColor: Colors.white,
          //   title: const Text(
          //     "MyNews",
          // style: TextStyle(
          //   color: Colors.blue,
          //   fontSize: 40,
          //   fontWeight: FontWeight.w700,
          //   fontStyle: FontStyle.italic,
          // ),
          //   ),
          // ),
          // body: HomePage(),
          body: SplashScreen(),

        ),
      ),
    );
  }
}
