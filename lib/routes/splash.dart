import 'dart:async';

import 'package:flutter/material.dart';
import 'package:oystars_flutter_app/constants/colors.dart';
import 'package:oystars_flutter_app/constants/strings.dart';

import 'home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return SplashState();
  }
}

class SplashState extends State<SplashScreen> {
  static const splashTimeoutSeconds = 2;

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        backgroundColor: Color(LOGO_BACKGROUND_COLOR),
        body: Center(
          child: Image(
            image: AssetImage('$imagesPath$imageOystarsLogo'),
            width: 512,
            height: 512,
          ),
        ));
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: splashTimeoutSeconds), () async {
      loadHomeScreen(context);
    });
  }

  loadHomeScreen(BuildContext context) {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const HomeScreen()));
  }
}
