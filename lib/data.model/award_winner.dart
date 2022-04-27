import 'package:oystars_flutter_app/constants/strings.dart';

class AwardWinner {
  final String name;
  final String notableStats;
  final int year;
  final int session;

  AwardWinner(this.name, this.notableStats, this.year, this.session);

  AwardWinner.fromJson(Map<String, dynamic> json)
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
