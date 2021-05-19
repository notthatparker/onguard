import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:onguard/splashscreen.dart';
import 'package:camera/camera.dart';
import 'package:wakelock/wakelock.dart';

//initilizing the camera
List<CameraDescription> cameras;

Future<void> main() async {
  /*we turn the main function into async one becase
   the app depends on the camera working hence we await
    for it to turn on 
  */
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
  // await Wakelock.enable();

  runApp(MyApp());
}

//done- TODO add splashscreen
//TODO add tflite models to the app
//TODO create UI Based on Design attached
//TODO get camera stream.

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Onguard',
      home: Mysplash(),
    );
  }
}
