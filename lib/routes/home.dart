import 'package:flutter/material.dart';
import 'package:oystars_flutter_app/constants/colors.dart';
import 'package:oystars_flutter_app/constants/strings.dart';
import 'package:oystars_flutter_app/data.model/soccer_season.dart';
import 'package:oystars_flutter_app/network/web_service.dart';
import 'package:oystars_flutter_app/routes/soccer/soccer_landing.dart';
import 'package:oystars_flutter_app/routes/soccer/soccer_stats.dart';
import 'package:oystars_flutter_app/utils/utils.dart';
import 'package:oystars_flutter_app/widgets/home_button.dart';

import '../data.model/soccer_player.dart';

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
          title: const Text(appName),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: topMargin,
              ),
              Image(
                image: AssetImage('$imagesPath$imageOystarsLogo'),
                height: iconSize,
                width: iconSize,
              ),
              Text(
                welcomeMessage,
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              HomeButton(
                label: soccer,
                onPressed: () => onSoccerPressed(context),
              ),
              HomeButton(
                label: football,
                onPressed: () => onFootballPressed(),
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

  onSoccerPressed(BuildContext context) async {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const SoccerLandingScreen()));
  }

  onFootballPressed() async {
    await showLoadingSpinner(
        context, Future.delayed(const Duration(seconds: 2)));
    showSnackBar(context, '$football stats coming soon!');
  }

  Future<List<dynamic>> fetchSoccerPlayersAndSeasons() {
    return Future.wait([fetchSoccerPlayers(), fetchSoccerSeasons()]);
  }
}
