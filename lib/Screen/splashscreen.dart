import 'dart:async';
import 'package:flutter/material.dart';

import 'homepage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 10), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomePage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.blue,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            'https://img.freepik.com/premium-vector/man-woman-reading-newspaper-discussing-daily-news-during-meeting-park-chat-bubble-communication_48369-32038.jpg?size=626&ext=jpg&ga=GA1.1.1803221636.1689421772&semt=ais',
            // 'https://img.freepik.com/premium-vector/veterinarians-chatting-during-meeting-medical-doctors-team-discussing-daily-news-chat-bubble-communication-concept-veterinary-clinic-smartphone-screen-mobile-app-template_48369-31842.jpg?size=626&ext=jpg&ga=GA1.1.1803221636.1689421772&semt=ais',
            fit: BoxFit.cover,
            // height: 160,
            // width: 170,
          ),
        ],
      ),
    );
  }
}
