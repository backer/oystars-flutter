import 'package:oystars_flutter_app/constants/strings.dart';
import 'package:oystars_flutter_app/data.model/soccer_player.dart';

class SoccerSeason {
  final String id;
  final int year;
  final int session;
  final List<SoccerPlayer> players;

  SoccerSeason(this.id, this.year, this.session, this.players);

  SoccerSeason.fromJson(Map<String, dynamic> json)
      : id = json[jsonId],
        year = json[jsonYear],
        session = json[jsonSession],
        players = playersObjectToList(json[jsonPlayers]);

  Map<String, dynamic> toJson() => {
        jsonId: id,
        jsonYear: year,
        jsonSession: session,
        jsonPlayers: playersListToJsonObject(players)
      };

  // convert players object in response to list of players
  // players object is map of player name to player object
  static List<SoccerPlayer> playersObjectToList(Map<String, dynamic> players) {
    List<SoccerPlayer> playersList = [];
    for (var element in players.values) {
      SoccerPlayer player = SoccerPlayer.fromJson(element);
      playersList.add(player);
    }

    return playersList;
  }

  static Map<String, dynamic> playersListToJsonObject(
      List<SoccerPlayer> players) {
    Map<String, dynamic> result = {};

    for (var player in players) {
      result[player.name] = player.toJson();
    }

    return result;
  }
}
