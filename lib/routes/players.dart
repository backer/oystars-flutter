import 'package:flutter/material.dart';
import 'package:oystars_flutter_app/constants/strings.dart';
import 'package:oystars_flutter_app/widgets/statistics_row.dart';

class PlayersScreen extends StatelessWidget {
  const PlayersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var testHeaders = [
      'Players',
      'Goals',
      'Assists',
      'Number',
      'Seasons Played'
    ];
    var testValues = ['Brian Acker', 62, 25, 17, 10];

    var screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text(PLAYERS),
      ),
      body: Container(
          height: screenHeight,
          child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  StatisticsRow(
                    values: testHeaders,
                    isHeaderRow: true,
                  ),
                  StatisticsRow(
                    values: testValues,
                    isHeaderRow: false,
                  )
                ],
              ))),
    );
  }
}
