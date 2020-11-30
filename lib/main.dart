import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sensors/sensors.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Perspective Zoom Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PerspectiveZoomDemo(),
    );
  }
}

class PerspectiveZoomDemo extends StatefulWidget {
  PerspectiveZoomDemo({
    Key key,
  }) : super(key: key);

  @override
  _PerspectiveZoomDemoState createState() => _PerspectiveZoomDemoState();
}

class _PerspectiveZoomDemoState extends State<PerspectiveZoomDemo> {
  AccelerometerEvent acceleration;
  StreamSubscription<AccelerometerEvent> _streamSubscription;

  int planetMotionSensitivity = 4;
  int bgMotionSensitivity = 2;

  @override
  void initState() {
    _streamSubscription = accelerometerEvents.listen((AccelerometerEvent event) {
      setState(() {
        acceleration = event;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _streamSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Stack(
          children: <Widget>[
            AnimatedPositioned(
              duration: Duration(milliseconds: 250),
              top: acceleration.z * bgMotionSensitivity,
              bottom: acceleration.z * -bgMotionSensitivity,
              right: acceleration.x * -bgMotionSensitivity,
              left: acceleration.x * bgMotionSensitivity,
              child: Align(
                child: Image.asset(
                  "assets/images/bg.jpg",
                  height: 1920,
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
            AnimatedPositioned(
              duration: Duration(milliseconds: 250),
              top: acceleration.z * planetMotionSensitivity,
              bottom: acceleration.z * -planetMotionSensitivity,
              right: acceleration.x * -planetMotionSensitivity,
              left: acceleration.x * planetMotionSensitivity,
              child: Align(
                child: Image.asset(
                  "assets/images/earth_2.png",
                  width: 250,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
