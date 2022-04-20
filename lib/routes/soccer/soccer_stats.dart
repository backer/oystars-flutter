import 'package:flutter/material.dart';
import 'package:oystars_flutter_app/constants/dimens.dart';
import 'package:oystars_flutter_app/constants/strings.dart';
import 'package:oystars_flutter_app/data.model/soccer_player.dart';
import 'package:oystars_flutter_app/widgets/labeled_dropdown.dart';
import 'package:oystars_flutter_app/widgets/stats_table.dart';

import '../../data.model/soccer_season.dart';

class SoccerStatsScreen extends StatefulWidget {
  const SoccerStatsScreen(
      {Key? key, required this.players, required this.seasons})
      : super(key: key);

  final List<SoccerPlayer> players;
  final List<SoccerSeason> seasons;

  @override
  State<StatefulWidget> createState() => SoccerStatsState();
}

class SoccerStatsState extends State<SoccerStatsScreen> {
  static const sortOptionGoals = 'Goals';
  static const sortOptionAssists = 'Assists';
  static const sortOptionName = 'Name';

  String sortOption = sortOptionGoals;

  @override
  Widget build(BuildContext context) {
    var headers = [
      'Player Name',
      'Goals',
      'Assists',
      'Number',
    ];
    sortPlayers();
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
      body: Column(children: [
        Container(
          height: soccerPlayersDropdownRowHeight,
          child: LabeledDropDown(
            label: sortByLabel,
            dropDownSelection: sortOption,
            dropDownOptions: <String>[
              sortOptionGoals,
              sortOptionAssists,
              sortOptionName
            ],
            onChanged: (String? newValue) {
              setState(() {
                sortOption = newValue!;
              });
            },
          ),
        ),
        StatsTable(
          headers: headers,
          values: values,
          height: screenHeight -
              appBar.preferredSize.height -
              soccerPlayersDropdownRowHeight,
        )
      ]),
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

  sortPlayers() {
    switch (sortOption) {
      case sortOptionAssists:
        {
          widget.players.sort((a, b) => -a.assists.compareTo(b.assists));
        }
        break;
      case sortOptionName:
        {
          widget.players.sort((a, b) => a.name.compareTo(b.name));
        }
        break;
      case sortOptionGoals:
      default:
        {
          widget.players.sort((a, b) => -a.goals.compareTo(b.goals));
        }
    }
  }
}
