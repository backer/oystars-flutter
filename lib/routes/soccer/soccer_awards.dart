import 'package:flutter/material.dart';
import 'package:oystars_flutter_app/constants/dimens.dart';
import 'package:oystars_flutter_app/constants/strings.dart';
import 'package:oystars_flutter_app/data.model/award.dart';
import 'package:oystars_flutter_app/widgets/soccer_award_display.dart';

class SoccerAwardsScreen extends StatefulWidget {
  const SoccerAwardsScreen({Key? key, required this.awards}) : super(key: key);

  final List<SoccerAward> awards;

  @override
  State<StatefulWidget> createState() => SoccerAwardsState();
}

class SoccerAwardsState extends State<SoccerAwardsScreen> {
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenPadding = MediaQuery.of(context).padding;
    var screenHeight = MediaQuery.of(context).size.height -
        screenPadding.top -
        screenPadding.bottom;

    var appBar = AppBar(
      title: const Text('$soccer $awardWinners'),
    );

    return Scaffold(
      appBar: appBar,
      body: Container(
          width: screenWidth,
          height: screenHeight - appBar.preferredSize.height,
          child: SingleChildScrollView(
            child: Column(children: [
              ...widget.awards
                  .map((e) => Padding(
                      padding: const EdgeInsets.only(
                          top: awardsScreenVerticalSpacing),
                      child: SoccerAwardDisplay(award: e)))
                  .toList()
            ]),
          )),
    );
  }
}
