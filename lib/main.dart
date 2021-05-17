import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

//TODO add splashscreen
//TODO add tflite models to the app
//TODO create UI Based on Design attached
//TODO get camera stream.

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Onguard',
      theme: ThemeData(
        primarySwatch: Colors.greenAccent[400],
      ),
    );
  }
}
