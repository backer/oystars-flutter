import 'package:flutter/material.dart';
import 'package:oystars_flutter_app/constants/colors.dart';
import 'package:oystars_flutter_app/constants/strings.dart';
import 'package:oystars_flutter_app/network/web_service.dart';
import 'package:oystars_flutter_app/routes/players.dart';
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

    var iconSize = screenHeight * 0.25;
    var topMargin = screenHeight * 0.1;

    return Scaffold(
        backgroundColor: const Color(LOGO_BACKGROUND_COLOR),
        appBar: AppBar(
          title: const Text(APP_NAME),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: topMargin,
              ),
              Image(
                image: AssetImage('$IMAGES_PATH$IMAGE_OYSTARS_LOGO'),
                height: iconSize,
                width: iconSize,
              ),
              Text(
                WELCOME_MESSAGE,
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              HomeButton(
                label: SOCCER,
                onPressed: () => loadPlayersScreen(context),
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

  loadPlayersScreen(BuildContext context) {
    fetchSoccerPlayers().then((value) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => PlayersScreen(
                players: value,
              )));
    }, onError: (error) => debugPrint('Error fetching soccer players: $error'));
  }
}
