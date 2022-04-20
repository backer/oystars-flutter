import 'package:flutter/material.dart';
import 'package:oystars_flutter_app/constants/colors.dart';
import 'package:oystars_flutter_app/constants/strings.dart';
import 'package:oystars_flutter_app/data.model/soccer_season.dart';
import 'package:oystars_flutter_app/network/web_service.dart';
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
                onPressed: () => onSoccerPressed(context),
              ),
              HomeButton(
                label: FOOTBALL,
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
    try {
      List<dynamic> stats =
          await showLoadingSpinner(context, fetchSoccerPlayersAndSeasons());

      List<SoccerPlayer> players;
      List<SoccerSeason> seasons;

      try {
        players = stats[0];
        seasons = stats[1];

        debugPrint('Players response: ${players.toString()}');
        debugPrint('Seasons response: ${seasons.toString()}');

        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>
                SoccerStatsScreen(players: players, seasons: seasons)));
      } catch (e) {
        debugPrint(
            'Error converting players and seasons response: ${e.toString()}');
      }
    } catch (e) {
      debugPrint('Error fetching soccer players and seasons: ${e.toString()}');
    }
  }

  onFootballPressed() async {
    await showLoadingSpinner(
        context, Future.delayed(const Duration(seconds: 2)));
    showSnackBar(context, '$FOOTBALL stats coming soon!');
  }

  Future<List<dynamic>> fetchSoccerPlayersAndSeasons() {
    return Future.wait([fetchSoccerPlayers(), fetchSoccerSeasons()]);
  }
}
