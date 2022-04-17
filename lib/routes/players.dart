import 'package:flutter/material.dart';
import 'package:oystars_flutter_app/constants/strings.dart';
import 'package:oystars_flutter_app/data.model/soccer_player.dart';
import 'package:oystars_flutter_app/widgets/stats_table.dart';

class PlayersScreen extends StatefulWidget {
  const PlayersScreen({Key? key, required this.players}) : super(key: key);

  final List<SoccerPlayer> players;

  @override
  State<StatefulWidget> createState() => PlayersState();
}

class PlayersState extends State<PlayersScreen> {
  @override
  Widget build(BuildContext context) {
    var headers = [
      'Player Name',
      'Goals',
      'Assists',
      'Number',
    ];
    sortPlayersByGoals();
    var values = playersToRows(widget.players);
    debugPrint('playersToRows = ${values}');

    var screenPadding = MediaQuery.of(context).padding;
    var screenHeight = MediaQuery.of(context).size.height -
        screenPadding.top -
        screenPadding.bottom;
    var appBar = AppBar(
      title: const Text(PLAYERS),
    );

    return Scaffold(
      appBar: appBar,
      body: StatsTable(
        headers: headers,
        values: values,
        height: screenHeight - appBar.preferredSize.height,
      ),
    );
  }

  List<List<dynamic>> playersToRows(List<SoccerPlayer> players) {
    List<List<dynamic>> rows = [];

    for (var player in players) {
      List<dynamic> row = [];
      row.add(player.name);
      row.add(player.goals);
      row.add(player.assists);
      row.add(player.number > 0 ? player.number : "");

      rows.add(row);
    }

    return rows;
  }

  sortPlayersByGoals() {
    widget.players.sort((a, b) => -a.goals.compareTo(b.goals));
  }
}
