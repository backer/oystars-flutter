import 'package:flutter/material.dart';
import 'package:oystars_flutter_app/constants/colors.dart';
import 'package:oystars_flutter_app/constants/strings.dart';
import 'package:oystars_flutter_app/utils/utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => HomeState();
}

class HomeState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(LOGO_BACKGROUND_COLOR),
        appBar: AppBar(
          title: const Text(APP_NAME),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image(
                image: AssetImage('$IMAGES_PATH$IMAGE_OYSTARS_LOGO'),
                height: 48,
                width: 48,
              ),
              Text(
                WELCOME_MESSAGE,
                style: TextStyle(color: Colors.white),
              ),
              ElevatedButton(
                  onPressed: () => showSnackBar(context, '$SOCCER clicked'),
                  child: Text(
                    SOCCER,
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  )),
              ElevatedButton(
                  onPressed: () => showSnackBar(context, '$FOOTBALL clicked'),
                  child: Text(FOOTBALL,
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)))
            ],
          ),
        ));
  }
}
