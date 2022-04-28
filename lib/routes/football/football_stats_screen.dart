import 'package:flutter/material.dart';
import 'package:oystars_flutter_app/constants/dimens.dart';
import 'package:oystars_flutter_app/constants/strings.dart';
import 'package:oystars_flutter_app/data.model/football_season.dart';
import 'package:oystars_flutter_app/widgets/labeled_dropdown.dart';
import 'package:oystars_flutter_app/widgets/stats_table.dart';

import '../../data.model/football_player.dart';

class FootballStatsScreen extends StatefulWidget {
  const FootballStatsScreen({Key? key, required this.seasons})
      : super(key: key);

  final List<FootballSeason> seasons;

  @override
  State<StatefulWidget> createState() => FootballStatsState();
}

class FootballStatsState extends State<FootballStatsScreen> {
  static const sortOptionFantasyPoints = 'Fantasy Points';
  static const sortOptionPassing = 'Passing';
  static const sortOptionReceiving = 'Receiving';
  static const sortOptionDefensive = 'Defensive';

  String sortOption = sortOptionFantasyPoints;
  String selectedSeason = allTime;
  List<FootballPlayer> selectedPlayers = [];

  Map<String, List<FootballPlayer>> seasonPlayersMap = {};
  Map<String, bool> yardsRecordedMap = {};

  @override
  void initState() {
    super.initState();
    // sort seasons by year and session
    widget.seasons.sort(((a, b) => -compareSeasons(a, b)));
    seasonPlayersMap[allTime] = calculateAllTimeStats(widget.seasons);
    yardsRecordedMap[allTime] = true;
    for (var season in widget.seasons) {
      seasonPlayersMap[seasonDisplayName(season.year, season.session)] =
          season.players;
      yardsRecordedMap[seasonDisplayName(season.year, season.session)] =
          season.yardsRecorded;
    }
  }

  @override
  Widget build(BuildContext context) {
    var headers = [
      playerNameHeader,
      fantasyPointsHeader,
      '$passing $touchdowns',
      '$passing $interceptions',
      '$passing $patsHeader',
      '$receiving $touchdowns',
      '$receiving $patsHeader',
      '$defensive $sacks',
      '$defensive $interceptions',
      '$defensive $touchdowns'
    ];

    var sortOptions = <String>[
      sortOptionFantasyPoints,
      sortOptionPassing,
      sortOptionReceiving,
      sortOptionDefensive
    ];

    selectedPlayers = seasonPlayersMap[selectedSeason]!;
    sortSelectedPlayers();
    var values =
        playersToRows(selectedPlayers, yardsRecordedMap[selectedSeason]!);

    var screenPadding = MediaQuery.of(context).padding;
    var screenHeight = MediaQuery.of(context).size.height -
        screenPadding.top -
        screenPadding.bottom;
    var screenWidth = MediaQuery.of(context).size.width;
    var columnWidth = screenWidth / 4;
    var appBar = AppBar(
      title: const Text('$football $stats'),
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
                  sortOption = sortOptionFantasyPoints;
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
          tableHeight: screenHeight -
              appBar.preferredSize.height -
              soccerPlayersDropdownRowHeight,
          columnWidth: columnWidth,
        )
      ]),
    );
  }

  List<List<dynamic>> playersToRows(
      List<FootballPlayer> players, bool yardsRecorded) {
    List<List<dynamic>> rows = [];

    for (var player in players) {
      List<dynamic> row = [];
      row.add(player.name);
      row.add(calculateTotalFantasyPoints(player, yardsRecorded)
          .toStringAsFixed(2));

      // show passing tds, ints, and pats
      row.add(player.passingTouchdowns);
      row.add(player.passingInterceptions);
      row.add(player.passingPats);

      // show receiving tds and pats
      row.add(player.receivingTouchdowns);
      row.add(player.receivingPats);

      // show defensive sacks, ints, and tds
      row.add(player.defensiveSacks);
      row.add(player.defensiveInterceptions);
      row.add(player.defensiveTouchdowns);

      rows.add(row);
    }

    return rows;
  }

  sortSelectedPlayers() {
    switch (sortOption) {
      case sortOptionPassing:
        {
          selectedPlayers.sort((a, b) => -comparePassing(a, b));
        }
        break;
      case sortOptionReceiving:
        {
          selectedPlayers.sort((a, b) => -compareReceiving(a, b));
        }
        break;
      case sortOptionDefensive:
        {
          selectedPlayers.sort((a, b) => -compareDefensive(a, b));
        }
        break;
      case sortOptionFantasyPoints:
      default:
        {
          selectedPlayers.sort((a, b) =>
              -calculateTotalFantasyPoints(a, yardsRecordedMap[selectedSeason]!)
                  .compareTo(calculateTotalFantasyPoints(
                      b, yardsRecordedMap[selectedSeason]!)));
        }
    }
  }

  // calculate fantasy points from passing and compare
  int comparePassing(FootballPlayer a, FootballPlayer b) {
    const double passingTouchdownValue = 4;
    const double passingInterceptionValue = -2;
    const double passingPatValue = 1;
    const double passingYardValue = 0.04;

    double passingFantasyPointsA =
        (a.passingTouchdowns * passingTouchdownValue) +
            (a.passingInterceptions * passingInterceptionValue) +
            (a.passingPats * passingPatValue) +
            (a.passingYards * passingYardValue);

    double passingFantasyPointsB =
        (b.passingTouchdowns * passingTouchdownValue) +
            (b.passingInterceptions * passingInterceptionValue) +
            (b.passingPats * passingPatValue) +
            (b.passingYards * passingYardValue);

    return passingFantasyPointsA.compareTo(passingFantasyPointsB);
  }

  // calculate fantasy points from receiving and compare
  int compareReceiving(FootballPlayer a, FootballPlayer b) {
    const double receivingTouchdownValue = 6;
    const double receivingPatValue = 1.5;
    const double receivingYardValue = 0.1;
    const double receivingReceptionValue = 0.5;

    double receivingFantasyPointsA =
        (a.receivingTouchdowns * receivingTouchdownValue) +
            (a.receivingPats * receivingPatValue) +
            (a.receivingYards * receivingYardValue) +
            (a.receivingReceptions * receivingReceptionValue);

    double receivingFantasyPointsB =
        (b.receivingTouchdowns * receivingTouchdownValue) +
            (b.receivingPats * receivingPatValue) +
            (b.receivingYards * receivingYardValue) +
            (b.receivingReceptions * receivingReceptionValue);

    return receivingFantasyPointsA.compareTo(receivingFantasyPointsB);
  }

  // calculate defensive fantasy points and compare
  int compareDefensive(FootballPlayer a, FootballPlayer b) {
    const double defensiveTouchdownValue = 6;
    const double defensiveInterceptionValue = 4;
    const double defensiveSackValue = 2;

    double defensiveFantasyPointsA =
        (a.defensiveTouchdowns * defensiveTouchdownValue) +
            (a.defensiveInterceptions * defensiveInterceptionValue) +
            (a.defensiveSacks * defensiveSackValue);

    double defensiveFantasyPointsB =
        (b.defensiveTouchdowns * defensiveTouchdownValue) +
            (b.defensiveInterceptions * defensiveInterceptionValue) +
            (b.defensiveSacks * defensiveSackValue);

    return defensiveFantasyPointsA.compareTo(defensiveFantasyPointsB);
  }

  // sort seasons based on year and session number
  int compareSeasons(FootballSeason a, FootballSeason b) {
    var result = a.year.compareTo(b.year);
    if (result == 0) {
      result = a.session.compareTo(b.session);
    }
    return result;
  }

  List<FootballPlayer> calculateAllTimeStats(List<FootballSeason> seasons) {
    Map<String, FootballPlayer> allTimePlayers = {};

    for (var season in seasons) {
      for (var player in season.players) {
        if (allTimePlayers.containsKey(player.name)) {
          // add all of player's stats to existing entry
          FootballPlayer sourcePlayer = allTimePlayers[player.name]!;
          FootballPlayer updatedPlayer = FootballPlayer(
            player.name,
            sourcePlayer.fantasyPoints + player.fantasyPoints,
            sourcePlayer.passingTouchdowns + player.passingTouchdowns,
            sourcePlayer.passingInterceptions + player.passingInterceptions,
            sourcePlayer.passingPats + player.passingPats,
            sourcePlayer.passingYards + player.passingYards,
            sourcePlayer.passingCompletions + player.passingCompletions,
            sourcePlayer.receivingTouchdowns + player.receivingTouchdowns,
            sourcePlayer.receivingPats + player.receivingPats,
            sourcePlayer.receivingYards + player.receivingYards,
            sourcePlayer.receivingReceptions + player.receivingReceptions,
            sourcePlayer.defensiveSacks + player.defensiveSacks,
            sourcePlayer.defensiveInterceptions + player.defensiveInterceptions,
            sourcePlayer.defensiveTouchdowns + player.defensiveTouchdowns,
          );

          allTimePlayers[player.name] = updatedPlayer;
        } else {
          allTimePlayers[player.name] = player;
        }
      }
    }

    return allTimePlayers.values.toList();
  }

  // calcualtes fantasy points based on all player stats
  // using a different scoring system for when yards are and are not included
  // the fantasy point totals (not per game) returned by the backend are not
  // all accurate, so this is a preferable strategy
  double calculateTotalFantasyPoints(FootballPlayer player, bool withYards) {
    const passingTouchDownValue = 4;
    const passingYardValue = 0.04;
    const passingInterceptionValue = -2;
    const passingPatValue = 1;

    var receivingTouchdownValue = withYards ? 6 : 7;
    var receivingPatValue = withYards ? 1 : 1.5;
    const receivingYardValue = 0.1;
    const receivingReceptionValue = 0.5;

    var defensiveSackValue = withYards ? 1 : 3;
    var defensiveInterceptionValue = withYards ? 3 : 6;
    const defensiveTouchdownValue = 6;

    return (player.passingTouchdowns * passingTouchDownValue) +
        (player.passingYards * passingYardValue) +
        (player.passingInterceptions * passingInterceptionValue) +
        (player.passingPats * passingPatValue) +
        (player.receivingTouchdowns * receivingTouchdownValue) +
        (player.receivingPats * receivingPatValue) +
        (player.receivingYards * receivingYardValue) +
        (player.receivingReceptions * receivingReceptionValue) +
        (player.defensiveSacks * defensiveSackValue) +
        (player.defensiveInterceptions * defensiveInterceptionValue) +
        (player.defensiveTouchdowns * defensiveTouchdownValue);
  }
}
