import 'package:oystars_flutter_app/constants/strings.dart';

class SoccerPlayer {
  final String name;
  final int number;
  final int goals;
  final int assists;
  final int cleanSheetHalves;

  SoccerPlayer(
      this.name, this.number, this.goals, this.assists, this.cleanSheetHalves);

  SoccerPlayer.fromJson(Map<String, dynamic> json)
      : name = json[jsonName],
        number = json[jsonNumber] ?? 0,
        goals = json[jsonGoals],
        assists = json[jsonAssists],
        cleanSheetHalves = json[jsonCleanSheetHalves] ?? 0;

  Map<String, dynamic> toJson() => {
        jsonName: name,
        jsonNumber: number,
        jsonGoals: goals,
        jsonAssists: assists,
        jsonCleanSheetHalves: cleanSheetHalves
      };
}
