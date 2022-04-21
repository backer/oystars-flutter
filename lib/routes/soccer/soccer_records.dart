import 'package:flutter/material.dart';
import 'package:oystars_flutter_app/constants/strings.dart';
import 'package:oystars_flutter_app/data.model/soccer_record.dart';

import '../../widgets/stats_table.dart';

class SoccerRecordsScreen extends StatefulWidget {
  final List<SoccerRecord> records;

  const SoccerRecordsScreen({Key? key, required this.records})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => SoccerRecordsState();
}

class SoccerRecordsState extends State<SoccerRecordsScreen> {
  var appBar = AppBar(title: const Text('$soccer $records'));
  var headers = [recordNameHeader, recordStatHeader, recordHoldersHeader];

  @override
  Widget build(BuildContext context) {
    var values = recordsToRows(widget.records);

    var screenPadding = MediaQuery.of(context).padding;
    var screenHeight = MediaQuery.of(context).size.height -
        screenPadding.top -
        screenPadding.bottom;

    return Scaffold(
      appBar: appBar,
      body: StatsTable(
        headers: headers,
        values: values,
        height: screenHeight - appBar.preferredSize.height,
      ),
    );
  }

  List<List<dynamic>> recordsToRows(List<SoccerRecord> records) {
    List<List<dynamic>> rows = [];

    for (var record in records) {
      List<dynamic> row = [];
      row.add(record.recordName);
      row.add(record.recordStat);

      String holdersDisplay = '';
      for (var holder in record.recordHolders.keys) {
        List<String> sessions = record.recordHolders[holder]!;

        // construct sesisons display string
        String sessionsDisplay = '(${sessions[0]}';
        if (sessions.length > 1) {
          for (var i = 1; i < sessions.length; i++) {
            sessionsDisplay += ', ${sessions[i]}';
          }
        }
        sessionsDisplay += ')';
        holdersDisplay += '$holder $sessionsDisplay\n';
      }
      row.add(holdersDisplay);

      rows.add(row);
    }

    return rows;
  }
}
