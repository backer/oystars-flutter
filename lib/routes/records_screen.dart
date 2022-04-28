import 'package:flutter/material.dart';
import 'package:oystars_flutter_app/constants/dimens.dart';
import 'package:oystars_flutter_app/constants/strings.dart';
import 'package:oystars_flutter_app/data.model/record.dart';

import '../widgets/stats_table.dart';

class RecordsScreen extends StatefulWidget {
  final List<Record> records;
  final String sport;

  const RecordsScreen({Key? key, required this.records, required this.sport})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => RecordsState();
}

class RecordsState extends State<RecordsScreen> {
  var headers = [recordNameHeader, recordStatHeader, recordHoldersHeader];

  @override
  Widget build(BuildContext context) {
    var values = recordsToRows(orderRecords(widget.records));

    var screenPadding = MediaQuery.of(context).padding;
    var screenHeight = MediaQuery.of(context).size.height -
        screenPadding.top -
        screenPadding.bottom;
    var screenWidth = MediaQuery.of(context).size.width;
    var columnWidth = screenWidth / 3;

    var appBar = AppBar(title: Text('${widget.sport} $records'));

    return Scaffold(
      appBar: appBar,
      body: StatsTable(
        headers: headers,
        values: values,
        tableHeight: screenHeight - appBar.preferredSize.height,
        columnWidth: columnWidth,
        rowHeight: statsItemHeight * 2.5,
      ),
    );
  }

  List<List<dynamic>> recordsToRows(List<Record> records) {
    List<List<dynamic>> rows = [];

    for (var record in records) {
      List<dynamic> row = [];
      row.add(record.recordName);
      row.add(record.recordStat);

      String holdersDisplay = '';
      for (var i = 0; i < record.recordHolders.keys.length; i++) {
        var holder = record.recordHolders.keys.toList()[i];
        List<String> sessions = record.recordHolders[holder]!;

        // construct sesisons display string
        String sessionsDisplay = '(${sessions[0]}';
        if (sessions.length > 1) {
          for (var j = 1; j < sessions.length; j++) {
            sessionsDisplay += ', ${sessions[j]}';
          }
        }
        sessionsDisplay += ')';

        if (i > 0) {
          // add new lines in between multiple record holders
          holdersDisplay += '\n\n';
        }
        holdersDisplay += '$holder\n$sessionsDisplay';
      }
      row.add(holdersDisplay);

      rows.add(row);
    }

    return rows;
  }

  List<Record> orderRecords(List<Record> records) {
    List<Record> individual = [];
    List<Record> team = [];

    for (var e in records) {
      if (e.recordType == recordTypeIndividual) {
        individual.add(e);
      } else {
        team.add(e);
      }
    }

    // sort individual records based on criteria below
    individual.sort((a, b) => compareIndividualRecords(a, b));
    // display sorted individual records first and then team records
    return [...individual, ...team];
  }

  int compareIndividualRecords(Record a, Record b) {
    const String allTimeFragment = 'all time';
    const String inASeason = 'in a season';
    const String inAGame = 'in a game';
    const String goalsLower = 'goals';
    const String assistsLower = 'assists';

    // prioritize all time records over season over indivual game
    bool allTimeA = a.recordName.contains(allTimeFragment);
    bool allTimeB = b.recordName.contains(allTimeFragment);
    if (allTimeA && !allTimeB) {
      return -1;
    } else if (!allTimeA && allTimeB) {
      return 1;
    }

    bool inSeasonA = a.recordName.contains(inASeason);
    bool inSeasonB = b.recordName.contains(inASeason);
    if (inSeasonA && !inSeasonB) {
      return -1;
    } else if (!inSeasonA && inSeasonB) {
      return 1;
    }

    bool inGameA = a.recordName.contains(inAGame);
    bool inGameB = b.recordName.contains(inAGame);
    if (inGameA && !inGameB) {
      return -1;
    } else if (!inGameA && inGameB) {
      return 1;
    }

    // if still even, prioritize goals over assists over other
    bool goalsA = a.recordName.toLowerCase().contains(goalsLower);
    bool goalsB = b.recordName.toLowerCase().contains(goalsLower);
    if (goalsA && !goalsB) {
      return -1;
    } else if (!goalsA && goalsB) {
      return 1;
    }

    bool assistsA = a.recordName.toLowerCase().contains(assistsLower);
    bool assistsB = b.recordName.toLowerCase().contains(assistsLower);
    if (assistsA && !assistsB) {
      return -1;
    } else if (!assistsA && assistsB) {
      return 1;
    }

    // if still even, just return even
    return 0;
  }
}
