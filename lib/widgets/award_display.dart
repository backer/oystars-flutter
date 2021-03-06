import 'package:flutter/material.dart';
import 'package:oystars_flutter_app/constants/colors.dart';
import 'package:oystars_flutter_app/constants/dimens.dart';
import 'package:oystars_flutter_app/constants/strings.dart';
import 'package:oystars_flutter_app/data.model/award.dart';

class AwardDisplay extends StatelessWidget {
  const AwardDisplay({Key? key, required this.award}) : super(key: key);

  final Award award;

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;

    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          margin: const EdgeInsets.only(left: awardTitleMarginLeft),
          child: Text(
            award.award,
            style: const TextStyle(
                fontSize: awardTitleFontSize,
                color: Colors.purple,
                fontWeight: FontWeight.bold),
          ),
        ),
        Container(
            decoration: const BoxDecoration(
                border: Border(
                    top: BorderSide(color: Colors.black),
                    bottom: BorderSide(color: Colors.black))),
            child: Column(children: [
              ...award.winners
                  .map((e) => Row(
                        children: [
                          Container(
                              alignment: Alignment.center,
                              width: screenWidth / 2,
                              height: awardWinnerItemHeight,
                              child: Text(e.name),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black))),
                          Container(
                              alignment: Alignment.center,
                              width: screenWidth / 2,
                              height: awardWinnerItemHeight,
                              child: Text(seasonDisplayName(e.year, e.session)),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black))),
                        ],
                      ))
                  .toList()
            ]))
      ],
    );
  }
}
