import 'package:oystars_flutter_app/constants/strings.dart';

class SoccerAwardWinner {
  final String name;
  final String notableStats;
  final int year;
  final int session;

  SoccerAwardWinner(this.name, this.notableStats, this.year, this.session);

  SoccerAwardWinner.fromJson(Map<String, dynamic> json)
      : name = json[jsonName],
        notableStats = json[jsonNotableStats],
        year = json[jsonYear],
        session = json[jsonSession];

  Map<String, dynamic> toJson() => {
        jsonName: name,
        jsonNotableStats: notableStats,
        jsonYear: year,
        jsonSession: session
      };
}
