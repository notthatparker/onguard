import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:onguard/main.dart';
import 'package:tflite/tflite.dart';
import 'package:wakelock/wakelock.dart';

class Homepage extends StatefulWidget {
  Homepage({Key key}) : super(key: key);
  BuildContext context;

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  CameraImage imgCamera;
  CameraController cameraController;
  bool isOn = false;
  String result = "";

  String ans = "";
  Color bgcolor;

  initCamera() {
    cameraController = CameraController(cameras[1], ResolutionPreset.medium);
    cameraController.initialize().then((value) {
      if (!mounted) {
        return;
      }
      setState(() {
        cameraController.startImageStream((imageFromStream) => {
              if (!isOn)
                {
                  isOn = true,
                  imgCamera = imageFromStream,
                  runModelOnFrame(),
                }
            });
        print("camera  half load");
      });
    });
    print("camera  loaded");
  }

  runModelOnFrame() async {
    print("camera  starting");
    if (imgCamera != null) {
      var recog = await Tflite.runModelOnFrame(
        bytesList: imgCamera.planes.map((plane) {
          return plane.bytes;
        }).toList(),
        imageHeight: imgCamera.height,
        imageWidth: imgCamera.width,
        imageMean: 127.5,
        imageStd: 127.5,
        rotation: 90,
        numResults: 1,
        threshold: 0.5,
        asynch: true,
      );
      result = "";
      print("nothing");
      recog.forEach((response) {
        result += response["label"] + "\n";

        print(result);
      });
      setState(() {
        result;
        print("setstate " + "$result");
        check(result);
        // print(result);
      });
      isOn = false;
    } else
      print("shit");
  }

  loadModel() async {
    await Tflite.loadModel(
      model: "assets/models/model.tflite",
      labels: "assets/models/labels.txt",
    );
    print("model loaded");
  }

  bool color = false;

  void check(String res) {
    if (res == "with_mask\n") {
      ans = "You May  Pass";
      // bgcolor = Colors.redAccent[400];
      color = true;
      print("-no mask");
    } else if (res == "without_mask\n") {
      ans = "You May Not Pass";
      color = false; //  bgcolor = Colors.greenAccent[400];
      print("-mask on");
    } else
      print("yea shit");
  }

  @override
  void initState() {
    super.initState();
    initCamera();
    loadModel();
    check(result);
    print(result);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Container(
            child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Container(
                //TODO change color depending om output of image classifier
                color: (color)
                    ? bgcolor = Colors.greenAccent[400]
                    : bgcolor = Colors.redAccent[400]),
            Positioned(
              height: size.height * 0.95,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(10)),
                  height: size.height * 0.95,
                  width: size.width * 0.95,
                  child: (!cameraController.value.isInitialized)
                      ? Container()
                      : AspectRatio(
                          aspectRatio: cameraController.value.aspectRatio,
                          child: CameraPreview(cameraController),
                        ),
                ),
              ),
            ),
            Positioned(
                bottom: 50,
                child: Container(
                    alignment: Alignment.bottomCenter,
                    child: Text(ans,
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.white))))
          ],
        )),
      ),
    );
  }
}
