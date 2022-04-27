import 'package:oystars_flutter_app/data.model/football_player.dart';

import '../constants/strings.dart';
import 'football_season.dart';

class FootballGame {
  final String result;
  final int teamScore;
  final int opponentScore;
  final String seasonId;
  final String opponentName;
  final List<FootballPlayer> players;

  FootballGame(this.result, this.teamScore, this.opponentScore, this.seasonId,
      this.opponentName, this.players);

  FootballGame.fromJson(Map<String, dynamic> json)
      : result = json[jsonResult],
        teamScore = json[jsonTeamScore],
        opponentScore = json[jsonOpponentScore],
        seasonId = json[jsonSeasonId],
        opponentName = json[jsonOpponentName],
        players = FootballSeason.playersObjectToList(json[jsonPlayers]);

  Map<String, dynamic> toJson() => {
        jsonResult: result,
        jsonTeamScore: teamScore,
        jsonOpponentScore: opponentScore,
        jsonSeasonId: seasonId,
        jsonOpponentName: opponentName,
        jsonPlayers: FootballSeason.playersListToJsonObject(players)
      };
}
