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
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        backgroundColor: Color(LOGO_BACKGROUND_COLOR),
        body: Center(
          child: Image(image: AssetImage('$IMAGES_PATH$IMAGE_OYSTARS_LOGO')),
        ));
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 5), () async {
      loadHomeScreen(context);
    });
  }

  loadHomeScreen(BuildContext context) {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const HomeScreen()));
  }
}
