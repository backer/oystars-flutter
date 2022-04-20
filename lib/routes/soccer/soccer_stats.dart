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
  static const sortOptionCleanSheetHalves = 'CS Halves';

  String sortOption = sortOptionGoals;
  String selectedSeason = allTime;
  List<SoccerPlayer> selectedPlayers = [];

  Map<String, List<SoccerPlayer>> seasonPlayersMap = {};

  @override
  void initState() {
    super.initState();
    seasonPlayersMap[allTime] = widget.players;
    for (var season in widget.seasons) {
      seasonPlayersMap[seasonDisplayName(season.year, season.session)] =
          season.players;
    }
  }

  @override
  Widget build(BuildContext context) {
    var headers = [
      playerNameHeader,
      goalsHeader,
      assistsHeader,
      selectedSeason == allTime ? numberHeader : cleanSheetHalvesHeader,
    ];
    var sortOptions = <String>[
      sortOptionGoals,
      sortOptionAssists,
      sortOptionName
    ];
    if (selectedSeason != allTime) {
      sortOptions.add(sortOptionCleanSheetHalves);
    }

    selectedPlayers = seasonPlayersMap[selectedSeason]!;
    sortSelectedPlayers();
    var values = playersToRows(selectedPlayers);

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
        Row(children: [
          Container(
            height: soccerPlayersDropdownRowHeight,
            child: LabeledDropDown(
              label: seasonLabel,
              dropDownSelection: selectedSeason,
              dropDownOptions: seasonPlayersMap.keys.toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedSeason = newValue!;
                  // switch sortOption back to default when changing season
                  sortOption = sortOptionGoals;
                });
              },
            ),
          ),
          Container(
            height: soccerPlayersDropdownRowHeight,
            child: LabeledDropDown(
              label: sortByLabel,
              dropDownSelection: sortOption,
              dropDownOptions: sortOptions,
              onChanged: (String? newValue) {
                setState(() {
                  sortOption = newValue!;
                });
              },
            ),
          ),
        ]),
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
      // final row is number for all time stats or clean_sheet_halves for season stats
      if (selectedSeason == allTime) {
        row.add(player.number > 0 ? player.number : "");
      } else {
        row.add(player.cleanSheetHalves);
      }

      rows.add(row);
    }

    return rows;
  }

  sortSelectedPlayers() {
    switch (sortOption) {
      case sortOptionAssists:
        {
          selectedPlayers.sort((a, b) => -a.assists.compareTo(b.assists));
        }
        break;
      case sortOptionName:
        {
          selectedPlayers.sort((a, b) => a.name.compareTo(b.name));
        }
        break;
      case sortOptionCleanSheetHalves:
        {
          selectedPlayers.sort(
              (a, b) => -a.cleanSheetHalves.compareTo(b.cleanSheetHalves));
        }
        break;
      case sortOptionGoals:
      default:
        {
          selectedPlayers.sort((a, b) => -a.goals.compareTo(b.goals));
        }
    }
  }
}
