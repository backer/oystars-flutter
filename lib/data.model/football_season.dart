import 'package:oystars_flutter_app/data.model/football_game.dart';
import 'package:oystars_flutter_app/data.model/football_player.dart';

import '../constants/strings.dart';

class FootballSeason {
  final String id;
  final int year;
  final int session;
  final String record;
  final String teamName;
  final List<FootballPlayer> players;
  final List<FootballGame> games;
  final bool yardsRecorded;

  FootballSeason(this.id, this.year, this.session, this.record, this.teamName,
      this.players, this.games, this.yardsRecorded);

  FootballSeason.fromJson(Map<String, dynamic> json)
      : id = json[jsonId],
        year = json[jsonYear],
        session = json[jsonSession],
        record = json[jsonRecord],
        teamName = json[jsonTeamName],
        players = playersObjectToList(json[jsonPlayers]),
        games = gamesFromJson(json[jsonGames]),
        yardsRecorded = json[jsonYardsRecorded] ?? false;

  Map<String, dynamic> toJson() => {
        jsonId: id,
        jsonYear: year,
        jsonSession: session,
        jsonRecord: record,
        jsonTeamName: teamName,
        jsonPlayers: playersListToJsonObject(players),
        jsonGames: gamesToJson(),
        jsonYardsRecorded: yardsRecorded
      };

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

  static List<FootballGame> gamesFromJson(List<dynamic> jsonArray) {
    List<FootballGame> footballGames = [];

    for (var json in jsonArray) {
      footballGames.add(FootballGame.fromJson(json));
    }

    return footballGames;
  }

  List<Map<String, dynamic>> gamesToJson() {
    List<Map<String, dynamic>> jsonArray = [];

    for (var game in games) {
      jsonArray.add(game.toJson());
    }
    return jsonArray;
  }
}
