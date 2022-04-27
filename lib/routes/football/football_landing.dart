import 'package:flutter/material.dart';
import 'package:oystars_flutter_app/constants/colors.dart';
import 'package:oystars_flutter_app/constants/strings.dart';
import 'package:oystars_flutter_app/utils/utils.dart';
import 'package:oystars_flutter_app/widgets/home_button.dart';

class FootballLandingScreen extends StatefulWidget {
  const FootballLandingScreen({Key? key}) : super(key: key);

  @override
  State<FootballLandingScreen> createState() => FootballLandingState();
}

class FootballLandingState extends State<FootballLandingScreen> {
  static const double verticalSpacing = 20;

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    var iconSize = screenHeight * 0.25;
    var topMargin = screenHeight * 0.1;

    return Scaffold(
        backgroundColor: const Color(LOGO_BACKGROUND_COLOR),
        appBar: AppBar(
          title: const Text(football),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: topMargin,
              ),
              Image(
                image: AssetImage('$imagesPath$imageFootballIcon'),
                color: Colors.white,
                height: iconSize,
                width: iconSize,
              ),
              HomeButton(
                label: stats,
                onPressed: () => onStatsPressed(context),
              ),
              HomeButton(
                label: records,
                onPressed: () => onRecordsPressed(context),
              ),
              HomeButton(
                label: awards,
                onPressed: () => onAwardsPressed(),
              ),
            ]
                .map((e) => Padding(
                      padding: EdgeInsets.only(bottom: verticalSpacing),
                      child: e,
                    ))
                .toList(),
          ),
        ));
  }

  onStatsPressed(BuildContext context) async {
    await showLoadingSpinner(
        context, Future.delayed(const Duration(seconds: 2)));
    showSnackBar(context, '$football stats coming soon!');
  }

  onRecordsPressed(BuildContext context) async {
    await showLoadingSpinner(
        context, Future.delayed(const Duration(seconds: 2)));
    showSnackBar(context, '$football records coming soon!');
  }

  onAwardsPressed() async {
    await showLoadingSpinner(
        context, Future.delayed(const Duration(seconds: 2)));
    showSnackBar(context, '$football awards coming soon!');
  }
}
