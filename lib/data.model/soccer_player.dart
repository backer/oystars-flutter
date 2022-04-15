import 'package:oystars_flutter_app/constants/strings.dart';

class SoccerPlayer {
  final String name;
  final int number;
  final int goals;
  final int assists;

  SoccerPlayer(this.name, this.number, this.goals, this.assists);

  SoccerPlayer.fromJson(Map<String, dynamic> json)
      : name = json[jsonName],
        number = json[jsonNumber],
        goals = json[jsonGoals],
        assists = json[jsonAssists];

  Map<String, dynamic> toJson() => {
        jsonName: name,
        jsonNumber: number,
        jsonGoals: goals,
        jsonAssists: assists
      };
}
