import 'package:flutter/material.dart';
import 'package:oystars_flutter_app/constants/colors.dart';
import 'package:oystars_flutter_app/constants/strings.dart';
import 'package:oystars_flutter_app/data.model/award.dart';
import 'package:oystars_flutter_app/data.model/soccer_season.dart';
import 'package:oystars_flutter_app/network/web_service.dart';
import 'package:oystars_flutter_app/routes/awards_screen.dart';
import 'package:oystars_flutter_app/routes/records_screen.dart';
import 'package:oystars_flutter_app/routes/soccer/soccer_stats.dart';
import 'package:oystars_flutter_app/utils/utils.dart';
import 'package:oystars_flutter_app/widgets/home_button.dart';

import '../../data.model/soccer_player.dart';
import '../../data.model/record.dart';

class SoccerLandingScreen extends StatefulWidget {
  const SoccerLandingScreen({Key? key}) : super(key: key);

  @override
  State<SoccerLandingScreen> createState() => SoccerLandingState();
}

class SoccerLandingState extends State<SoccerLandingScreen> {
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
          title: const Text(soccer),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: topMargin,
              ),
              Image(
                image: AssetImage('$imagesPath$imageSoccerIcon'),
                color: Colors.white,
                height: iconSize,
                width: iconSize,
              ),
              HomeButton(
                label: stats,
                onPressed: () => onStatsPressed(context),
              ),
              HomeButton(
                label: records,
                onPressed: () => onRecordsPressed(context),
              ),
              HomeButton(
                label: awards,
                onPressed: () => onAwardsPressed(),
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

  onStatsPressed(BuildContext context) async {
    try {
      List<dynamic> statsList =
          await showLoadingSpinner(context, fetchSoccerPlayersAndSeasons());

      List<SoccerPlayer> players;
      List<SoccerSeason> seasons;

      try {
        players = statsList[0];
        seasons = statsList[1];

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

  onRecordsPressed(BuildContext context) async {
    try {
      List<Record> records =
          await showLoadingSpinner(context, fetchSoccerRecords());
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) =>
              RecordsScreen(records: records, sport: soccer)));
    } catch (e) {
      debugPrint('Error fetching soccer records: ${e.toString()}');
    }
  }

  onAwardsPressed() async {
    try {
      List<Award> awards =
          await showLoadingSpinner(context, fetchSoccerAwards());
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => AwardsScreen(
                awards: awards,
                sport: soccer,
              )));
    } catch (e) {
      debugPrint('Error fetching soccer awards: ${e.toString()}');
    }
  }

  Future<List<dynamic>> fetchSoccerPlayersAndSeasons() {
    return Future.wait([fetchSoccerPlayers(), fetchSoccerSeasons()]);
  }
}
