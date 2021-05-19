import 'package:flutter/material.dart';
import 'package:onguard/homePage.dart';
import 'package:splashscreen/splashscreen.dart';

class Mysplash extends StatefulWidget {
  @override
  _MysplashState createState() => _MysplashState();
}

class _MysplashState extends State<Mysplash> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 10,
      navigateAfterSeconds: Homepage(),
      title: Text(
        'OnGuard',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      image: Image.asset('assets/images/onguard.png'),
      photoSize: 190,
      loadingText: Text("Made by Four'o'Four collective"),
    );
  }
}
