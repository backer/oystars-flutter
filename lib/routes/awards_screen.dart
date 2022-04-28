import 'package:flutter/material.dart';
import 'package:oystars_flutter_app/constants/dimens.dart';
import 'package:oystars_flutter_app/constants/strings.dart';
import 'package:oystars_flutter_app/data.model/award.dart';
import 'package:oystars_flutter_app/widgets/award_display.dart';

class AwardsScreen extends StatefulWidget {
  const AwardsScreen({Key? key, required this.awards, required this.sport})
      : super(key: key);

  final List<Award> awards;
  final String sport;

  @override
  State<StatefulWidget> createState() => AwardsState();
}

class AwardsState extends State<AwardsScreen> {
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenPadding = MediaQuery.of(context).padding;
    var screenHeight = MediaQuery.of(context).size.height -
        screenPadding.top -
        screenPadding.bottom;

    var appBar = AppBar(
      title: Text('${widget.sport} $awardWinners'),
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
                      child: AwardDisplay(award: e)))
                  .toList()
            ]),
          )),
    );
  }
}
