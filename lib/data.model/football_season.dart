import 'package:oystars_flutter_app/data.model/football_player.dart';

import '../constants/strings.dart';

class FootballSeason {
  final String id;
  final int year;
  final int session;
  final String record;
  final String teamName;
  final List<FootballPlayer> players;

  FootballSeason(this.id, this.year, this.session, this.record, this.teamName,
      this.players);

  FootballSeason.fromJson(Map<String, dynamic> json)
      : id = json[jsonId],
        year = json[jsonYear],
        session = json[jsonSession],
        record = json[jsonRecord],
        teamName = json[jsonTeamName],
        players = playersObjectToList(json[jsonPlayers]);

  // convert players object in response to list of players
  // players object is map of player name to player object
  static List<FootballPlayer> playersObjectToList(
      Map<String, dynamic> players) {
    List<FootballPlayer> playersList = [];
    for (var element in players.values) {
      FootballPlayer player = FootballPlayer.fromJson(element);
      playersList.add(player);
    }

    return playersList;
  }

  static Map<String, dynamic> playersListToJsonObject(
      List<FootballPlayer> players) {
    Map<String, dynamic> result = {};

    for (var player in players) {
      result[player.name] = player.toJson();
    }

    return result;
  }
}
