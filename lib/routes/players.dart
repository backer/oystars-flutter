import 'package:flutter/material.dart';
import 'package:oystars_flutter_app/constants/strings.dart';
import 'package:oystars_flutter_app/widgets/stats_table.dart';

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
    var testValues2 = ['Meagan Elliott', 65, 17, 25, 7];

    List<List<dynamic>> valuesList = [];
    for (var i = 0; i < 40; i++) {
      valuesList.add((i % 2 == 0) ? testValues2 : testValues);
    }
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text(PLAYERS),
      ),
      body: Container(
          height: screenHeight,
          width: screenWidth,
          child: StatsTable(
            headers: testHeaders,
            values: valuesList,
          )),
    );
  }
}
