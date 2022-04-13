import 'package:flutter/material.dart';
import 'package:oystars_flutter_app/constants/colors.dart';
import 'package:oystars_flutter_app/constants/strings.dart';
import 'package:oystars_flutter_app/utils/utils.dart';
import 'package:oystars_flutter_app/widgets/home_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => HomeState();
}

class HomeState extends State<HomeScreen> {
  static const double verticalSpacing = 20;

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    var iconSize = screenHeight * 0.2;
    var buttonWidth = screenWidth * 0.6;

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
                height: iconSize,
                width: iconSize,
              ),
              Text(
                WELCOME_MESSAGE,
                style: TextStyle(color: Colors.white),
              ),
              HomeButton(
                label: SOCCER,
                onPressed: () => showSnackBar(context, '$SOCCER clicked'),
              ),
              HomeButton(
                label: FOOTBALL,
                onPressed: () => showSnackBar(context, '$FOOTBALL clicked'),
              ),
            ]
                .map((e) => Padding(
                      padding: EdgeInsets.only(bottom: verticalSpacing),
                      child: e,
                    ))
                .toList(),
          ),
        ));
  }
}
