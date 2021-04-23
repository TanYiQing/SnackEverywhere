import 'dart:async';

import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

import 'loginScreen.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Material App', home: SplashScreen());
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 4),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginScreen())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            Container(
              child: Image.asset(
                "assets/images/splashscreen.png",
                fit: BoxFit.cover,
                height: double.infinity,
                width: double.infinity,
                alignment: Alignment.center,
              ),
            ),
            Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Container(
                    height: 350,
                    width: 350,
                    child: Image.asset(
                      "assets/images/Logo.png",
                    ))
              ]),
              Container(
                height: 20.0,
                child: AnimatedTextKit(
                  animatedTexts: [
                    WavyAnimatedText('Loading...',
                        textStyle: TextStyle(fontSize: 20,color: Colors.white))
                  ],
                  isRepeatingAnimation: true,
                ),
              )
            ]),
            Positioned(
                bottom: 48.0,
                left: 10.0,
                right: 10.0,
                child: Image.asset("assets/images/bluellp.png")),
            Positioned(
                top: 10.0,
                left: 120.0,
                right: 10.0,
                child: Image.asset("assets/images/candyPurple.png")),
            Positioned(
                bottom: 30.0,
                left: 10.0,
                right: 120.0,
                child: Image.asset("assets/images/candyRed.png")),
            Positioned(
                top: 0.0,
                left: 10.0,
                right: 150.0,
                child: Image.asset("assets/images/candyYellow.png")),
            Positioned(
                left: 250.0,
                right: 50.0,
                bottom: 10,
                child: Image.asset("assets/images/chip.png")),
            Positioned(
                top: 400,
                left: 0.0,
                right: 200.0,
                bottom: 40.0,
                child: Image.asset("assets/images/cookie.png")),
            Positioned(
                top: 400,
                left: 200.0,
                right: 10.0,
                bottom: 100.0,
                child: Image.asset("assets/images/greenllp.png")),
            Positioned(
                top: 100.0,
                left: 120.0,
                right: 10.0,
                child: Image.asset("assets/images/orangellp.png")),
            Positioned(
                top: 150.0,
                left: 10.0,
                right: 150.0,
                child: Image.asset("assets/images/pinkllp.png")),
            Positioned(
                top: 100.0,
                left: 200.0,
                right: 10.0,
                child: Image.asset("assets/images/redllp.png")),
            Positioned(
                bottom: 0.0,
                left: 0.0,
                right: 200.0,
                child: Image.asset("assets/images/yellowllp.png")),
          ],
        ),
      ),
    );
  }
}
